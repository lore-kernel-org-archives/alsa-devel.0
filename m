From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.36
Date: Tue, 20 Jul 2010 13:43:30 +0100
Message-ID: <20100720124330.GO10222@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A4E2103905
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 14:43:32 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 0c74a939d84730818bc9bf1efa5ad7184bb2f248:

  ASoC: au1x: fix section mismatch in psc-i2s.c (2010-07-13 12:39:14 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.36

Axel Lin (2):
      ASoC: wm8727: add a missing return in wm8727_platform_probe
      ASoC:: remove a redundant snd_soc_unregister_codec call in wm8988_reg=
ister

Chanwoo Choi (2):
      ASoC: Select wm_hubs automatically for WM8994
      ASoC:Support Samsung SoC(S5P) in I2Sv2

Eric B=E9nard (1):
      ASoC: eukrea-tlv320: add support for cpuimx35sd

Kulikov Vasiliy (3):
      ASoC: davinci: check kzalloc() result (typo)
      ASoC: imx: check kzalloc() result and fix memory leak
      ASoC: imx: check kzalloc() result and fix memory leak

Kuninori Morimoto (1):
      ASoC: fsi: Add specified ID for soc-audio

Mark Brown (8):
      Merge branch 'for-2.6.35' into for-2.6.36
      ASoC: Handle read failures in codec_reg
      ASoC: Remove duplicate AUX definition from WM8776
      Merge branch 'for-2.6.35' into for-2.6.36
      ASoC: Explicitly disable DC servo on WM hubs headphone powerdown
      ASoC: Implement WM8994 AIF1ADC2 paths
      Merge branch 'for-2.6.35' into for-2.6.36
      ASoC: Unconditionally enable WM8994 AIF1ADC TDM mode

Sekhar Nori (1):
      ASoC: davinci: let platform data define edma queue numbers

 arch/arm/mach-davinci/board-da830-evm.c  |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c  |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c |    4 +-
 arch/arm/mach-davinci/include/mach/asp.h |    3 +-
 include/sound/sh_fsi.h                   |    3 ++
 sound/soc/codecs/Kconfig                 |    4 +-
 sound/soc/codecs/wm8727.c                |    2 +
 sound/soc/codecs/wm8776.c                |    1 -
 sound/soc/codecs/wm8988.c                |    1 -
 sound/soc/codecs/wm8994.c                |   32 ++++++++++++++++++++++++++=
++++
 sound/soc/codecs/wm_hubs.c               |    2 +
 sound/soc/davinci/davinci-i2s.c          |   10 +++++++++
 sound/soc/davinci/davinci-mcasp.c        |    6 +++-
 sound/soc/davinci/davinci-pcm.c          |    5 ++-
 sound/soc/davinci/davinci-pcm.h          |    3 +-
 sound/soc/davinci/davinci-vcif.c         |    2 +-
 sound/soc/imx/Kconfig                    |    2 +-
 sound/soc/imx/eukrea-tlv320.c            |    3 +-
 sound/soc/imx/imx-pcm-dma-mx2.c          |    6 ++++-
 sound/soc/imx/imx-pcm-fiq.c              |    6 ++++-
 sound/soc/s3c24xx/s3c-i2s-v2.c           |    3 +-
 sound/soc/sh/fsi-ak4642.c                |    4 +-
 sound/soc/sh/fsi-da7210.c                |    4 +-
 sound/soc/soc-core.c                     |   22 +++++++++++++++----
 24 files changed, 103 insertions(+), 29 deletions(-)
