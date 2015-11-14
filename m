From: Mark Brown <broonie@kernel.org>
Subject: Re: multi-codec support for arizona-ldo1 was Re: System with
 multiple arizona (wm5102) codecs
Date: Sat, 14 Nov 2015 12:39:31 +0000
Message-ID: <20151114123931.GW12392@sirena.org.uk>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd>
 <20151012154715.GF4238@sirena.org.uk>
 <20151012201137.GA7317@amd>
 <20151013115355.GC14956@sirena.org.uk>
 <20151113215812.GA19020@amd>
 <20151113225355.GU12392@sirena.org.uk>
 <20151114074400.GA7898@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GdlkuMH+DRYbUHkj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151114074400.GA7898@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--GdlkuMH+DRYbUHkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 14, 2015 at 08:44:00AM +0100, Pavel Machek wrote:

> Obviously I'll need to use the existing interfaces, or extend them as
> needed. I'd expect subsystem maintainer to know if the existing
> interfaces are ok or what needs to be fixed, but it seems you either
> don't know how your subsystem works, or are not willing to tell me.

I *am* trying to tell you but you appear to not be responding to the
bits where I'm asking you to look at what's going on on your system.  To
repeat what you cut from the e-mail you're replying to:

| Look at how we resolve supplies when we do lookups, then look at how we
| create aliases for the MFD cells to map supplies into the function
| devices and figure out why those mappings aren't being found.  The NULL
| you're seeing above seems like a bit of a warning sign here - where did
| that come from?

especially the bit about the NULL which looks likely to be the source of
your problem.

> Is there someone else I should talk to with respect to regulators-ALSA
> interface?

To restate one of my previous questions could you please tell me what
this "regulators-ALSA" interface you keep talking about is?  In order to
help you I really need you to at least be looking at the code and
talking in specifics about it and the concepts it implements.  We need
to be on something like the same page here, at the very least I need you
to talk about what code you're looking at and what you don't understand
so I can try to help you follow it but right now I'm just not sure where
to start, it feels like you're trying to treat a lot of the code as a
black box without following the abstractions it provides which makes
things very hard.

If you're asking about the regulator API or embedded ALSA both of those
are me but there are other things in here - the driver you're working
with and the MFD core at least.  At the minute I'm not convinced that
the problem here isn't just that the MFD and/or MFD core hasn't set up
the mappings to the child devices properly.

--GdlkuMH+DRYbUHkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWRyuCAAoJECTWi3JdVIfQenUIAIa0oaiYOS0kfwsQPT8J+6na
Zz+2I4Cje5pVtR1GwdWLe5R32YsSfLYJN4YffCX83WvNWxSjnPUayGFYoI8ReMHh
vFcMu5lw7Q35Konk9+N2J6DvgwefoMg+0ehkpYM34TWNEBTqr9ztAxoh1DKmH648
g1ub+WTZfHShglqRmEdO6sYkOdGhL5IAiRCrLRFCPYXoF7xWEOGzBNgUcd8s5RoC
A0+TfcChzlqdfRuWvtdM64uA3T9fsM9YchWLzGtwc7BYMeQaNHtgK6h83DKwkJv9
xI7yaxXltU6boR5NLT3Uj1mx/hxdVWXRG2/q84FBoSLUsaXZG/M+UuS8UV0JOzM=
=otWY
-----END PGP SIGNATURE-----

--GdlkuMH+DRYbUHkj--
