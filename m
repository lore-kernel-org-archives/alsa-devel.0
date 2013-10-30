From: Mark Brown <broonie@kernel.org>
Subject: ASoC fixes for v3.12
Date: Wed, 30 Oct 2013 10:25:53 -0700
Message-ID: <20131030172553.GA8065@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3777928834234333514=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2645B261A28
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 18:26:03 +0100 (CET)
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


--===============3777928834234333514==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 959f58544b7f20c92d5eb43d1232c96c15c01bfb:

  Linux 3.12-rc7 (2013-10-27 16:12:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v3.12-rc7

for you to fetch changes up to 8723b795aaa0c5f0b9db2099af575f5e089a63f1:

  Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus (2013-10-30 10:11:55 -0700)

----------------------------------------------------------------

ASoC: Fixes for v3.12

A few of the Coverity fixes from Takashi, one of which (the wm_hubs one)
is particularly noticable.

----------------------------------------------------------------
Mark Brown (1):
      Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus

Takashi Iwai (3):
      ASoC: dapm: Fix source list debugfs outputs
      ASoC: dapm: Return -ENOMEM in snd_soc_dapm_new_dai_widgets()
      ASoC: wm_hubs: Add missing break in hp_supply_event()

 sound/soc/codecs/wm_hubs.c | 1 +
 sound/soc/soc-dapm.c       | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScUEdAAoJELSic+t+oim930sP/2N4btFvRxJtv+8Ewa3ZNOrD
8CRS+bedqdvzpa/9fBmmjw4wgf1BSh2olJiIO68TX+rIP1/o9UcYZTcUXDNL1E+S
pQ19aNXTMTXGE96XTm1ZsvZzJOrrCQZF2+W20JaT0dF2T8bHFJrfCww1TBSC/ADo
qis3+qddjs0L8tPnjdGwUIbqC9uziAdPF0a/xQnYdlHMkEPYzcCiXPn2q8+eNx2E
r/jbYvOFp8n6WG4G+ukQugsE/OJBPzSrldE50Zyx8tgII4E3vHF3g/g6xShBWAR0
6RRJvCFBqdNxe7WiESjNUrTRyYOTARMQ0oTCygm7fb87xgerR1AVkHInURw4KWN0
4IEz3JinO1LB7BIr4DLTF01HWXVkVPJM5iRTKj8LwKOljGfBU3hmlB0R+Bdvm192
PdFKFfgMr5v7CyOGvwBenm/BOseemaYuOi6MdrpQkND96O8bsOjvZXpTPESv4L3l
2MfHRgcbeR+BWjW1GZQQ2U4UcI97iia5mEcdBSRxg5cAp70/Z1oq0efR3+pAEAbO
FcsHJm19Oyc2zoitAupeYCziORhSLVarDmuLDSdqWzQ2cGaaw09y7tcG+aA3qguQ
RZL2gzkPYU1D3Rhj66R5I6EnFo252qzueEDhCPrcWD31E40U5s+hsLwUBBGK6q35
UM2GjLneadyvHCroPdPM
=u6u9
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

--===============3777928834234333514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3777928834234333514==--
