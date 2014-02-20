From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 000/102 - chunk#3] Actually fix wrong enum
	items
Date: Thu, 20 Feb 2014 11:05:29 +0900
Message-ID: <20140220020529.GG2669@sirena.org.uk>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3673362810423519143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F176E265610
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:24:41 +0100 (CET)
In-Reply-To: <1392723422-12689-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3673362810423519143==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6O65XvyGdheuigXk"
Content-Disposition: inline


--6O65XvyGdheuigXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2014 at 12:36:51PM +0100, Takashi Iwai wrote:
> Now, this patch chunk fixes the actual bugs in various codec drivers
> that have either off-by-one number of items or lead to array overflow.
>=20
> sta32x is the latter one, and this can be picked up for 3.14, too.
>=20
> The other off-by-one fixes would change the driver behavior (now user
> will see more items), thus they are potential regression risks
> although the "fixes" are correct, per se.

Since these are actual bug fixes they should probably have been at the
start of the series rather than dropped into the middle of it, this
makes it easier to direct them to the right place.

--6O65XvyGdheuigXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWLlAAoJELSic+t+oim9sI8P/jeNiMyQdJW3js/fB9h+88JM
ANYJzUsTda4Fi3ZV+AiYKkdizTWph4mfx0/G1GH0qtR6/xWj4SiAYqcf2BtzSYyy
4KdrJ3gi5yeq0qv+7eOfwPmLQyp9KE/EKE8LK5uRoROWdgrg+VBxx54mHgONpdbs
UeVAQn7r5gnt0L1mu9CYwGZh66QA7WuFaQqg+Bvb276xyYMsqcs9l4Wdrfx4sUGV
MSOkRGAonNCJEOqdTio/vAaFSkkj5M+xceKr9AtaSrAnt647jFayHh0Pz+krZCcw
Jo1O/ZSNd0VdA4e4jpIEjUSpKN1z584KygSNaL5SwlmuzUCZTXak9NYebAXgMfS3
TjXOB1Fk2o10qZgFQUQihOFERL6EZfi5CFQFflihE3HHezjx81CtSWcJGK+cTL3v
e7by1aOEjB8wjLJKijyRq9bAFY6flw0crbiGhvF6f6C34HzQK6E9iyiPFh0UBSCz
aPpLL44AMdZR207SeqcIl3SAliPtsR8Ds3TFjv3bPJBBIlYRFLt4+EQtTn3JIJRl
NERZ4VhU5jWIqmrWnt54Uk4ig2pc0/J88/qCROCnaJBNULpSS8UynbGvaB7g3qw+
RNncqCVnJkK6PkxpemomXAD1l07ITWVxGisd2lTKWGmfELy4WHsl7fDaSVdrapw5
ayHzuIdaE4eZx0Urgtx9
=Pgqr
-----END PGP SIGNATURE-----

--6O65XvyGdheuigXk--

--===============3673362810423519143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3673362810423519143==--
