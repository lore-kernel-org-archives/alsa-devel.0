From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/5] ASoC/MFD: twl6040: Remove codec driver local reg
 cache
Date: Thu, 19 Dec 2013 18:37:32 +0000
Message-ID: <20131219183732.GG31886@sirena.org.uk>
References: <1385733827-19831-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mOKeRhn3B7HglGBY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385733827-19831-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--mOKeRhn3B7HglGBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2013 at 04:03:42PM +0200, Peter Ujfalusi wrote:
> Hi Mark,
>=20
> It was not straight forward task to remove the local reg cache from the t=
wl6040
> codec driver. I also needed to change the MFD part so it will take over t=
he
> caching of registers via regmap.

Applied all, thanks.

--mOKeRhn3B7HglGBY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSszzpAAoJELSic+t+oim9UYYP/A9Bzq3h4vUIsLPR6BZFH+8z
F9Z+sS97iNxgLIGXfeYKaRKwg3VejVVTvQBLder807XYA9SM3as1ngipY6Qz+rVW
Z7yNdRwLSGPY3bUFkRU7VojNpd0m7WJs8KJNiiXuopV4os4ZMYo0FKXI1HchhvHq
GmmnVUIqecPOLZp4BVEuC5IR4p2/O0DKhHp5TVXYdVc7A1Sk9zC4DoPrSdldV5qw
RC6uYttLocV5hTLS787XAXDvjZBm5ZammKI9SOcsSEAUVy2eYY/eTlF7EqMsWcpq
sd7dSIXxQ/MWdWbNfO4WGynInd+sesDvEi2X49K/+0HT+Y9vxflMTC1wfg/1WUJ6
NhZvPjyVSuQW9/kepjRDxWxKKJRBTD2KYiGKdhLvdlPL3kzF1PEMtOa8YVh47St3
YHWBkANyyoLqNvTfNaWhwQjFXChe2pEpa0t0mw8fOVx6vIOMudu1qN3voFJs88AR
jwc7K9OLfS56R/rr8rMP4unusa+N9cd38taIViqjykGVKWDNolWDnim/qkDUPI2v
syxg27l2oMR1vtNi6jggExJKvtMnifTDjXcqHsXwUrti5TA+Q2IOyOq206l24DSD
kqs0j4248NTUsUP1iFoAoBsblVPfBwjQGTgiGF9SvdRMDg9t77qEFj9axVN82vnS
gOEGH2XoDDxVgM9OCaND
=nsBw
-----END PGP SIGNATURE-----

--mOKeRhn3B7HglGBY--
