From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/16] ASoC: core: Add multi reg control
	struct & macros
Date: Tue, 13 Mar 2012 21:39:00 +0000
Message-ID: <20120313213859.GG3177@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6609279024904420624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA0C524337
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 22:39:02 +0100 (CET)
In-Reply-To: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============6609279024904420624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 13, 2012 at 04:11:28PM +0100, Ola Lilja wrote:

> SOC_SINGLE_VALUE_S1R  One control value spans one register
> SOC_SINGLE_VALUE_S2R  One control value spans two registers
> SOC_SINGLE_VALUE_S4R  One control value spans four registers
> SOC_SINGLE_VALUE_S8R  One control value spans eight registers

This is fairly painful; the number of registers really ought to be
parameterised rather than having to add a new crop of macros every time
there's a new format or a new count.  Can we possibly make the
simplifying assumption that all the registers are contiguous?

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPX75tAAoJEBus8iNuMP3dih0P/0yP8xxpJDrBi9YnhJpUkLDm
yDmRP16+ljzCqCmaEdKfxo8tpXC5kqOyCIHlrugUWutNa/ZHQL8nMpf3xQ38gdBe
Xdl4HNzYOsGMKP9alOomvU1ViXpCYpjVPijY7FgSMBNEewvtGfOY9RcxgEn80MFR
egNBXmntTBl0WoKs47MugUuyzU4+GwEpKS5fxJlZjDHcfyQCL/RqKSmwC3yhgYiJ
ORSzI8106FrJfmEmaSz8w9UL9j2YrGcH+qrbklMOEGZTtzNRjXkEBcnvYSnGqkyf
qUkbrmdAjYILbFkGm2fWLhdGp/7QRP3FkBrWHhphT+wnVuVejNXc7iOqK7bIZOAj
6Ly/Xfhj4s+ew7+vTmCTV1TZUHEPzU5eA9ooRxEHGo0dFwkJTLOyXQHWReJJ/33F
zFEoQh4HJ7k2IGirhb7xJa+qjTjVOnda8VqdYlAZKQ0Ml28qcX5az1TfrHSULaEf
QrdVMBFpFNQ8K2iXmxItnNtM0j57PvxfyF2+Jluim/t9JG/qEpb0IWS/oDVh8+2j
qSaM0BnlDfSxlKS7TzuiPNM7kcszlT+1m9msMjaW36yPZYpjqbasj6W9vKcp7a/s
ZZT/tGM1qPW/YLFC9M07N7V3tsIcmYW9qnQ/zNWlSZpDQMwpKR09HuYUF4hOx+qw
/mg89pviCOfnd9D+ifE9
=5cjf
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--

--===============6609279024904420624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6609279024904420624==--
