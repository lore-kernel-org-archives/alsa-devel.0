From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH 6/7] ac97c: do a proper reset of the external
	codec
Date: Tue, 24 Mar 2009 13:47:49 +0100
Message-ID: <1237898870-15780-7-git-send-email-hans-christian.egtvedt@atmel.com>
References: <1237898870-15780-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-3-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-4-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-5-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-6-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 343C0103837
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 13:47:52 +0100 (CET)
In-Reply-To: <1237898870-15780-6-git-send-email-hans-christian.egtvedt@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch will enable the AC97C before resetting the external codec,
leaving the AC97C disabled will result in floating I/O lines that can
affect the reset procedure.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 sound/atmel/ac97c.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 7c7521b..75100b0 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -730,17 +730,17 @@ static bool filter(struct dma_chan *chan, void *slave)
 
 static void atmel_ac97c_reset(struct atmel_ac97c *chip)
 {
-	ac97c_writel(chip, MR, AC97C_MR_WRST);
+	ac97c_writel(chip, MR,   0);
+	ac97c_writel(chip, MR,   AC97C_MR_ENA);
+	ac97c_writel(chip, CAMR, 0);
+	ac97c_writel(chip, COMR, 0);
 
 	if (gpio_is_valid(chip->reset_pin)) {
 		gpio_set_value(chip->reset_pin, 0);
 		/* AC97 v2.2 specifications says minimum 1 us. */
-		udelay(10);
+		udelay(2);
 		gpio_set_value(chip->reset_pin, 1);
 	}
-
-	udelay(1);
-	ac97c_writel(chip, MR, AC97C_MR_ENA);
 }
 
 static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
@@ -826,6 +826,8 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 
 	snd_card_set_dev(card, &pdev->dev);
 
+	atmel_ac97c_reset(chip);
+
 	/* Enable overrun interrupt from codec channel */
 	ac97c_writel(chip, COMR, AC97C_CSR_OVRUN);
 	ac97c_writel(chip, IER, ac97c_readl(chip, IMR) | AC97C_SR_COEVT);
@@ -836,8 +838,6 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 		goto err_ac97_bus;
 	}
 
-	atmel_ac97c_reset(chip);
-
 	retval = atmel_ac97c_mixer_new(chip);
 	if (retval) {
 		dev_dbg(&pdev->dev, "could not register ac97 mixer\n");
-- 
1.5.6.3
