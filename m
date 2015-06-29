From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock class key for
 lockdep
Date: Mon, 29 Jun 2015 17:02:46 +0100
Message-ID: <20150629160246.GH11162@sirena.org.uk>
References: <558C229D.4090409@metafoo.de>
 <20150625160817.GT14071@sirena.org.uk>
 <CANMq1KA2C1ZYUd_s_R5DWn-Hy_XZZQ_aaR47VLpPsNvcvxEQ9w@mail.gmail.com>
 <CANMq1KBcWw9jsGkrK0dYzOWGZAZYmHdo6gvvpQwt_ftq+avqVg@mail.gmail.com>
 <5591414D.6080802@metafoo.de>
 <CANMq1KAmV7f2f8zhL+VVdpL3AeQKe8RB5nigmZDwrn=JbWGh9Q@mail.gmail.com>
 <20150629142215.GE11162@sirena.org.uk>
 <559157A8.2050206@linux.intel.com>
 <20150629153256.GF11162@sirena.org.uk>
 <559165E1.105@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ewQ5hdP4CtoTt3oD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <559165E1.105@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Lars-Peter Clausen <lars@metafoo.de>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--ewQ5hdP4CtoTt3oD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2015 at 08:36:01AM -0700, Arjan van de Ven wrote:
> On 6/29/2015 8:32 AM, Mark Brown wrote:
> >On Mon, Jun 29, 2015 at 07:35:20AM -0700, Arjan van de Ven wrote:

> >It's not that there's no heirachy of locks, it's that lockdep is unable
> >to understand what's going on since it's making simplifying assumptions
> >that just aren't true.  If I remember the problem correctly it's
> >grouping all locks allocated in the same place into one class which
> >doesn't work at all for scenarios where you've got a generic interface
> >providing services to many devices which may be stacked on top of each
> >other.

> but the stacking *IS* a lock hierarchy.

This is why I said "It's not that there is no heirachy of locks". =20

> it just seems that the hierarchy is implied rather than explicit.

It's explicit for any given system, like I say it's just that lockdep's
simplifying assumptions don't cope.  As far as I can tell to do
something that robustly works without random magic thrown into
individual drivers with no clear logic we need to allocate a lock class
per regmap (or at least per regmap config that might be instantiated)
which is a problem as they need to be statically allocated.

> >>(I would be interested to know how you avoid ABBA deadlocks btw,
> >>can you have 2 devices, one with a hierarchy one way, and another
> >>with the hierarchy the other way?)

> >I'm not sure I fully understand what you mean here, sorry - do you mean
> >in terms of classes or individual devices?  The relationships between
> >devices are all device and system defined, individual regmaps should be
> >treated as separate classes.  From this perspective it's basically
> >eqivalent to asking how the mutex code avoids misuse of mutexes.

> well what I meant is inividual devices/ranges

> like device A is on devmap A but then ends up using devmap B underneath
> (e.g. the lock nesting case)

I'm not entirely sure what you mean by a "devmap" here - is that just a
regmap or do you mean something else?

> what prevents there from being a device B that is on devmap B but that
> uses devmap A underneath

Assuming you mean regmap nothing prevents that and we should be able to
detect if something messes up there.  It's a problem for the users, not
for regmap itself.

--ewQ5hdP4CtoTt3oD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVkWwlAAoJECTWi3JdVIfQAEMH/24vwDKdfuMee2kMqeanF8pk
eTOKwE7YFRUInzvLefLKF/TF0SwDnHWUI5t/9sB37cwF7fVN53owfHfCIAADtQm6
ce4kJSkre/9iTCcy/JIiJDs6yfPt100XKl00O17Sa/gNypTz8OqQTTQpgpdh99qT
OvfEAklWypyDK7RPms4ogksL/lxVkQyr3p6lwgRzWl2dNHpPybeV36JavzwCCMuA
MmQhbXpxDHlH9LRko9radag7qpIcakVft7gGpSnQ+wTf6v5bqohs4mc5bi5c8v53
O4TDLNKUt4KtKBqYDWq8+QZC/3oDZwT2tfY+kOPfgT+xkZ9gxhN/AZbNevjaRWc=
=tTzA
-----END PGP SIGNATURE-----

--ewQ5hdP4CtoTt3oD--
