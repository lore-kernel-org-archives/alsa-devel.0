From: Mark Brown <broonie@kernel.org>
Subject: ASoC fixes for v4.1
Date: Thu, 30 Apr 2015 15:37:50 +0100
Message-ID: <20150430143750.GY22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6686350710558363289=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05BB7261A3B
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 16:37:55 +0200 (CEST)
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


--===============6686350710558363289==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3xqQfIGu34p6u02U"
Content-Disposition: inline


--3xqQfIGu34p6u02U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v4.1-rc1

for you to fetch changes up to d839c98f98826f0c13e46d5a4cecb46dd357b50e:

  Merge remote-tracking branches 'asoc/fix/rt5677', 'asoc/fix/samsung' and 'asoc/fix/tfa9879' into asoc-linus (2015-04-29 13:37:31 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.1

A few fixes for v4.1, none earth shattering and mostly driver related
except for one change to fix !PM builds for Intel platforms which is
done by adding stubs in the core so other platforms don't run into the
same issue.

----------------------------------------------------------------
Axel Lin (1):
      ASoC: rt5645: Fix mask for setting RT5645_DMIC_2_DP_GPIO12 bit

Bard Liao (2):
      ASoC: rt5677: add register patch for PLL
      ASoC: rt5677: fixed wrong DMIC ref clock

Charles Keepax (1):
      ASoC: dapm: Enable autodisable on SOC_DAPM_SINGLE_TLV_AUTODISABLE

Fabio Estevam (1):
      ASoC: fsl_ssi: Fix platform_get_irq() error handling

Fang, Yang A (1):
      ASoC: rt5645: Add ACPI match ID

Jie Yang (1):
      ASoC: add static inline funcs to fix a compiling issue

Jin Yao (1):
      ASoC: Intel: Remove invalid kfree of devm allocated data

Kuninori Morimoto (1):
      ASoC: rsnd: set dmaen->chan = NULL when error case

Mark Brown (5):
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/email', 'asoc/fix/fsl-ssi', 'asoc/fix/pm', 'asoc/fix/qcom' and 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rt5677', 'asoc/fix/samsung' and 'asoc/fix/tfa9879' into asoc-linus

Rajeev Kumar (1):
      ASoC: Update email-id of Rajeev Kumar

Takashi Iwai (1):
      ASoC: qcom: Return an error for invalid PCM trigger command

Vinod Koul (1):
      ASoC: Intel: fix the makefile for atom code

Wei Yongjun (3):
      ASoC: tfa9879: Fix return value check in tfa9879_i2c_probe()
      ASoC: samsung: s3c24xx-i2s: Fix return value check in s3c24xx_iis_dev_probe()
      ASoC: Intel: sst_byt: remove kfree for memory allocated with devm_kzalloc

 include/sound/designware_i2s.h              |  2 +-
 include/sound/soc-dapm.h                    |  2 +-
 include/sound/soc.h                         | 12 ++++++++++++
 include/sound/spear_dma.h                   |  2 +-
 sound/soc/codecs/rt5645.c                   | 13 ++++++++++++-
 sound/soc/codecs/rt5677.c                   |  5 ++++-
 sound/soc/codecs/tfa9879.c                  |  4 ++--
 sound/soc/fsl/fsl_ssi.c                     |  2 +-
 sound/soc/intel/Makefile                    |  2 +-
 sound/soc/intel/baytrail/sst-baytrail-ipc.c |  1 -
 sound/soc/intel/haswell/sst-haswell-ipc.c   |  1 -
 sound/soc/qcom/lpass-cpu.c                  |  2 +-
 sound/soc/samsung/s3c24xx-i2s.c             |  4 ++--
 sound/soc/sh/rcar/dma.c                     |  1 +
 14 files changed, 39 insertions(+), 14 deletions(-)

--3xqQfIGu34p6u02U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQj49AAoJECTWi3JdVIfQUUYH/27TbN5LSH5Kp8xXl5sjivsu
dSTlWGDUnRIwxt0RZgyUzREcWn1ivM++L2dkuPqhMM4w/9WGR4jRunuFe/18kco4
HyITEhLkyMDIFG3nu0G9wnYKVNO+UBolvJ9OXSeTeYUXpuY/GzMYh9rxRLnwjsoT
018QCdW0XeG/C6QNloxtHcIGGrAHWo1VgYAcDBEheRLNnFpknGPCwFvvhogHRl21
Bd3pOnObrJPX6JSh2QEkxksmvqKrqaGS8QMOqyRItIfThA+P8hU70gS7qY2MXSZY
zzZog37/oJSlKPxcNvpkuXa9RhYq/IJaA7vfucQIpafePUBiMtsDn13teRrlD7M=
=G1xn
-----END PGP SIGNATURE-----

--3xqQfIGu34p6u02U--

--===============6686350710558363289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6686350710558363289==--
