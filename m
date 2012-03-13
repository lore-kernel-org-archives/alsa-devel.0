From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/16] arm: ux500: Add support for MSP
	I2S-devices
Date: Tue, 13 Mar 2012 21:40:34 +0000
Message-ID: <20120313214034.GH3177@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-11-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1447081961002366533=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C90F104204
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 22:40:36 +0100 (CET)
In-Reply-To: <1331651503-16917-11-git-send-email-ola.o.lilja@stericsson.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1447081961002366533==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
Content-Disposition: inline


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 13, 2012 at 04:11:37PM +0100, Ola Lilja wrote:

>  arch/arm/mach-ux500/board-mop500-msp.c |  194 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-ux500/board-mop500.c     |    7 +-
>  arch/arm/mach-ux500/board-mop500.h     |    1 +

Perhaps this is somehow idiomatic for the port but why is this in what
looks like a board specific rather than SoC specific file?

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPX77LAAoJEBus8iNuMP3dda0QAIxQ05wAHGL/EH4sPKAB0b1i
XXAzExCSEaha64I19H8KczJW6Qbe/5jG2TIuchagsZpm6e6FCriTtuH7sT1E+/Us
DZXzLSvNk2yWJD+A0/eKgmYie1b1XcMBgeJaMD56rvRswNWAw9sr/UJ9T4PvXTJU
Db5Xf54yKlw9+QbucEvI33J6ogLOf4xva68y3lTdQEjBpYKeAgc9Is7eTwmwFLHm
rJy3zJs/pwkP/x/KNWOvbWbKmEoYvJgfs3miKFjZOkoGz1xIkY8QqE7Gao67Ts8M
pg1ILRo+6HgFyqcgnBqO7A5+0nL/d9nHdfjNG3rV4DHNiZIldpoy1nSopUmJ3qvf
MHzKVa8oaa22WPD2Ip086m5FdF00SOA8BOfOZFCL11C9DayFaZmoCf9NNbX1X/n0
XJDs6oK8Cg9z877wCfXyVVCLyOjoAvtsrrahpRjFFptC0yegwpc887O86s+XLHCt
p5u1I9MrvU2t890SpfDlnB4C2QG33gZBfYzbw2+QoeI9mt0Pf/+jfT9P+0y9gsbP
WYDTmXA8933QL0QufcvQwb7cv6U4NFeBA8QKZ0aFJm+8VX1Qgm98d4GTPvnWtp7g
AiCbWoJqZMDNtUV7yW8sxYolKeWg0G1UzUsAxgPbKfTBtdcCbFA6ozPKumH+b3QF
qLK0cG/HcBuI9GVVc6Fq
=M7MO
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--

--===============1447081961002366533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1447081961002366533==--
