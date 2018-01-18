From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: bcm2835: fix hw_params error when
	device is in prepared state" to the asoc tree
Date: Thu, 18 Jan 2018 11:22:47 +0000
Message-ID: <E1ec8HP-0003k8-GV@debutante>
References: <20180117125050.2948-1-hias@horus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CF9542671A8
 for <alsa-devel@alsa-project.org>; Thu, 18 Jan 2018 12:22:52 +0100 (CET)
In-Reply-To: <20180117125050.2948-1-hias@horus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Reichl <hias@horus.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, alsa-devel@alsa-project.org, Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>, Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: bcm2835: fix hw_params error when device is in prepared state

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8d5737a5f53902a916ee1e1cb248c9b8b883b2ea Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Wed, 17 Jan 2018 13:50:50 +0100
Subject: [PATCH] ASoC: bcm2835: fix hw_params error when device is in prepared
 state

If bcm2835 is configured as bitclock master calling hw_params()
after prepare() fails with EBUSY. This also makes it impossible to
use bcm2835 in full duplex mode.

The error is caused by the split clock setup: clk_set_rate
is called in hw_params, clk_prepare_enable in prepare. As hw_params
doesn't check if the clock was already enabled clk_set_rate
fails with EBUSY.

Fix this by moving clock startup from prepare to hw_params and
let hw_params properly deal with an already set up or enabled
clock.

Signed-off-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 2e449d7173fc..d5f73a8ab893 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -130,6 +130,7 @@ struct bcm2835_i2s_dev {
 	struct regmap				*i2s_regmap;
 	struct clk				*clk;
 	bool					clk_prepared;
+	int					clk_rate;
 };
 
 static void bcm2835_i2s_start_clock(struct bcm2835_i2s_dev *dev)
@@ -419,10 +420,19 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Clock should only be set up here if CPU is clock master */
-	if (bit_clock_master) {
-		ret = clk_set_rate(dev->clk, bclk_rate);
-		if (ret)
-			return ret;
+	if (bit_clock_master &&
+	    (!dev->clk_prepared || dev->clk_rate != bclk_rate)) {
+		if (dev->clk_prepared)
+			bcm2835_i2s_stop_clock(dev);
+
+		if (dev->clk_rate != bclk_rate) {
+			ret = clk_set_rate(dev->clk, bclk_rate);
+			if (ret)
+				return ret;
+			dev->clk_rate = bclk_rate;
+		}
+
+		bcm2835_i2s_start_clock(dev);
 	}
 
 	/* Setup the frame format */
@@ -618,8 +628,6 @@ static int bcm2835_i2s_prepare(struct snd_pcm_substream *substream,
 	struct bcm2835_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
 	uint32_t cs_reg;
 
-	bcm2835_i2s_start_clock(dev);
-
 	/*
 	 * Clear both FIFOs if the one that should be started
 	 * is not empty at the moment. This should only happen
-- 
2.15.1
