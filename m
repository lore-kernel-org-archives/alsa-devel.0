From: Mark Brown <broonie@kernel.org>
Subject: ASoC AC'97 fix for v3.19
Date: Thu, 5 Feb 2015 19:48:11 +0000
Message-ID: <20150205194811.GO21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6112205658087808828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AD92265054
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 20:48:15 +0100 (CET)
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


--===============6112205658087808828==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mbOpr5OEsHYYw3vj"
Content-Disposition: inline


--mbOpr5OEsHYYw3vj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-ac97-v3.19-rc7

for you to fetch changes up to f8d71be5553a3fbc20363243ecfc11dcdd1e18fe:

  ASoC: wm97xx: Reset AC'97 device before registering it (2015-01-26 19:15:06 +0000)

----------------------------------------------------------------
ASoC: AC'97 fixes

These are rather too large for this late in the release cycle but
they're clear, well understood and have been tested to fix a regression
which was introduced for v3.19.  The details are all in Lars' changelog
and they've been cooking in -next for a while, to a large extent out
of conservatism about the size.

----------------------------------------------------------------
Lars-Peter Clausen (2):
      ASoC: Add support for allocating AC'97 device before registering it
      ASoC: wm97xx: Reset AC'97 device before registering it

 include/sound/soc.h       |  1 +
 sound/soc/codecs/wm9705.c | 16 ++++++++++------
 sound/soc/codecs/wm9712.c | 12 ++++++++----
 sound/soc/codecs/wm9713.c | 12 ++++++++----
 sound/soc/soc-ac97.c      | 36 ++++++++++++++++++++++++++++++------
 5 files changed, 57 insertions(+), 20 deletions(-)

--mbOpr5OEsHYYw3vj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU08j6AAoJECTWi3JdVIfQdXoH/2nG9zscoOL1EyyMoKT9Et8g
Vh00bxK3jTrB5zjnebi7eFQVCxOji6qMlZoOMOo3CZ753pzNU7nv9JAwAfS3SzeC
OXIavCMYYWwk7kaEPuYc/bDeRCKesDyqI/DO0a2/g2SuAZyjrOsWGqLeYrxU8m0X
0yeijv+MNqIKLSQMtJ+Hko8LhdhMSemEVVTMCz6LNW+XG00wOF9f6wdR686Kh2V8
CBIB/3IfVyUxJrTroUGftEst11ySmVw/aZ8FykUXdTUsOBPyB5YyHOuykU4l25/1
48zWrDzN3wFlAntXs1KCFsYc2I5425SwTphlHVUGP3pa3Iqkod2Fwqj2oFDu0wI=
=7tNk
-----END PGP SIGNATURE-----

--mbOpr5OEsHYYw3vj--

--===============6112205658087808828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6112205658087808828==--
