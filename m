From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ep93xx: fix build of ep93xx-ac97.c
Date: Fri, 19 Jul 2013 19:54:16 +0100
Message-ID: <20130719185416.GW9858@sirena.org.uk>
References: <201307190953.25957.hsweeten@visionengravers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5142174879358132535=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 56E7F26577F
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 20:54:22 +0200 (CEST)
In-Reply-To: <201307190953.25957.hsweeten@visionengravers.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5142174879358132535==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Wg5Vd7si6EhrIHA"
Content-Disposition: inline


--1Wg5Vd7si6EhrIHA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2013 at 09:53:25AM -0700, H Hartley Sweeten wrote:
> Fix the build of this driver. It was broken by:
>=20
> Commit 453807f3006757a5661c4000262d7d9284b5214c
> ASoC: ep93xx: Use ep93xx_dma_params instead of ep93xx_pcm_dma_params

Applied, thanks.

--1Wg5Vd7si6EhrIHA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6YtVAAoJELSic+t+oim9NSMP+waWWU8DTARfpgtn2Mrolyf9
wqImY4sFaeEtn/6Cg7LHTLBs9Xerj8SxKpUXLF2J3s4Z0tBVf6iMW18JzR/2v0Uy
T65T0gLW0/ILjErkUJ68uSOZcWYnmAx5AXOxOGwkCv68bmiXoqXBWN8dBwAQgf5+
PaY+kZiBgZGrkho4REG4tcoNoGmhowiN2LWnOTMTB9fYkrx6EGdc8hoZOKTbTQQ1
nwxzEBmTFahmeCZskhOtBwBioOM1U8xMVFLLEZfSBzgU/exikcFxSiV4V2LwFoAQ
lXmx4lAZMkZx8bfWjKYMQg3qMS5A2cg97nRyXEGSvvRTG74ZGagFfC6rIIwAWHmh
gOHV1SbIWm4XsLKonF9HNzbXd6cFxqGRNVDp2PwhV5iCIWsyxp7Oo5CH2GYX4suY
cBAIfpOahjzPalBIVX3o6fNRQAmcOcGc39gXomYeXjgPFSfLIzZHTNof6tn0nhy0
a3ZgVpXPILV623LcoKLKK6HoT7cCLGZfTbaT/Pbr6tvB2AWXk7MhR6C/A/3YVp+6
vJ7gTd8aE2XnI2YfMnPGjOG+3d9I1X2FiapQoPrPHEZdlMrCS7k4Gss/uu+GnUtM
KeVqx/tdONDLIqCOb6OQlLZotP3eDA0KouDk042Gr4E13/5XRtJ0otP8sGINVbd0
w0MBaVhMWS5YrjwJJYQu
=6MLY
-----END PGP SIGNATURE-----

--1Wg5Vd7si6EhrIHA--

--===============5142174879358132535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5142174879358132535==--
