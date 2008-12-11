From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/2] ASoC updates
Date: Thu, 11 Dec 2008 16:17:52 +0000
Message-ID: <20081211161752.GA25028@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C4034245F2
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 17:17:53 +0100 (CET)
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

The following changes since commit 6de45d5d776d2a7e7a9adc8ea49d37fe1bd45fb2:
  Takashi Iwai (1):
        ALSA: ASoC - Fix DAI registration in s3c2443-ac97.c

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-tiwai

Mark Brown (1):
      ASoC: Fix variable name for Blackfin I2S DAI

Stanley.Miao (1):
      ASoC: TWL4030: hands-free start-up sequence.

 sound/soc/blackfin/bf5xx-i2s.c |    4 ++--
 sound/soc/codecs/twl4030.c     |   34 ++++++++++++++++++++++++++++++----
 sound/soc/codecs/twl4030.h     |    6 ++++++
 3 files changed, 38 insertions(+), 6 deletions(-)
