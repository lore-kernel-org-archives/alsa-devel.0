From: Mark Brown <broonie@kernel.org>
Subject: Re: Splitting out controls
Date: Fri, 30 Oct 2015 11:48:29 +0900
Message-ID: <20151030024829.GS28319@sirena.org.uk>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org>
 <561CADA8.3040903@canonical.com> <561D1B7D.9080307@linux.intel.com>
 <561D2997.1090401@canonical.com> <561D2C88.5050505@linux.intel.com>
 <56209C2A.1010602@canonical.com> <56210E75.70501@linux.intel.com>
 <1445009042.3536.7.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8330339026271533075=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ECA1265D6F
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 03:48:34 +0100 (CET)
In-Reply-To: <1445009042.3536.7.camel@rf-debian.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, David Henningsson <david.henningsson@canonical.com>, James Cameron <quozl@laptop.org>
List-Id: alsa-devel@alsa-project.org


--===============8330339026271533075==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="en9/O5YN3eJ0yPaf"
Content-Disposition: inline


--en9/O5YN3eJ0yPaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2015 at 04:24:02PM +0100, Richard Fitzgerald wrote:
> On Fri, 2015-10-16 at 09:49 -0500, Pierre-Louis Bossart wrote:

> > Bottom line we have to move to profiles, stop guessing values based on=
=20
> > control names or avoid letting users poke random values in alsamixer.=
=20
> > This just doesn't scale any more. thinking that the alsamixer=20
> > command-line remains the default user-facing interface moving forward i=
s=20
> > just not right, it's a developer tool.

> I believe that you are misunderstanding David's point. Yes, there can be
> a large number of controls (the Wolfson WM8280 has over 400 controls,
> some Cirrus Logic codecs have nearly 900). The point was not whether the
> users should understand the meaning of all these controls but that they
> should be able to "play around and see what happens" without any risk of
> bricking their hardware. Regardless of whether what they are doing is
> meaningful or whether it's really feasible to set hundreds of controls
> correctly from the command line, they shouldn't damage the hardware. Not
> even root should have the ability to actually damage the hardware.

No, the point here is that it's unrealistically difficult to prevent
hardware damage on all systems without substantial work - even at the
simple level of constraining the maximum gain through the system we
currently lack the information to do that (never mind the capacity to do
the calculations), and getting the limits into the kernel would involve
carrying the machine specific callibration data around since it's not in
the firmwares of the relevant systems.

We can't even think about the possibility of doing this without getting
the controls into the topology and once we can do that we would need to
work out what we're trying to protect against and how.

--en9/O5YN3eJ0yPaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMtp8AAoJECTWi3JdVIfQi64H/2uaZ6B7O/1D2rJtWzxNNF7i
5wk+x+4agK494cdSbnbsFDNogGtb9VOF6gyMxdorljOqeqfkdE9d0KxBoDHSEzej
xpyuJpXcMgksA8kcafS2gfO8EplLVeK39Zz2q5QbUuVjscqGiEnC+yHVpi3t352v
xJfHd+46DLLEAlZn9V68SRvcy1rKFB5WT5SWwLFcIDcqkRT1pLkbmd4WG9fX+khj
yTECZm0/W2t4wZSJL1vsfI16Cr4dxPGJZ5Mhq5e2sSqZBlvuJ6WvAGTtTe8m1w/p
527ou8/e5cYPlqr5bQQQZNisb1UjQbXaD79kARZP0ToDwezP6hMAy+iLFzMnLNg=
=1oHY
-----END PGP SIGNATURE-----

--en9/O5YN3eJ0yPaf--

--===============8330339026271533075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8330339026271533075==--
