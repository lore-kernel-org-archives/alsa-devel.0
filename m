From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: wm9712: Microphone doesn't work,
	"Capture Volume" inverted
Date: Thu, 26 Apr 2012 22:37:45 +0100
Message-ID: <20120426213745.GA18260@opensource.wolfsonmicro.com>
References: <1335384469.14096.203.camel@mars>
	<20120426112726.GF3207@opensource.wolfsonmicro.com>
	<1335448142.20000.40.camel@mars>
	<20120426172010.GP3207@opensource.wolfsonmicro.com>
	<1335474693.3628.26.camel@lovely>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6843960364819834334=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0C04210BC62
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 23:37:49 +0200 (CEST)
In-Reply-To: <1335474693.3628.26.camel@lovely>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: alsa-devel@alsa-project.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6843960364819834334==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2012 at 11:11:33PM +0200, Christoph Fritz wrote:
> On Thu, 2012-04-26 at 18:20 +0100, Mark Brown wrote:
> > On Thu, Apr 26, 2012 at 03:49:02PM +0200, Christoph Fritz wrote:

> > > Is "SOC_ENUM_SINGLE(0x5c, 8, 2, wm9712_diff_sel)," correct? Because of
> > > the ">> 1" shift in ac97_write() ?

> > What makes you think it might not be correct?

> ac97_write() doesn't get called when I try to change "Item: Differential Source".

Oh, right - you're not actually seeing any attempt to write.  There
won't be anything on the bus, then.  Still, why are you identifying the
shift there?  The write will be suppresed if the register contents don't
change which looks like what you're seeing here - though I can't see
anything obviously wrong with the enum from looking at the code, it's
saying that the enumeration exists in bit 8 of register 0x5c...

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmcAhAAoJEBus8iNuMP3dBpMP+wZUmSChIZ/KRVyW0MqUPIl/
wIr95CzPUXEoYr5TjQEoQyBgyNJCGzEkH5/8nFHtGAWWZxsfvItNjiVCGfjk4Xrs
ccJiJH5qtlnJ/OWkhHFuOgQuYPxBa34g6jlM0P1o5PZyVORm2yFoys0rs6V7gNU9
zbr61IRtYLnozO7TFTwyrVvl5V0a45ObIyYotkv1Eg5J3SURE4ItTWYE28u5bJev
RRwLnp8EFR3PNClkXIa/I2QYR0HepzPbB2pEXELQ0n2YD2U3yPmhFuwIBl9xtW+k
qTiNnO7NKojZ23pobkQwWwJwUEl3eBf5mf4NtNDFsMBIVu3v/akS0QfOrJE5eOZ7
CBtttC9BMRHI7CkQbwtW5rosHoD0cc/7hlmeav0i2E0DpwExMl56vLq1HdrPqAf4
b6QB+N6gIpnDMGd9mCdiZn5vskgkWlJvkqDE8UBq0HUSerEeW/ivcRAa+bc8wKdh
CSmAn/Y19K0EOIzcNVDKVO7GIPD5ibIbFvyOCBxJwjZsRx3F6hrTEGru0mhlIbgy
xpDf22RB2xWEhGCpt7QuvB00g6/6wwT95BqsvG9vWl8JPwXV5IHho88b7sxPMMVY
lVNFMi8AYrJjnXdljmY61BlwLZdRD4glgZvIAnxFh39mGWz2uH8oRRT7EaWefM83
je6QzOjm/MTW4JFQgagU
=DDrE
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

--===============6843960364819834334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6843960364819834334==--
