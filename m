From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.39
Date: Tue, 5 Apr 2011 08:33:26 +0900
Message-ID: <20110404233325.GA5376@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 615401037E3
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Apr 2011 01:33:18 +0200 (CEST)
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

The following changes since commit 0ce790e7d736cedc563e1fb4e998babf5a4dbc3d:

  Linux 2.6.39-rc1 (2011-03-29 12:09:47 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.39

All fairly small fixes.

Antonio Ospite (1):
      ASoC: zylonite: set .codec_dai_name in initializer

Mark Brown (3):
      ASoC: Explicitly say registerless widgets have no register
      ASoC: Fix CODEC device name for Corgi
      Merge branch 'for-2.6.39' of git://git.kernel.org/.../broonie/sound-2.6 into for-2.6.39

Stephen Warren (1):
      ASoC: format_register_str: Don't clip register values

Vasily Khoruzhick (1):
      ASoC: PXA: Fix oops in __pxa2xx_pcm_prepare

Wolfram Sang (2):
      ASoC: imx: set watermarks for mx2-dma
      ASoC: imx: fix burstsize for DMA

 include/sound/soc-dapm.h        |   16 ++++++++--------
 sound/arm/pxa2xx-pcm-lib.c      |    3 +++
 sound/soc/imx/imx-pcm-dma-mx2.c |    9 +++++++--
 sound/soc/imx/imx-ssi.h         |    3 ---
 sound/soc/pxa/corgi.c           |    2 +-
 sound/soc/pxa/pxa2xx-pcm.c      |    1 +
 sound/soc/pxa/zylonite.c        |    6 +++---
 sound/soc/soc-core.c            |    8 ++++----
 8 files changed, 27 insertions(+), 21 deletions(-)
