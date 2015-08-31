From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ics43432: Fix build errors
Date: Mon, 31 Aug 2015 09:57:59 +0100
Message-ID: <20150831085759.GG12027@sirena.org.uk>
References: <alpine.DEB.2.02.1508281200060.16666@lnxricardw1.se.axis.com>
 <20150828162156.GP12027@sirena.org.uk>
 <alpine.DEB.2.02.1508310854020.16666@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4318126300868131676=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A9B08260561
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 10:58:12 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508310854020.16666@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4318126300868131676==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="My20y6i86AR9cALP"
Content-Disposition: inline


--My20y6i86AR9cALP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2015 at 09:14:02AM +0200, Ricard Wanderlof wrote:
> On Fri, 28 Aug 2015, Mark Brown wrote:
> > On Fri, Aug 28, 2015 at 12:11:48PM +0200, Ricard Wanderlof wrote:

> > I'll apply this since it fixes a build issue but please as I said in re=
ply=20
> > to your earlier off list query send one patch per issue (as covered in=
=20
> > SubmittingPatches) and try to provide useful changelogs describing the=
=20
> > issue being fixed.

> I purposely grouped both the mismatched variable name and license name=20
> into a single patch, because both cause build failures when I tested in a=
n=20
> x86 build, the latter resulting in:

That isn't important or helpful, they are still separate build failures
and should be sent as separate commits.

> I should have been more descriptive in the commit message though. I did=
=20
> feel though that given the diff it was fairly obvious what the problems=
=20
> were so I didn't think it needed further explanation and would only clog=
=20
> up the commit log.

If the commit message is too bad I may not look at the patch.  Part of
the review is making sure that the commit message describes what the
changes are doing to help make sure that the commit does what the author
thinks it does.

--My20y6i86AR9cALP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5BcWAAoJECTWi3JdVIfQ9lYH/2lO059mj/8F1f2wYEkNRxr7
oyitotkPONnEfMxkXiouMHE1klzmdPSFh//saL7/cYy8IoDzuM91tv5hDUFJYRaV
GHzVZvSolC8d3mNiZ5pwq1SQ8l408Doe16v72TkKNCcRH49a1UztA0dVxf2H94CJ
bSId3ySlhujvyAUdQtn3RSKtGCrMAjQv37pmJu/8VND60bTIQ3PiQhR6tj9bE1ZO
3suNU5Ve6iAwggYW02uMJdZuWlq0MrGdIykH+VTZxCGmGNQd8ucxzLtPA6d4wzQE
XCSdL1G3HEQW/W9GPKY7L8JYZ8Ot9OmU+2EYNHw4eA3rlW9/0eKgzjrr2pT/CX8=
=T52h
-----END PGP SIGNATURE-----

--My20y6i86AR9cALP--

--===============4318126300868131676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4318126300868131676==--
