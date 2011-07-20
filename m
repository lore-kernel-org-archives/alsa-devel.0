From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Acknowledge WM8996 interrupts before
	acting on them
Date: Wed, 20 Jul 2011 13:50:38 +0100
Message-ID: <1311166239-16544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E344524417
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 14:50:44 +0200 (CEST)
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
 sound/soc/codecs/wm8996.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 00f9ace..ab8e9d1 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2404,6 +2404,8 @@ static irqreturn_t wm8996_irq(int irq, void *data)
 	}
 	irq_val &= ~snd_soc_read(codec, WM8996_INTERRUPT_STATUS_2_MASK);
 
+	snd_soc_write(codec, WM8996_INTERRUPT_STATUS_2, irq_val);
+
 	if (irq_val & (WM8996_DCS_DONE_01_EINT | WM8996_DCS_DONE_23_EINT)) {
 		dev_dbg(codec->dev, "DC servo IRQ\n");
 		complete(&wm8996->dcs_done);
@@ -2420,13 +2422,10 @@ static irqreturn_t wm8996_irq(int irq, void *data)
 	if (irq_val & WM8996_MICD_EINT)
 		wm8996_micd(codec);
 
-	if (irq_val) {
-		snd_soc_write(codec, WM8996_INTERRUPT_STATUS_2, irq_val);
-
+	if (irq_val)
 		return IRQ_HANDLED;
-	} else {
+	else
 		return IRQ_NONE;
-	}
 }
 
 static irqreturn_t wm8996_edge_irq(int irq, void *data)
-- 
1.7.5.4
