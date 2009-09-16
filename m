From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.32
Date: Wed, 16 Sep 2009 21:15:55 +0100
Message-ID: <20090916201555.GA20675@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C41761038B5
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 22:15:56 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit cdc65fbe18aef15e92d2ebb410a189fbf956fb06:
  Manuel Lauss (1):
        ASoC: au1x: PSC-AC97 bugfixes

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Huang Weiyi (1):
      ASoC: remove unused #include <linux/version.h>

Jassi (1):
      ASoC: S3C lrsync function made to work with IRQs disabled.

Julia Lawall (1):
      ASoC: Clean up error handling in MPC5200 DMA setup

Mark Brown (1):
      ASoC: Fix display of stream name in DAPM debugfs

 sound/soc/codecs/ad1836.c      |    1 -
 sound/soc/codecs/ad1938.c      |    1 -
 sound/soc/codecs/wm8974.c      |    1 -
 sound/soc/fsl/mpc5200_dma.c    |   33 ++++++++++++++++++++-------------
 sound/soc/s3c24xx/s3c-i2s-v2.c |   16 ++++++++++------
 sound/soc/soc-dapm.c           |    7 ++++---
 6 files changed, 34 insertions(+), 25 deletions(-)
