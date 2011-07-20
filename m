From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Acknowledge WM8962 interrupts before
	acting on them
Date: Wed, 20 Jul 2011 13:50:39 +0100
Message-ID: <1311166239-16544-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1311166239-16544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E4EF824419
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 14:50:44 +0200 (CEST)
In-Reply-To: <1311166239-16544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This closes the small race between a status being read in response to an
interrupt and clearing the interrupt, meaning that if the status changes
between those periods we might not get a reassertion of the interrupt.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 2593cc3..a381104 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3416,6 +3416,9 @@ static irqreturn_t wm8962_irq(int irq, void *data)
 	active = snd_soc_read(codec, WM8962_INTERRUPT_STATUS_2);
 	active &= ~mask;
 
+	/* Acknowledge the interrupts */
+	snd_soc_write(codec, WM8962_INTERRUPT_STATUS_2, active);
+
 	if (active & WM8962_FLL_LOCK_EINT) {
 		dev_dbg(codec->dev, "FLL locked\n");
 		complete(&wm8962->fll_lock);
@@ -3440,9 +3443,6 @@ static irqreturn_t wm8962_irq(int irq, void *data)
 				      msecs_to_jiffies(250));
 	}
 
-	/* Acknowledge the interrupts */
-	snd_soc_write(codec, WM8962_INTERRUPT_STATUS_2, active);
-
 	return IRQ_HANDLED;
 }
 
-- 
1.7.5.4
