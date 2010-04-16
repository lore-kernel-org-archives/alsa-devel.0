From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Fri, 16 Apr 2010 11:23:05 +0900
Message-ID: <20100416022304.GA2657@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 861661037F9
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Apr 2010 04:23:02 +0200 (CEST)
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

As mentioned last time I posted these the updates here are very large
for 2.6.34 but the bulk of them are improvements to the newly added
i.MX3x FIQ driver which make it able to play 44.1k and 48k which is
sufficiently worthwhile that (especially in a new driver) I think it's
worth the risk of making a fairly large change now.

Huang Weiyi (1):
      ASoC: wm2000: remove unused #include <linux/version.h>

Sascha Hauer (5):
      ASoC: imx-ssi: honor IMX_SSI_DMA flag
      ASoC: imx-pcm-dma-mx2: restart DMA after an error
      ASoC: imx-ssi: Use a hrtimer in FIQ mode
      ASoC: imx-ssi: increase minimum periods to 4
      ASoC: imx-ssi: do not call hrtimer_disable in trigger function

 sound/soc/codecs/wm2000.c       |    1 -
 sound/soc/imx/imx-pcm-dma-mx2.c |   15 ++++++++++-
 sound/soc/imx/imx-pcm-fiq.c     |   55 ++++++++++++++++++++------------------
 sound/soc/imx/imx-ssi.c         |    3 +-
 4 files changed, 45 insertions(+), 29 deletions(-)
