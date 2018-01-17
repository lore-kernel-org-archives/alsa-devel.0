From: Matthias Reichl <hias@horus.com>
Subject: [PATCH] ASoC: bcm2835: fix hw_params error when device
	is in prepared state
Date: Wed, 17 Jan 2018 13:50:50 +0100
Message-ID: <20180117125050.2948-1-hias@horus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BF85266E42
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 13:50:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: alsa-devel@alsa-project.org, Phil Elwell <phil@raspberrypi.org>, linux-rpi-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

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
2.11.0
