From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use
	devm_clk_get
Date: Tue, 5 Jun 2012 11:14:13 +0100
Message-ID: <20120605101413.GJ23408@opensource.wolfsonmicro.com>
References: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
	<20120605064714.GL30400@pengutronix.de>
	<20120605100316.GG23408@opensource.wolfsonmicro.com>
	<20120605100851.GI8262@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1842912093003033380=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2FC801042C5
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 12:14:15 +0200 (CEST)
In-Reply-To: <20120605100851.GI8262@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, Sascha Hauer <s.hauer@pengutronix.de>, Richard Zhao <richard.zhao@freescale.com>, kernel@pengutronix.de, dong.aisheng@linaro.org, timur@freescale.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1842912093003033380==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xssso5lpTBgMxDfe"
Content-Disposition: inline


--Xssso5lpTBgMxDfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 05, 2012 at 11:08:51AM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 05, 2012 at 11:03:16AM +0100, Mark Brown wrote:

> > I've not, but I guess there will be an issue.  I'd say the fix here is
> > on the PowerPC side - it's not good to have to have Kconfig bodges for
> > things like this in individual drivers.  Ideally we'd add clkdev
> > support...

> Or get rid of devm_clk_get()'s dependency on CLKDEV (which is in itself
> silly.)

That'd work too, of course (providing everyone has been implementing
clk_put()).  Though getting everyone on the same page with the clock API
seems much more worthwhile if we can do it.

--Xssso5lpTBgMxDfe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzdvXAAoJEBus8iNuMP3dDLoP/RsdJUpE/NyXSZVEoBwsgr8J
DTyiGj+nHlfOFIUxoWzQllJWKNF/pMjcikytrKJOUiZOK0cSTj/a12O4xujJYjrF
b15owLcRL6L4udxlnwKfpi7NEipFlT9V0uJDhYOiWJVBdlSdDPKagY0XR2Uui1UB
Iz2I0JLSDnE/m0uNx1dHjFWa3WDkv+4u/oI9nD/rSoDjTPAFxCLhhnVtCT+GYU3h
yy/5GL3HEvHY/7MtCCbHLaF+BFKmWMkORMSaZc7tIDKIJWXXnbNqKDpLiLNMXafr
Nzh5+vtNUUQlsIYR8M/Q1n8/6ecmuoAfylh/EPrgdPyEcVVYGttDgR0UTSluy59d
iiI60cVucsMQT+fTDDR4Cqp+PKKso7zUPad/Z6budhIN7TMl82lttaGqIfGUOpr8
EN29wsETzSnvY4U1EERJq6h0gf/aOghgRIwtAJext+/WKJfz+62wCJ3YwxJAYJ6M
IiKNsiOrkwJ1m2Ups2lJkwHdJrHMRJZldIxxzldNIzx8Vug0zRsGPI1St5FlaUI1
mMeUB3+c+gypWvdJi1FG0P2LyPzQ1utx6oqwsb2Ux2CYrRVBa2uLdWcRPOLQdspA
oBNU9A6f84bqa5DyzzpHhaLJ2qWx7WPN8oPU/LH2AH9cW8qVmBNw5lq2KjgHklpp
u5OTnGHtonwJZcuPZzZ5
=2dYj
-----END PGP SIGNATURE-----

--Xssso5lpTBgMxDfe--

--===============1842912093003033380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1842912093003033380==--
