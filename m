From: Mark Brown <broonie@kernel.org>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Tue, 2 Jul 2013 15:58:21 +0100
Message-ID: <20130702145821.GN27646@sirena.org.uk>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D22CAE.2020302@ti.com> <51D26CD8.7020709@topic.nl>
 <20130702121625.GM27646@sirena.org.uk> <51D2D60B.2010205@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7994065595378732105=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D9518265484
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 16:58:26 +0200 (CEST)
In-Reply-To: <51D2D60B.2010205@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Joel Fernandes <joelf@ti.com>, alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org


--===============7994065595378732105==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ExLobwx2ErZCZZ6w"
Content-Disposition: inline


--ExLobwx2ErZCZZ6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2013 at 03:30:51PM +0200, Mike Looijmans wrote:

> things that would be obvious for long-time developers, like finding
> out who the maintainer for a piece of code is. I still don't know
> that, by the way. How do I find the "CC" list that I'm supposed to
> send bugs/suggestions/patches to for a given piece of code?

MAINTAINERS and git log should give you a good guide - there's a script
called get_maintainer.pl in the kernel which will help but shouldn't be
100% relied on.  Basically just look at revision control history and
see who's been working on the code.

> I guess that a document on kernel-driver-development-for-people-who-used-to-work-with-a-centrally-organized-OS-and-used-to-get-all-their-answers-from-them
> would help, but then again finding that particular document - or
> realizing that it even exists (it doesn't, does it?) - would be the
> next problem.

That's what MAINTAINERS is there for.

> It's quite easy to find out how one goes about writing a driver, but
> the process surrounding it - such as finding whether such a driver
> already exists, where to go for technical advice and where to post
> the git patch for inclusion in mainline is something that no one
> seems to want to dwell on.

Documentation/SubmittingPatches is a pretty good starting point.

--ExLobwx2ErZCZZ6w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0uqKAAoJELSic+t+oim9R2EQAITVOtZe4xyf9HxdZJJ9/hzA
fp0HkBBJGCpI7+1HYopiOwsY2485s2g5wYelaVQ6aFWjSJ3KGHmSWEzrtboMpTr1
Pad4Fxq52jpsi+mx2J93TUEUuNwwWBGukqSDM62Pp9aSE0FNQpLpjPKr6LZ1mX1H
blOey/lIQAcO4yORoOQuiIyahcX6ITCrAioAU7Lc6kf+wASUNhto4hA+nYEh577g
ZfMVI3AbP5BrcRwYwByr2XDpFWr91kvbbL0g1sOQ3tz5DipV9QKJdK4ETQMXlgn5
lyVd01QQdbJHqOd72wHNtI7Kf74pABbQgw6zGcUmnm7S72GYReHV4CtloPq/NWcK
PZmgVCSYD0E18AIeAb5alm9pB6v3TNmxVunvl64COO92rH6fEtHHJnrQFsr6ekO/
OvMQ116wJPl9EU86bMqAE+SkH7nXQjjZ/t6fcS5jtQWq5QczNufqRmoGfSrIOgh7
/Ed6YcOcXg4ubC8HTJ+qBdzuKtBVd3jH6WY0JaFLXK0i0LDaEGGK1duwTy7kQpQz
WMLe6o4NuuFs4Jv+8IVjERp/Qv0iu/nekEnGIzq76JClkPG+G4OuiXHmCyoOaLzj
8RrjgI5AZdEVHjbyq9vpHfGigl9U08n+u7eOqGGwLNh5VVis571eTLzAGF1oVW6y
dRablXXqS/7l8PUh6l54
=Fsb9
-----END PGP SIGNATURE-----

--ExLobwx2ErZCZZ6w--

--===============7994065595378732105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7994065595378732105==--
