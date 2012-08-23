From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
Date: Thu, 23 Aug 2012 16:00:24 +0100
Message-ID: <20120823150024.GF7995@opensource.wolfsonmicro.com>
References: <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
 <20120823092216.GA27264@gmail.com>
 <20120823113922.GZ7995@opensource.wolfsonmicro.com>
 <20120823121936.GA1047@gmail.com>
 <20120823125903.GA7995@opensource.wolfsonmicro.com>
 <20120823132618.GB1047@gmail.com>
 <20120823143757.GB7995@opensource.wolfsonmicro.com>
 <20120823145904.GC1047@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8756875681885311173=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B673A266599
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 17:00:26 +0200 (CEST)
In-Reply-To: <20120823145904.GC1047@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: roger.xr.nilsson@stericsson.com, 'Linus Walleij' <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Ola Lilja <olalilja@yahoo.se>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8756875681885311173==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fy7dtsnMLfaLO0XB"
Content-Disposition: inline


--fy7dtsnMLfaLO0XB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 23, 2012 at 03:59:06PM +0100, Lee Jones wrote:

> I'll attempt to re-jig the patch-set, as this is a blocker atm.

OK, if we could get at least the DAI driver and arch/arm changes in
that'd at least make the series smaller.

--fy7dtsnMLfaLO0XB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNkV9AAoJEFJkBDiqVpZ4cEkP/Ai5MptuYTHA1/j5uSMCjqW3
v4nFCGT65MvIJ45rtZ8UAA0RlWWjhdDTXZdwXoDCGyFGnolmoolkxZwJI3Ps3mPx
gxmlTwmqBftcGTw4RdnX6xAviIShC1HbYMKns0rGymYXTmXn9SoCJduXWiPsEjFI
jGpNHWWLaau1ulhETkZsOroGz9XQEFoZSqUTaxVAt8MHl4eiU71d+CwWXQ9hiBe+
Lkmk3gnnEEuE9pfBXialN03UG/ZZ/aHzTBYjPQcChcLDj7oZIrlb2vaLxUPkPiP3
3I9WGq57M8XiAZp3SlnaDI3SS8GQjZdbIhVcjMqo1SPZpO8vUnWUrDNFNge5nyXc
xHPCiehnpaiRhjQ4R8QHqmbT56A28EP0SM2cBSHWzX1/d4CGHB8ii7+79mtaQIAL
9gXuJnTGPSZd6rvgOidMxdhruKX53e2CKWmpzUPvda+tiw6NW69aQTPhbkxZgoqh
R9jpk7s7V7/gCpM2z4UxNw1tPY8HlYQMoxoun9wqbHZ5kHjg42TYeMcHsztCYTuQ
G1qiurTeB3G44CNyjGV8QqyDTIdssmTio2qnRQxTIldsatlMD6Ok/c9/slMJBsA/
ipvM7DrnJGWmzLi53nkZEz5u6xZ6QQ+68mt9RsOI1nVvjtsLzdExYR215pQsAiji
9Yz576m6UuixRSMPTS3e
=tdMY
-----END PGP SIGNATURE-----

--fy7dtsnMLfaLO0XB--

--===============8756875681885311173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8756875681885311173==--
