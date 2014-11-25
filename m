From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: Add ACPI device probing
Date: Tue, 25 Nov 2014 19:36:23 +0000
Message-ID: <20141125193623.GL7712@sirena.org.uk>
References: <1416034608-24238-1-git-send-email-benzh@chromium.org>
 <CACxGe6stjCvaQZkh=hFcF-56v5qJVar11jRZz0PRSd2wz6EUyA@mail.gmail.com>
 <5474A78C.7030805@linux.intel.com>
 <20141125172120.GI7712@sirena.org.uk>
 <5474CB5D.9050807@linux.intel.com>
 <20141125184304.GK7712@sirena.org.uk>
 <5474D35A.3000601@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7711380217412431188=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F5222605D1
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 20:38:28 +0100 (CET)
In-Reply-To: <5474D35A.3000601@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel <alsa-devel@alsa-project.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7711380217412431188==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="njUEgrJvs9ryr/H/"
Content-Disposition: inline


--njUEgrJvs9ryr/H/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2014 at 11:07:06AM -0800, Darren Hart wrote:
> On 11/25/14 10:43, Mark Brown wrote:

> > Link from where - do we want to talk to the ACPI/UEFI forum and=20
> > figure out some kind of fast track process for them to add an
> > "it's already covered by DT, see here" entry to their database for=20
> > example?  We also ought to work out how to make sure ACPI IDs are=20
> > registered there as well, should be possible to have something=20
> > simple as part of that.

> This is a current topic with the ACPI working group. We have the
> following document:

> http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-=
UUID.pdf

> I don't know if we want to have a list of them here, or if a separate
> document is needed. The important point is that it is independent from

Seems to me like some indirection is going to be better rather than
having one big document if there's widespread adoption, avoids lots of
document churn.

> the ACPI specification itself so that it can be updated out of band
> with the specification, and not be subject to rather plodding pace
> that would imply.

> Rafael, I've missed several of these meetings unfortunately, and I'm
> not sure if we've closed on this point. Do you know?

OK, I'll see if any of the people at work have been following as well.
For now continuing to just document everything as DT bindings in the way
we are already seems like a sensible interim approach.

--njUEgrJvs9ryr/H/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdNo2AAoJECTWi3JdVIfQuOQH/RuH5sr6dm5AAM46nLbtIvMo
f284D1KELcNyQqxn+LFv5+vqwad2QUf02jFyhQKKSzBO5y+aaRwTPsR/HflkGPIT
OR9qQAAsRqPuUhzn3f3s+bHH+jT+xpEASYDDSOTg07ywTFkxX0Zzn5FrR8j88vMq
75le5PaLkmtuHemzhAe5EhF00LWHbByeB7zRlMSa9B4MZ1fEStIZWZHv2Z3oiuNg
kwTMaJgh6Y+TTuXtuNRgBJUSYKHnaUVm8QFdEH3tApM7NjPZNacQ3uZ/UFPIpGvS
9nZhsSKj/6zxprbL6TXsBefFeNaNz+dPnKhAv01m1j4/gohqL8AZUxCH33og0zQ=
=XVsz
-----END PGP SIGNATURE-----

--njUEgrJvs9ryr/H/--

--===============7711380217412431188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7711380217412431188==--
