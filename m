From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Atom: fix regression on
	compress DAI
Date: Mon, 1 Feb 2016 23:19:07 +0000
Message-ID: <20160201231907.GL4455@sirena.org.uk>
References: <1454354716-17313-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5496459973643043698=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E92CB2606C1
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 00:19:13 +0100 (CET)
In-Reply-To: <1454354716-17313-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============5496459973643043698==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ah40dssYA/cDqAW1"
Content-Disposition: inline


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 01, 2016 at 01:25:16PM -0600, Pierre-Louis Bossart wrote:
> Commit a1068045883ed4a18363a4ebad0c3d55e473b716 added a
> dependency on the compress-cpu-dai channel_min field
> which was removed earlier by commit
> 77095796ae9cbaf315f80611edb5aa569796e339 as part of the
> baytrail cleanups.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access
or slow internet access.  I do frequently catch up on my mail on flights
or while otherwise travelling so this is even more pressing for me than
just being about making things a bit easier to read.

Please also use abbreviated commit IDs, the entire SHA1 is a bit long
and does nothing for legibility.

--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWr+fqAAoJECTWi3JdVIfQIywH/1P7CS6/zNZNY+1qpto9uKza
iBEm1tv1vor0Qq4ndgebrua8Xg2IWTuMEduxvJvAlmtRuC7leHoAjD4P9zlwIplG
nWJBbTKhpbv6OpEiD9eYpHMimfaqHKKAMciJLw6k+98D3S/6nsQaJauPDQb6Z5L4
neu6q+tqMuQPvryZ5MANnVIkwBlhyKyGxRAc65W0tOvbgt7y4Ax0uFu8B0+Np67T
kqWKnzmyuZ8nYwMFlU2vwiuuARMwjuBkANKkax26yVBh/mM3DE6fnpHZmv8conZi
6yKCWmU8IzkTfdV9ykwP1g3LE4uMhMQqu1j2H5QyogMYkkWds/eqf9Kv2LyPQHE=
=L2+o
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--

--===============5496459973643043698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5496459973643043698==--
