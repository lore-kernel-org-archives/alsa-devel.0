From: Mark Brown <broonie@kernel.org>
Subject: Re: multi-codec support for arizona-ldo1 was Re: System with
 multiple arizona (wm5102) codecs
Date: Sat, 14 Nov 2015 18:49:40 +0000
Message-ID: <20151114184940.GY12392@sirena.org.uk>
References: <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd>
 <20151012154715.GF4238@sirena.org.uk>
 <20151012201137.GA7317@amd>
 <20151013115355.GC14956@sirena.org.uk>
 <20151113215812.GA19020@amd>
 <20151113225355.GU12392@sirena.org.uk>
 <20151114074400.GA7898@amd>
 <20151114123931.GW12392@sirena.org.uk>
 <20151114175915.GA20429@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A3ZnGbl6n9tZ6+mF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151114175915.GA20429@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--A3ZnGbl6n9tZ6+mF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 14, 2015 at 06:59:16PM +0100, Pavel Machek wrote:

> Well, mfd_core.c seems to call regulator_bulk_register_supply_alias()
> with device that does not have dev_name initialized.

OK, that'll be the problem then - we're not mapping the supply into the
individual child device but rather system wide, probably because that
mapping is being done too early, before we've actually created the
device.

> regulator_bulk_register_supply_alias() results in "Adding alias"
> stuff, and then drivers/regulator/arizona-micsupp.c tries to register
> another "MICVDD".

That's fine because all supplies should be namespaced with a device.
The goal is to say "Supply X on device Y" (we do support exceptions for
the few cases where there are not yet any devices involved but this
clearly isn't one of them).

> And now we have

> sound/soc/codecs/wm5102.c, around line 1093:

> @@ -1092,7 +1094,6 @@ SND_SOC_DAPM_SUPPLY("ASYNCOPCLK",
> ARIZONA_OUTPUT_ASYNC_CLOCK,
>  SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0, 0),
>  SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD3", 0, 0),
>  SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20, 0),
> -SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD", 0,  SND_SOC_DAPM_REGULATOR_BYPASS),
>  SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDL", 0, 0),
>  SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDR", 0, 0),

> That is the regulator<->alsa interface I'm talking about. But as you

So if you look at this just templates out some boilerplate regulator API
client code which calls regulator_get() like any other client and then
hooks that regulator into the audio power management.

> may recall, I have 2 arizona chips here, so two wm5102.c instances,
> and I believe this means that "MICVDD" is not suitable here, and we
> want something like "MICVDD,spi32766.2" here.

> But a) code does not seem to be quite ready for that, and b) you said
> you disliked that approach.

Please go and look at how regulator clients request their supplies and
how those get resolved into actual supplies - it's exactly the same
struct device based namespacing that we use for clocks, PWMs and other
resources.  It's not that I dislike this approach, it's that this
approach does not make sense in the model we use for requesting supplies
and is not supported in any way by the code.

I'm not sure how I can be any clearer that supply names are namespaced
by client device and that as a result fiddling around with the supply
name is not going to help anything.

> > to be on something like the same page here, at the very least I need you
> > to talk about what code you're looking at and what you don't understand
> > so I can try to help you follow it but right now I'm just not sure where
> > to start, it feels like you're trying to treat a lot of the code as a
> > black box without following the abstractions it provides which makes
> > things very hard.

> Well, the code is pretty close to the black box for me :-(.

How far have you got in trying to follow the code, what specific areas
are confusing you?

> Ok, good. I don't understand how the things are expected to fit
> together. See above. I believe SND_SOC_ macros should have another
> argument "device", or maybe regulator names should have "device" name
> embedded in them.

Regulator names *do* have a device.  This is the whole point  with
namespacing by client device.

--A3ZnGbl6n9tZ6+mF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWR4JDAAoJECTWi3JdVIfQZyAH/3ANZYw/FVHt8KipxkzVkIK6
aL1Ilbzyk5vV6Fm0q+smCsLVn7nJx5V0ox12FIyVrzuRbGUQj6KLU0xAxpg9NsVv
Rk708knHINaFDOfHojAefJIrGh8I/48BtEglnpQZ3iiiawtNhyGx+hgX9TyBqBXg
9IS4WQNBbHEjV2sHsxJAscxKGL+QI+oIYqfYdphONrLO9crScUDFp4Q7BNGZ1b1k
ZI21sCstib+ftqYlFInD1Rui67ZV+1vfnmzC0OVUy5qKWviaHGydC0+v3+UPL2ib
+OIbzEnQjjDrdaT1jUJM7TCud2clGOu3Bp8W7sp4pzG+c0Dg3HRlUpRCPiAjX/k=
=/4ex
-----END PGP SIGNATURE-----

--A3ZnGbl6n9tZ6+mF--
