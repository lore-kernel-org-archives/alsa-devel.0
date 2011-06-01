From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Support edge triggered IRQs for WM8915
Date: Wed,  1 Jun 2011 14:46:39 +0100
Message-ID: <1306935999-15469-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E30E110386D
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 15:46:42 +0200 (CEST)
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

Really this should be something the IRQ core can cope with for us but since
it doesn't currently do so (at least for threaded interrupts like this) do
so in the driver. This allows us to run with interrupt controllers that
only support edge triggered interrupts.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8915.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8915.c b/sound/soc/codecs/wm8915.c
index a0b1a72..bb1ff2c 100644
--- a/sound/soc/codecs/wm8915.c
+++ b/sound/soc/codecs/wm8915.c
@@ -2382,6 +2382,20 @@ static irqreturn_t wm8915_irq(int irq, void *data)
 	}
 }
 
+static irqreturn_t wm8915_edge_irq(int irq, void *data)
+{
+	irqreturn_t ret = IRQ_NONE;
+	irqreturn_t val;
+
+	do {
+		val = wm8915_irq(irq, data);
+		if (val != IRQ_NONE)
+			ret = val;
+	} while (val != IRQ_NONE);
+
+	return ret;
+}
+
 static void wm8915_retune_mobile_pdata(struct snd_soc_codec *codec)
 {
 	struct wm8915_priv *wm8915 = snd_soc_codec_get_drvdata(codec);
@@ -2708,8 +2722,14 @@ static int wm8915_probe(struct snd_soc_codec *codec)
 
 		irq_flags |= IRQF_ONESHOT;
 
-		ret = request_threaded_irq(i2c->irq, NULL, wm8915_irq,
-					   irq_flags, "wm8915", codec);
+		if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
+			ret = request_threaded_irq(i2c->irq, NULL,
+						   wm8915_edge_irq,
+						   irq_flags, "wm8915", codec);
+		else
+			ret = request_threaded_irq(i2c->irq, NULL, wm8915_irq,
+						   irq_flags, "wm8915", codec);
+
 		if (ret == 0) {
 			/* Unmask the interrupt */
 			snd_soc_update_bits(codec, WM8915_INTERRUPT_CONTROL,
-- 
1.7.5.3
