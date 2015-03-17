From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.0
Date: Tue, 17 Mar 2015 11:36:35 +0000
Message-ID: <20150317113635.GB28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4795189783413720242=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6383A261B01
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 12:36:42 +0100 (CET)
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


--===============4795189783413720242==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JsPm5tED8eNFkDPA"
Content-Disposition: inline


--JsPm5tED8eNFkDPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.0-rc4

for you to fetch changes up to 33484c67398295108ab31e17b50b5a6fba1f5eef:

  Merge remote-tracking branches 'asoc/fix/sgtl5000' and 'asoc/fix/sn95031' into asoc-linus (2015-03-16 12:03:17 +0000)

----------------------------------------------------------------
ASoC: Fixes for v4.0

As well as the usual collection of driver specific fixes there's a few
more generic things:

 - Lots of fixes from Takashi for drivers using the wrong field in the
   control union to communicate with userspace, leading to potential
   errors on 64 bit systems.
 - A fix from Lars for locking of the lists of devices we maintain,
   mostly only likely to trigger during device probe and removal.

----------------------------------------------------------------
Bard Liao (1):
      ASoC: rt286: Change the DMI mapping for Dino

Eric Nelson (1):
      ASoC: sgtl5000: remove useless register write clearing CHRGPUMP_POWERUP

Lars-Peter Clausen (4):
      ASoC: ak4671: Fix control-less DAPM routes
      ASoC: da732x: Fix control-less DAPM routes
      ASoC: sn95031: Fix control-less DAPM routes
      ASoC: Fix component lists locking

Lu, Han (1):
      ASoC: Intel: remove conflicts when load/unload multiple firmware images

Maciej S. Szmigiero (1):
      fsl_ssi: fix of_property_read_u32_array return value check

Mark Brown (3):
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/ak4671', 'asoc/fix/control', 'asoc/fix/da732x', 'asoc/fix/fsl-ssi', 'asoc/fix/lock' and 'asoc/fix/rt286' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/sgtl5000' and 'asoc/fix/sn95031' into asoc-linus

Nicolin Chen (1):
      ASoC: fsl_ssi: Don't try to round-up for PM divisor calculation

Takashi Iwai (14):
      ASoC: adav80x: Fix wrong value references for boolean kctl
      ASoC: ak4641: Fix wrong value references for boolean kctl
      ASoC: cs4271: Fix wrong value references for boolean kctl
      ASoC: es8238: Fix wrong value references for boolean kctl
      ASoC: pcm1681: Fix wrong value references for boolean kctl
      ASoC: tas5086: Fix wrong value references for boolean kctl
      ASoC: wm2000: Fix wrong value references for boolean kctl
      ASoC: wm8731: Fix wrong value references for boolean kctl
      ASoC: wm8903: Fix wrong value references for boolean kctl
      ASoC: wm8904: Fix wrong value references for boolean kctl
      ASoC: wm8955: Fix wrong value references for boolean kctl
      ASoC: wm8960: Fix wrong value references for boolean kctl
      ASoC: wm9712: Fix wrong value references for boolean kctl
      ASoC: wm9713: Fix wrong value references for boolean kctl

 sound/soc/codecs/adav80x.c        |  4 ++--
 sound/soc/codecs/ak4641.c         |  4 ++--
 sound/soc/codecs/ak4671.c         | 44 +++++++++++++++++++--------------------
 sound/soc/codecs/cs4271.c         |  4 ++--
 sound/soc/codecs/da732x.c         |  8 +++----
 sound/soc/codecs/es8328.c         |  4 ++--
 sound/soc/codecs/pcm1681.c        |  4 ++--
 sound/soc/codecs/rt286.c          |  2 +-
 sound/soc/codecs/sgtl5000.c       |  8 +------
 sound/soc/codecs/sn95031.c        |  4 ++--
 sound/soc/codecs/tas5086.c        |  4 ++--
 sound/soc/codecs/wm2000.c         |  8 +++----
 sound/soc/codecs/wm8731.c         |  4 ++--
 sound/soc/codecs/wm8903.c         |  4 ++--
 sound/soc/codecs/wm8904.c         |  4 ++--
 sound/soc/codecs/wm8955.c         |  4 ++--
 sound/soc/codecs/wm8960.c         |  4 ++--
 sound/soc/codecs/wm9712.c         |  6 +++---
 sound/soc/codecs/wm9713.c         |  6 +++---
 sound/soc/fsl/fsl_ssi.c           |  4 ++--
 sound/soc/intel/sst-haswell-dsp.c |  3 ---
 sound/soc/intel/sst-haswell-ipc.c | 32 +++++++++++++++++++++-------
 sound/soc/soc-core.c              | 41 ++++++++++++++++++++++++++----------
 23 files changed, 118 insertions(+), 92 deletions(-)

--JsPm5tED8eNFkDPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCBHCAAoJECTWi3JdVIfQNPIH/RvlGwYQPl/TffpzN3ttXic9
clZJPmA6vISQNQBrf5QWzePki+st9E5ppqVI+TJkHb23LUOQR5Ir7Uv8AOQxjEWG
UpyIpW6BihAnTyCDrY3fmotY7xDi6rZ85n6H/02xp4njY22RDo+WQBEyBgCiZFj0
aSfPVkqv3NOmChUcxyyfKR3Nnc88BvcbwI2WN5oYD6Q8Lj2nT4ci3SN7lSAUqZfA
D7Rh0pZ31Eax5tmi78gE7j854abEgq/P1juo7I3zX2DSCpRMnEkTRFmtSvDe1Jla
E5Rs7FQ6JkSjDB0sp+PI4ea5/uvcUyB3HNtVnpB13nsbwU6pYDKntROcAwAvY/g=
=3Ikq
-----END PGP SIGNATURE-----

--JsPm5tED8eNFkDPA--

--===============4795189783413720242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4795189783413720242==--
