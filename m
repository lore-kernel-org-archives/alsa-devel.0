From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/16] ASoC: core: Add strobe control
Date: Thu, 22 Mar 2012 17:28:47 +0000
Message-ID: <20120322172847.GN3091@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-6-git-send-email-ola.o.lilja@stericsson.com>
	<20120313213356.GE3177@opensource.wolfsonmicro.com>
	<4F6B5136.5040208@stericsson.com>
	<20120322163352.GL3091@opensource.wolfsonmicro.com>
	<4F6B5CC2.60605@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4917042455223990663=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 60106104507
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 18:28:49 +0100 (CET)
In-Reply-To: <4F6B5CC2.60605@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4917042455223990663==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jdM5ZcN/ZcXXVwZs"
Content-Disposition: inline


--jdM5ZcN/ZcXXVwZs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 22, 2012 at 06:09:22PM +0100, Kristoffer KARLSSON wrote:

> You are correct. The state would not be the most important thing since normally
> there be only one client accessing the card in this very short period of time
> like you said. However the allowing for a way to expose a strobe "action"
> control would. So do you think it should be modeled after a SOC_SINGLE_EXT
> instead or how would you prefer that a strobe "action" control be implemented?

More like a a single, yes.

--jdM5ZcN/ZcXXVwZs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPa2FHAAoJEBus8iNuMP3dAusP/10JPpKyZXf5Aa9XtCd7G2df
o8hOMie7bY1yvFMzKU9hnR4Lf6G3XIQj46hgLNbOFSxsdOJ42Itg77QDLLW9MSri
Ks88fwvbONayBaSJPgEQS+QeUiSlftUIwEEZJpNWbggqZUy1xPH/FlyVcdRm8Dp4
sb4v6koL+c3LB+4zPWNmqUCmyZ208UNG2FwCyZZNaDoc0p2uRdOCc6X7R17pExvl
eUhl/R2b4GXPmmRBsWUfkqRTa7hlM+dbZFCg9smovI5uQjIHujWYN9JtMb4Txsr3
DkCjN43OQAebFr1ai5BBjaC/gfENG0zwgDhYi5yhayW3AOaE2UlGe5thnxuQSHP+
2U57Rp9QqAi77Uw56TPUQc1h5lU5oWlw8M605aOf0tmOST9bOV6gB8CccK+7s9LJ
sjDsFKdJM3B3T0JlV/N3edfZE3RTXUkvUIzJbBXwgv2ePCuSbMDMxcMhbkhXahMz
9iuJi70wUlOvj8cat/AQN6OmZlJIZuG150rbJGpaxXl5CWWXK7pYSdteGatiAAsi
YXzfVPMg+dT4s/kM7O5R2t0erZkm+GRuiF6IHnPPIpTSkEkCPgPZWg4i5Cbct7vm
ps7GCTZZ5bybU+GsPL7wXGgW97B1vstlTFRhOTodqT0QC+LYirgxkcC+tCV1H+yR
GBiIW4EPfMlyrKiL5CHv
=MgYm
-----END PGP SIGNATURE-----

--jdM5ZcN/ZcXXVwZs--

--===============4917042455223990663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4917042455223990663==--
