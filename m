From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.2
Date: Tue, 13 Dec 2011 09:40:44 +0800
Message-ID: <20111213014041.GC15314@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 34F9710386C
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 02:41:23 +0100 (CET)
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
To: Taksahi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit cefcc03ffc9527dde56807339edb1719c8dbae5f:

  ASoC: Provide a more complete DMA driver stub (2011-12-06 10:05:07 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.2

The usual story - nothing major fixed here but all small, useful fixes.

Axel Lin (5):
      ASoC: Include linux/io.h for jz4740 codec
      ASoC: Fix build dependency for SND_SOC_JZ4740_CODEC
      ASoC: Fix a typo in jive_wm8750
      ASoC: Include linux/module.h for smdk2443_wm9710
      ASoC: Fix hx4700 error handling to free gpios if snd_soc_register_car=
d fails

Jonathan Neusch=E4fer (1):
      ASoC: WM8958: correctly show firmware magic on mismatch

Lothar Wa=DFmann (2):
      ASoC: mxs: Add missing MODULE_LICENSE("GPL")
      ASoC: mxs: Add appropriate MODULE_ALIAS()

Mark Brown (1):
      ASoC: Fix WM8996 24.576MHz clock operation

 sound/soc/codecs/Kconfig            |    2 +-
 sound/soc/codecs/jz4740.c           |    1 +
 sound/soc/codecs/wm8958-dsp2.c      |    2 ++
 sound/soc/codecs/wm8996.c           |    1 +
 sound/soc/mxs/mxs-pcm.c             |    3 +++
 sound/soc/mxs/mxs-sgtl5000.c        |    1 +
 sound/soc/pxa/hx4700.c              |    5 +++--
 sound/soc/samsung/jive_wm8750.c     |    3 +--
 sound/soc/samsung/smdk2443_wm9710.c |    1 +
 9 files changed, 14 insertions(+), 5 deletions(-)
