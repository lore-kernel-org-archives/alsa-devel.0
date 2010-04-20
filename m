From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Tue, 20 Apr 2010 09:58:40 +0900
Message-ID: <20100420005839.GA32307@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD8492497E
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Apr 2010 02:58:34 +0200 (CEST)
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

The following changes since commit d21e0f4cd16656f71207683ee27465600ad21625:
  Marek Vasut (1):
        ASoC: Zipit Z2 WM8750 ASoC driver

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Huang Weiyi (1):
      ASoC: wm2000: remove unused #include <linux/version.h>

Mark Brown (2):
      Merge branch 'for-2.6.34' into for-2.6.35
      ASoC: Add indirection for CODEC private data

Sascha Hauer (5):
      ASoC: imx-ssi: honor IMX_SSI_DMA flag
      ASoC: imx-pcm-dma-mx2: restart DMA after an error
      ASoC: imx-ssi: Use a hrtimer in FIQ mode
      ASoC: imx-ssi: increase minimum periods to 4
      ASoC: imx-ssi: do not call hrtimer_disable in trigger function

 include/sound/soc.h             |   13 ++++++++-
 sound/soc/codecs/ad1836.c       |    2 +-
 sound/soc/codecs/ad193x.c       |    2 +-
 sound/soc/codecs/ak4104.c       |    2 +-
 sound/soc/codecs/ak4535.c       |   10 +++---
 sound/soc/codecs/ak4642.c       |    2 +-
 sound/soc/codecs/ak4671.c       |    2 +-
 sound/soc/codecs/cs4270.c       |   20 +++++++-------
 sound/soc/codecs/cx20442.c      |    2 +-
 sound/soc/codecs/da7210.c       |    2 +-
 sound/soc/codecs/ssm2602.c      |   12 ++++----
 sound/soc/codecs/stac9766.c     |    2 +-
 sound/soc/codecs/tlv320aic3x.c  |   10 +++---
 sound/soc/codecs/tlv320dac33.c  |   36 ++++++++++++------------
 sound/soc/codecs/twl4030.c      |   32 +++++++++++-----------
 sound/soc/codecs/uda134x.c      |   16 +++++-----
 sound/soc/codecs/uda1380.c      |    4 +-
 sound/soc/codecs/wm2000.c       |    1 -
 sound/soc/codecs/wm8350.c       |   28 ++++++++++----------
 sound/soc/codecs/wm8400.c       |   16 +++++-----
 sound/soc/codecs/wm8523.c       |   10 +++---
 sound/soc/codecs/wm8580.c       |    4 +-
 sound/soc/codecs/wm8711.c       |    6 ++--
 sound/soc/codecs/wm8731.c       |   10 +++---
 sound/soc/codecs/wm8750.c       |    7 ++---
 sound/soc/codecs/wm8753.c       |    8 +++---
 sound/soc/codecs/wm8776.c       |    6 ++--
 sound/soc/codecs/wm8900.c       |   10 +++---
 sound/soc/codecs/wm8903.c       |   20 +++++++-------
 sound/soc/codecs/wm8904.c       |   42 +++++++++++++++---------------
 sound/soc/codecs/wm8940.c       |    4 +-
 sound/soc/codecs/wm8955.c       |   16 +++++-----
 sound/soc/codecs/wm8960.c       |    6 ++--
 sound/soc/codecs/wm8961.c       |    6 ++--
 sound/soc/codecs/wm8971.c       |   12 ++++----
 sound/soc/codecs/wm8974.c       |    2 +-
 sound/soc/codecs/wm8978.c       |   12 ++++----
 sound/soc/codecs/wm8988.c       |    8 +++---
 sound/soc/codecs/wm8990.c       |    8 +++---
 sound/soc/codecs/wm8993.c       |   24 ++++++++--------
 sound/soc/codecs/wm8994.c       |   34 ++++++++++++------------
 sound/soc/codecs/wm9081.c       |   18 ++++++------
 sound/soc/codecs/wm9713.c       |   13 +++++----
 sound/soc/codecs/wm_hubs.c      |    6 ++--
 sound/soc/imx/imx-pcm-dma-mx2.c |   15 ++++++++++-
 sound/soc/imx/imx-pcm-fiq.c     |   55 ++++++++++++++++++++------------------
 sound/soc/imx/imx-ssi.c         |    3 +-
 47 files changed, 303 insertions(+), 276 deletions(-)
