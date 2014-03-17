From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/4] ASoC: simple-card: Simplify code
Date: Mon, 17 Mar 2014 16:24:29 +0000
Message-ID: <20140317162429.GO11706@sirena.org.uk>
References: <cover.1394883134.git.moinejf@free.fr>
 <c74668c9277d538b105ab93affe7d33a64342ee9.1394883134.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmZU9S7l/XJx5q9b"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c74668c9277d538b105ab93affe7d33a64342ee9.1394883134.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org


--ZmZU9S7l/XJx5q9b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 15, 2014 at 11:32:42AM +0100, Jean-Francois Moine wrote:
> The global DAI format is used only in the function
> asoc_simple_card_parse_of(). So, move it from the private data
> to the stack.

Applied, thanks.

--ZmZU9S7l/XJx5q9b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJyG6AAoJELSic+t+oim91gQQAIKf40P8EO2BMSQ4se/bCcdK
LLzRJSybjhLFs6M8rcRFMf2of5TCpAzBoFWa3Wt3c12A1hRN/hGs6Zq4YS0EfjRw
oPKeoDyKsm45Vs3SEBi+mUsHa4D2hwr4L3NpKHtP5RIBXPnefHIxaG9ztUp5cwhz
29sSwf3Uv8GncMK8H2mZ64xyOulJHwji6YjjkK+2Qp1u1/2l4eIlLFznNcjnvPpy
bm10/AegD5adbEqeS6Q68Kracn2IS0OygZT1oReLT1ofBgHQflB4Gz6QnWaLc35Y
NMaUw2kS0zPzGDHgAdYg6n5hUbAY+cQnPmJsCABjj1qlPHVwdooVsX1LFYi6Eh5t
16bNrqHgxLZiAlS1xEdAhWr5Qtsevbykt7P+wB/iWL3jUBI7UEjHNEqQ6PLskzef
ltqfQobmBydtprN9sOqymIbPwjXQDG8fX9Tg0s+ni1YNIxgwO201NOfeuhVPaMpq
ay1Jh1QlPaQLQnbixaKxb6gpxUIu2iGAJXveXV7ai+kvAyjsxCbzk7vjsEayq/jU
6HNLSScwoBoLTpkKG5vDKz734JFpIR86lnbRmX/Qa9GwuTpzbXbmU+BXTwOausrk
bzFKbP46ZGw0Be22YGZpqPNjCfpwOTA+8QTwQ+pGkUSMkCi8BHgajBgqMZBGbeU3
KE65qNX/pzB1WVYwP7td
=1S8r
-----END PGP SIGNATURE-----

--ZmZU9S7l/XJx5q9b--
