From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
Date: Thu, 9 Jan 2014 20:24:46 +0000
Message-ID: <20140109202446.GQ12858@sirena.org.uk>
References: <2E89032DDAA8B9408CB92943514A03376B7CC95A@SW-EX-MBX01.diasemi.com>
 <20140109121353.GG31886@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CC9BE@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5321485201097012981=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 598212652E7
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 21:24:58 +0100 (CET)
In-Reply-To: <2E89032DDAA8B9408CB92943514A03376B7CC9BE@SW-EX-MBX01.diasemi.com>
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


--===============5321485201097012981==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dUqh8vgUBVXHzm9w"
Content-Disposition: inline


--dUqh8vgUBVXHzm9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 02:22:48PM +0000, Opensource [Adam Thomson] wrote:
> On Wed, 9 Jan 2014 12:14:53 +0000, Mark Brown wrote:

> > Hrm, you hadn't mentioned the rename in that thread.  I do note that the
> > change was from KPIT Cummins who submitted the drivers for this chip for
> > you guys and appear to be doing updates too...

> I said at the beginning of that thread that we would be taking responsibility
> of the driver and KPIT Cummins are no longer involved with this work. At that
> point the change to the PMIC I2C id name had already been made (by KPIT) and was
> in the kernel. I refer you to this mail in the thread, and to the last paragraph

Right, but at the time...

> > No, users will not have to do any extra work - if anything they have to
> > do marginally less with only registering one device.  As discussed this
> > is the way Linux handles things (which is also the rationale in the
> > changelog for the PMIC rename).  Looking at the changelogs I'd not be
> > surprised if the rename was done due to the author getting caught out by
> > the non-standard way the driver was done.

> Use JUST the codec driver. No PMIC. For some chips, 'the way Linux handles
> things' makes sense, but not here. I don't want to re-cover old ground though as
> we spent long enough over this last time.

If you want to support any additional CODEC only devices with compatible
register maps that exist you just need to add something like less than a
hundred lines of mostly boilerplate code to do so in the ASoC driver.
It's hard to see any difference to devices that have both I2C and SPI or
both PCI and platform buses here.  Those devices should have separate
device ID entries anyway.

> What I would like to highlight, and it's something that concerns me more, is
> that someone went into the kernel and changed the I2C Id name for no good
> reason, and didn't test if their submission worked correctly (I am of course
> well aware in the original submission from KPIT there was a conflict in the I2C
> Id name, but that was rectified, and would've been tidied up further had it been
> permitted). On top of that you are also leaving it in an unusable state with
> your change. If we direct customers to the drivers in the mainline kernel, the
> codec cannot be simply instantiated as before, and certainly won't be
> instantiated from the MFD code. How is this acceptable?

I do agree that the current situation is not great - this is intended to
try to move things forwards since mainline is currently broken for this
device and has been for a couple of releases now.  One of the things my
patch is trying to do is to get someone to tell us what we need to plug
into i2c_add_dummy() to make this work.  I had hoped that if I wrote the
code we could get this fixed but without documentation or something that
last bit can't be done, would that be possible?

--dUqh8vgUBVXHzm9w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzwWLAAoJELSic+t+oim9324P/RrX4vybvW2M2IRy231rlvOU
dTX/XUa+bizArO6D40gXEu6eQHkH2bms0RhfMTQ5GB+SioQC8r1Q2UaLgMp8iODy
x8c6cN++PlcyECpLZOYJ2o/Zi2VW+TvHjlCeKl09G0GylRpBq5+EeWPJHSancUYn
XhLah1n3f90ydMsHkHmXmjGkquNA7daxCmaJLXQrW9AlmM1rBU+1C03a/Ousc8hV
Y+Smi2/hDarsiisHpmDQqVCZz6j5/MydBbgXpzH6/MMHzb5Jf7h136LDj05PETI3
W/xB/54I9dlYdihNpGh5I1vY1R16R0o/A+rq3SeIwnxKqby3N58Kd6Nr8+h+YeZh
hVWQNwWjlibAFQrv5jg/5gYzlP8Busr2W/4OIAKvPfJP0a+oaxVwvUe31M5W9pdL
m3RSsCDbqV2TW6IdtYXpXTDXtIYKyVG8vW5J/kiWXxZEYZFAzItaG3f8yQgE8vFF
c354bqOOf5Re8TTuKUTyWaIcFXGESQWP/g2bW7HoGDy9U9HZ6M3WpBt6yTdIYVvw
U4S7UZ4VVDXZVSz6tt3ImZcMZsSHfqoUWfE13/6Cn6UKK+ZIMrLjROJWEoA9ebki
a1zwz31s48zlaT1kDVmGXZ8iGALoIrl9QowyZKzRDVPLZe+T4pqAQvaSJStqtDIk
f5bUj4wVULIcEG7B2cQ3
=2pKK
-----END PGP SIGNATURE-----

--dUqh8vgUBVXHzm9w--

--===============5321485201097012981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5321485201097012981==--
