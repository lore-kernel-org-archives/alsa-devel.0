From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
Date: Thu, 9 Jan 2014 12:13:53 +0000
Message-ID: <20140109121353.GG31886@sirena.org.uk>
References: <2E89032DDAA8B9408CB92943514A03376B7CC95A@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6105971786459670424=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E1C6265281
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 13:14:01 +0100 (CET)
In-Reply-To: <2E89032DDAA8B9408CB92943514A03376B7CC95A@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============6105971786459670424==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EfDWqPO3HfsSBlCI"
Content-Disposition: inline


--EfDWqPO3HfsSBlCI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 11:30:42AM +0000, Opensource [Adam Thomson] wrote:
> On Wed,  8 Jan 2014 20:38:55 +0000, Mark Brown wrote:

Please fix the word wrapping in your mailer to something less than 80
columns, I've reflowed for legibility.

> > Since I don't know which I2C address to use for the CODEC a FIXME has been
> > left in the MFD, this doesn't make anything any worse since the device has
> > never been able to load in the first place.

> What you're saying here is incorrect, as previously discussed at length in this thread:

> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066027.html

> The two drivers did work together fine until someone in 3.12 changed
> the PMIC I2C Id back to just 'da9055' and broke it again. Also, I
> wanted to add a simple patch to tidy up

Hrm, you hadn't mentioned the rename in that thread.  I do note that the
change was from KPIT Cummins who submitted the drivers for this chip for
you guys and appear to be doing updates too...

> the I2C Id names and avoid this but you would not agree. The codec
> part can be standalone and by doing what you've done here means that
> customers would need to now add additional, unnecessary code to be
> able to use just the codec driver.  This is not right to me.

No, users will not have to do any extra work - if anything they have to
do marginally less with only registering one device.  As discussed this
is the way Linux handles things (which is also the rationale in the
changelog for the PMIC rename).  Looking at the changelogs I'd not be
surprised if the rename was done due to the author getting caught out by
the non-standard way the driver was done.

--EfDWqPO3HfsSBlCI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzpJ+AAoJELSic+t+oim9RBoP/ifitj1erk+RpLI10lSGy7M8
5DOXe2UKjpwXcI9ZX+48BpZpxaUBUXEpwMC7N/PynNRxa0918yog3FWWFzNI8/o3
Ywp132ZDjrXyrsPyrERFMnohZtJOTTzJcS7wUhqrK7nNfO0oYnko4Am/mqFxRxcD
mt49tdGHkWVVEjrT58a69UfaAupZVvZxcevZyXE1UkIm4JYZv0pxyUys9piIoD5m
4/W+DOA5E3T9fBC4gjagPIcTbFhqB3RIP+/7jbPxDTlVhwZ1O0YqCFIVjM13R83m
6GuuyNL3x/BL4NxAQBRSg3ebIA6FZ8sp7zVa8Ho5IPmhhIyZhOAvMs41Ubrptj6P
d4gaFbCy1w7geALpB1tpBnfR0USBLFaVAnGB0PjnLwzh6HrvWagYid8l2WpeFExW
dLYg6FJpS25uNZWzyc8m4cul0K0tSTDX/zmfwCbkFekW7XvcDkJL6xbYRqvxpFq3
bO2TM/bDBCupKTQl1p2ZNk53SiHMkFKBd1nPaF6NfRLO2LZZ+iF+nsKAR8ivbrB0
ksRejEcrN9WGOsm2C6GMhO2OokyVS+yawWVPCyA0nvszIKaJc52QUySWci4EDw+p
IMikojNPB8haUzHyuK3AN0c6Q7pxbAkoLXpGX4UdqSMvyKW/hpQS/j7wU/zviZK2
VEau+UIcvMxo6gUnB/0u
=xR7Q
-----END PGP SIGNATURE-----

--EfDWqPO3HfsSBlCI--

--===============6105971786459670424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6105971786459670424==--
