### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 896f6942-76a2-11eb-01e9-1156629a4a14
using Pkg;using Plots; gr()

# ╔═╡ 96f51f08-76a2-11eb-1c31-236c2644712c
using LaTeXStrings

# ╔═╡ 8e10fc72-76a2-11eb-1adf-af9432cd1b49
Pkg.add("LaTeXStrings")

# ╔═╡ 0eea2678-7641-11eb-1c89-b53ca4514973
function circleShape(h,k,r)
	θ = LinRange(0,2π,500)
	h .+ r*sin.(θ), k .+ r*cos.(θ)
end

# ╔═╡ 58cc6b66-7641-11eb-2aa0-3b5f7a52eac9
function mohr2D(ϵx,ϵy,ϵxy)
	center = (ϵx+ϵy)/2.
	R = sqrt(((ϵx-ϵy)/2.)^2+ϵxy^2)
	return center,R
end

# ╔═╡ a8d106fa-7641-11eb-0248-1ddac2014484
function mohr2D(ϵ1,ϵ2)
	center = (ϵ1+ϵ2)/2
	R = abs((ϵ1-ϵ2)/2)
	return center,R
end

# ╔═╡ a62626fc-7643-11eb-14ef-c110a134ce50
function plotCircle(ϵ1,ϵ2)
	c,R =  mohr2D(ϵ1,ϵ2)
	p = plot(circleShape(c,0,R),seriestype = [:shape], 		 lw=0.5, c = :blue, linecolor =:black, legend = false, fillalpha = 0.05, aspect_ratio = 1)
	scatter!(p,[c],[0],markercolor = :black)
	scatter!(p,[ϵ1],[0],markercolor = :black)
	scatter!(p,[ϵ2],[0],markercolor = :black)
	xlabel!(L"\varepsilon_n")
	
	ylabel!(L"\tau_n")
	
	
	if R≉0
		annotate!(p, ϵ1 + 0.1*R, 0.1*R, L"\epsilon_1", :color)
		annotate!(p, ϵ2 + 0.1*R, 0.1*R, L"\epsilon_2", :color)
	end
	
	
	if R ≈ 0
		ylims!(-maximum([ϵ1,ϵ2]),maximum([ϵ1,ϵ2]))
	end

	hline!(p,[0], linecolor = :black)
	return p
end

# ╔═╡ eaf4f830-7643-11eb-09e3-e1109e9cdb65
function plotCircle(ϵx,ϵy,ϵxy)
	c,R =  mohr2D(ϵx,ϵy,ϵxy)
	ϵ1 = c + R
	ϵ2 = c - R
	p = plot(circleShape(c,0,R),seriestype = [:shape], 		 lw=0.5, c = :blue, linecolor =:black, legend = false, fillalpha = 0.05, aspect_ratio = 1)
	scatter!(p,[c],[0],markercolor = :black)
	scatter!(p,[ϵ1],[0],markercolor = :black)
	scatter!(p,[ϵ2],[0],markercolor = :black)
	scatter!(p,[ϵx],[ϵxy],markercolor = :blue)
	scatter!(p,[ϵy],[-ϵxy],markercolor = :red)
	
	
	

	plot!(p,[ϵx,ϵy],[ϵxy, -ϵxy],linecolor=:black)
	
	if R≉0
		annotate!(p, ϵ1 + 0.1*R, 0.1*R, L"\epsilon_1", :color)
		annotate!(p, ϵ2 + 0.1*R, 0.1*R, L"\epsilon_2", :color)
		annotate!(p, ϵx+0.06*R, ϵxy+0.1*R, L"X", :color)
		annotate!(p, ϵy+0.06*R, -ϵxy+0.1*R, L"Y", :color)
	end
	
	xlabel!(L"\varepsilon_n")
	
	ylabel!(L"\tau_n")
	if R ≈ 0
		ylims!(-maximum([ϵ1,ϵ2]),maximum([ϵ1,ϵ2]))
		annotate!(p, ϵ1 + 0.1*ϵ1, 0.1*ϵ1, L"\epsilon_1 = \epsilon_2 = C", :color)
	end
	
	hline!(p,[0], linecolor = :black)
	return p
end

# ╔═╡ d56c2fda-7641-11eb-29e8-579e1f95cada
begin
	ϵ1 = 1.
	ϵ2 = 5.
	p = plotCircle(3,5,2)
end

# ╔═╡ Cell order:
# ╠═d56c2fda-7641-11eb-29e8-579e1f95cada
# ╠═896f6942-76a2-11eb-01e9-1156629a4a14
# ╠═8e10fc72-76a2-11eb-1adf-af9432cd1b49
# ╠═96f51f08-76a2-11eb-1c31-236c2644712c
# ╠═0eea2678-7641-11eb-1c89-b53ca4514973
# ╠═58cc6b66-7641-11eb-2aa0-3b5f7a52eac9
# ╠═a8d106fa-7641-11eb-0248-1ddac2014484
# ╠═a62626fc-7643-11eb-14ef-c110a134ce50
# ╠═eaf4f830-7643-11eb-09e3-e1109e9cdb65
