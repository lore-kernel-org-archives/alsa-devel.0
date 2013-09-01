From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.12
Date: Sun, 1 Sep 2013 21:22:45 +0100
Message-ID: <20130901202245.GJ3084@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1928179476987639570=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3688A2608EC
 for <alsa-devel@alsa-project.org>; Sun,  1 Sep 2013 22:22:49 +0200 (CEST)
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


--===============1928179476987639570==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Content-Disposition: inline


--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 3fd8a8041b3775840c8f85b6338b61beb5057160:

  Merge tag 'asoc-v3.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-next (2013-08-30 12:35:49 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.12-3

for you to fetch changes up to 5df498a27ab385294fdb7cad19c623d4da94a780:

  Merge remote-tracking branch 'asoc/topic/ssm2602' into tmp (2013-09-01 21:15:59 +0100)

These haven't all been in a -next build yet, they work for me though.

----------------------------------------------------------------

ASoC: Final updates for v3.12

A few final updates for v3.12 - some cleanups, a bug fix for ssm2602,
pop removal for rt5640 and fixes for the reporting of unidirectional
links in the MXS SGTL5000 driver.

----------------------------------------------------------------
Bard Liao (1):
      ASoC: rt5640: change widget sequence for depop

Fabio Estevam (2):
      ASoC: soc-pcm: Allow to specify unidirectional dai_link
      ASoC: mxs-sgtl5000: Configure the dai_links as unidirectional

Lars-Peter Clausen (5):
      ASoC: dapm: Fix auto-disable for inverted controls
      ASoC: Remove unused control_type field from snd_soc_codec struct
      ASoC: Remove unused debugfs_dapm field from snd_soc_{platform,codec} struct
      ASoC: Remove unused sysfs_registered field from snd_soc_codec struct
      ASoC: ssm2602: Fix cache sync

Mark Brown (6):
      Merge remote-tracking branch 'asoc/topic/rt5640' into asoc-dapm
      ASoC: fsl_spdif: Staticse non-exported symbols
      Merge remote-tracking branch 'asoc/topic/core' into tmp
      Merge remote-tracking branch 'asoc/topic/dapm' into tmp
      Merge remote-tracking branch 'asoc/topic/fsl' into tmp
      Merge remote-tracking branch 'asoc/topic/ssm2602' into tmp

Nicolin Chen (2):
      ASoC: fsl: Add wrapping for dev_dbg() in fsl_spdif.c
      ASoC: fsl: Add one blank space after ':=' in Makefile

 include/sound/soc.h          |   8 +-
 sound/soc/codecs/rt5640.c    | 217 ++++++++++++++++++++++++++++++++-----------
 sound/soc/codecs/rt5640.h    |  12 +++
 sound/soc/codecs/ssm2602.c   |   3 +-
 sound/soc/fsl/Makefile       |   2 +-
 sound/soc/fsl/fsl_spdif.c    |  12 +--
 sound/soc/mxs/mxs-sgtl5000.c |   2 +
 sound/soc/soc-dapm.c         |   2 +
 sound/soc/soc-pcm.c          |  10 ++
 9 files changed, 202 insertions(+), 66 deletions(-)

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSI6ISAAoJELSic+t+oim9Kz8P/RAOQf5sPBdIKRmCtZnrJ3XH
xYJhiMjkOc4Yz0gr1hHIiklwAMkP+XKpWaBZV9pfsHxPD0V5sVF6DBi8oTsOSUjH
32DU9Uz/lhUOwiI++GuSFvtSabZ0t+Jn1iBeF5pqj7/OJ+IevJ+2g7mjSRBBnW2X
aMgWaZp0WpWkWY4fV9kvQJRTPdiZJBmXWZcMBagHpVaSCbKaFvFATryho+EsKbcf
t2QFsWimaIUj7Ccc4QTumHIXW+gDhMajFp72m46ykBTN6YQJxWVWZ2uD5YdpQamS
mq+DCBdNacFw5ZIV824uNTBsxxknYm49ah/Iq7KRJWuVFt41s8Vb8R/+jB2yImd4
nT/2J95yBrmve3tnZoe/RSSil3rBWLvS/BzwNcgoewp1MoEOTT66BVxn/ov/DfEo
59ZyI+ltod5UzV98C5VdFe/iGlNSHj/c5ta9EGYoFMNqN4zmY/uw4Xhri2xfdGY+
EJWbyj+gRsVZZA8feQlQt+E1z5ZC4iH00qg/L8M/Du6YFB1pNMleSPW2/wePp7Wx
/lQ8ENLgSa3wcYk2VFeiIVuH1fb33nQv4ISNTB4AsP0TFNBaOSPEEd7SA6RfwJmY
1ySmdwO+BUfbbGLEfaFJMSMeo3YXimULukY3RaIUpzVtorK8fHr+hFcSH3Fv0+0k
dlF98ZDW8AHQtD0QnvNX
=+43G
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--

--===============1928179476987639570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1928179476987639570==--
