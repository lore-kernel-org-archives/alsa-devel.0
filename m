From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: da7210: Minor update for PLL and SRM
Date: Tue, 17 Apr 2012 15:56:18 +0100
Message-ID: <20120417145618.GL6652@opensource.wolfsonmicro.com>
References: <1334674858.13279.9.camel@matrix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jbyekxk18hnEXT0m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1334674858.13279.9.camel@matrix>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--Jbyekxk18hnEXT0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 17, 2012 at 08:30:58PM +0530, Ashish Chavan wrote:

> +		if ((fref == da7210_pll_div[cnt].fref) &&
> +			(da7210->master ==  da7210_pll_div[cnt].mode) &&
> +			(fout == da7210_pll_div[cnt].fout)) {

Since this is just a coding style thing how about lining up the (s for
the branches?

--Jbyekxk18hnEXT0m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjYMqAAoJEBus8iNuMP3d9WQP/ROahhIRDH41PaaWuAgzqrnH
akfSkbUcYvZIaJ4vyDDFnEQ7u/+EZ/tGujzDyjSey8cmaVSW7e17B3F7+1nifapO
F+USacLjy483Rg3fZASPON00gjdNzkFulL9Ysl4g4LQWUq6E1H7yzXyY/Pn2L1Tl
liBrH1RPqs+ShT0hgVnRFtVLWAHpULMBNuAGNzcF8YAsQgP1eyYp2wlw8+zpD3Oq
incD2ljbbfUklCvjFAjH5LeHumen461yCPfW/HBFuGzNMMEkRT78SaaKy6NyTKEa
qG05TAXC77XScBpk8k499J8gUGmyY6H4oDjOmPzo58Pnpg96/I7jpzvAjjVl7jVb
k2i3j87QDsyFZh1Q8+DTpNnDVSJkTQgaRVwuFuvc1oYsH6A2Nep9cuFj6FY9dl1G
XVTikSWyJKhhYOYAPefPw+iqPInLk2cWsDlBIa0wMgS+nZhyKCToLjPRt8/L5kfL
W/ZTKpolTQ5PqwC3g9vWM0zaEL9/N2PzKLgI8HjM3jnoN7thOaOTkK9xX9nW4IK2
CwmmmddcM9quQuFGLL4mxlQhFUHP+DZQjczGb70cM4AKjkn39Z8kGf6SSqnKJwUo
BuMX1aYyDcURg7sUCRR+EGcbH8e1tTa4rf/G1vVyIkHyliAQ7wLg4Ok6o+k86rBT
oHKVOegkdKLnZ1tydxhz
=mI6S
-----END PGP SIGNATURE-----

--Jbyekxk18hnEXT0m--
