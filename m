From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Thu, 8 Apr 2010 16:11:01 +0100
Message-ID: <20100408151100.GA2710@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C8CB243FA
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 17:11:02 +0200 (CEST)
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

The following changes since commit 5f712b2b73a9fc87fcc52124cfe8adefaa0c92f5:
  Daniel Mack (1):
        ALSA: ASoC: move dma_data from snd_soc_dai to snd_soc_pcm_stream

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

The updates from Sascha are bug fixes for i.MX2x and a vast improvement
in the performance of the FIQ based "DMA" on i.MX3x which allows it to
handle sample rates over 16kHz.  This code is newly added in 2.6.34.

Huang Weiyi (1):
      ASoC: wm2000: remove unused #include <linux/version.h>

Sascha Hauer (3):
      ASoC: imx-ssi: honor IMX_SSI_DMA flag
      ASoC: imx-pcm-dma-mx2: restart DMA after an error
      ASoC: imx-ssi: Use a hrtimer in FIQ mode

 sound/soc/codecs/wm2000.c       |    1 -
 sound/soc/imx/imx-pcm-dma-mx2.c |   15 ++++++++++++-
 sound/soc/imx/imx-pcm-fiq.c     |   45 ++++++++++++++++++--------------------
 sound/soc/imx/imx-ssi.c         |    3 +-
 4 files changed, 37 insertions(+), 27 deletions(-)
