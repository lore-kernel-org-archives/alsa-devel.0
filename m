From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Convert to
 devm_input_allocate_device()
Date: Thu, 25 Apr 2013 13:52:34 +0100
Message-ID: <20130425125234.GV5019@opensource.wolfsonmicro.com>
References: <1356009506-4766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CALq1K=+sJUZ++_sMkU1Sg9+aE-HpF1tnfPHGCEJ789hj19Yp9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2579592994347347435=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0F993265130
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 14:52:38 +0200 (CEST)
In-Reply-To: <CALq1K=+sJUZ++_sMkU1Sg9+aE-HpF1tnfPHGCEJ789hj19Yp9A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2579592994347347435==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKO1kftFne8qVRsx"
Content-Disposition: inline


--bKO1kftFne8qVRsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 24, 2013 at 04:50:48PM +0300, Leon Romanovsky wrote:
> On Thu, Dec 20, 2012 at 4:18 PM, Mark Brown

> >         ret = input_register_device(wm8962->beep);
> >         if (ret != 0) {
> > -               input_free_device(wm8962->beep);
> >                 wm8962->beep = NULL;
> >                 dev_err(codec->dev, "Failed to register beep device\n");
> >         }

> I'm not sure if this patch is correct.
> According to comment of input_free_memory()
> (http://lxr.free-electrons.com/source/drivers/input/input.c#L1825) you
> need to call it if input_register_device failed.

This seems like a bug that should be fixed on the API side, it's really
not what you'd expect a devm function to do, and if you are explicitly
freeing a devm allocated object there's an expectation that you need to
call a corresponding devm cleanup function.

--bKO1kftFne8qVRsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJReSbEAAoJELSic+t+oim9MuEP/RUbCzmMv4O1UIiP3893EzNi
6XNvU+M7GBwoMsjQ6Vzw3Ytx4Dwzo0PmDOT4ZTSbNOz7gDfZ5J6yX4RBU6nArXv4
3UyMPpQb+q+jvcIGPUu2n0WNw/TZ8eJwaV4OWyAnU4wnMxUhGUchnx56HWLLSnF3
9Dy8j94waHt+YrdlkxM4dVuSHMY8//C+M5oLGCWUzpmCuNrPixbs7jRlgc19ZO/8
TxvE1ABLm+f+TL7oj6c+EAELpRcFWTCdwtIUn+E+9ZU/MpTu5owKLt0woJj2fA1y
mK5uGK7IvnychVV2YVGfMFA298vw9/uvqcYhX8gLUUg08t2pSVsj/RCHOwfG4Mqp
nRvqKswBdcXBOt73tokLvXBXA+KVEBN7bOcpj8k0VsGfKETIiPN0s89Qh9EAZTuZ
KX3tgB6Buspeq+7V/SiUN+zkhNb7QEAin7ktZCwpR2Q8KDDwByXVNGwmw777lXY/
OapPJFKJ2r7TdHkvj3t9iwQLe5Cy49REGqKsrngjqEfWyoiFCErcGn9AZcqJcL1s
oEH4OpIGClfylVlIJUxMOByxcwVbqGAgrp2AoKXKYxPx0sWg3z5Q42TezVEF12NE
8nksqclEY3dxCRdcMXlz/zgFl0XMsYWQi8TfaZZDJ883ZVkOnOZGFdR3cqrK1mx8
z5FPXGaQ5xnGc/JO1jpA
=0H3s
-----END PGP SIGNATURE-----

--bKO1kftFne8qVRsx--

--===============2579592994347347435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2579592994347347435==--
