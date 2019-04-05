From: Fletcher Woodruff <fletcherw@chromium.org>
Subject: [PATCH v2 2/3] ASoC: rt5677: handle concurrent interrupts
Date: Fri,  5 Apr 2019 14:42:56 -0600
Message-ID: <20190405204257.87095-3-fletcherw@chromium.org>
References: <20190401205519.34023-2-fletcherw@chromium.org>
 <20190405204257.87095-1-fletcherw@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405204257.87095-1-fletcherw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ben Zhang <benzh@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, Ross Zwisler <zwisler@google.com>, alsa-devel@alsa-project.org, Fletcher Woodruff <fletcherw@chromium.org>
List-Id: alsa-devel@alsa-project.org

From: Ben Zhang <benzh@chromium.org>

The rt5677 driver writes to the IRQ control register within the IRQ
handler in order to flip the polarity of the interrupts that have been
signalled.  If an interrupt fires in the interval between the
regmap_read and the regmap_write, it will not trigger a new call to
rt5677_irq.

Add a bounded loop to rt5677_irq that keeps checking interrupts until
none are seen, so that any interrupts that are signalled in that
interval are correctly handled.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Fletcher Woodruff <fletcherw@chromium.org>
---
 sound/soc/codecs/rt5677.c | 84 +++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index ef50314ac61eb5..6bff0df53c6c6b 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5070,47 +5070,63 @@ static irqreturn_t rt5677_irq(int unused, void *data)
 {
 	struct i2c_client *i2c = data;
 	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
-	int ret = 0, i, reg_irq, virq;
+	int ret = 0, loop, i, reg_irq, virq;
 	bool irq_fired;
 
 	mutex_lock(&rt5677->irq_lock);
-	/* Read interrupt status */
-	ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
-	if (ret) {
-		dev_err(&i2c->dev,
-			"Failed to read IRQ status: %d\n",
-			ret);
-		goto exit;
-	}
 	/*
-	 * Clear the interrupt by flipping the polarity of the
-	 * interrupt source lines that just fired
+	 * Loop to handle interrupts until the last i2c read shows no pending
+	 * irqs. The interrupt line is shared by multiple interrupt sources.
+	 * After the regmap_read() below, a new interrupt source line may
+	 * become high before the regmap_write() finishes, so there isn't a
+	 * rising edge on the shared interrupt line for the new interrupt. Thus,
+	 * the loop is needed to avoid missing irqs.
+	 *
+	 * A safeguard of 20 loops is used to avoid hanging in the irq handler
+	 * if there is something wrong with the interrupt status update. The
+	 * interrupt sources here are audio jack plug/unplug events which
+	 * shouldn't happen at a high frequency for a long period of time.
+	 * Empirically, more than 3 loops have never been seen.
 	 */
-	irq_fired = false;
-	for (i = 0; i < RT5677_IRQ_NUM; i++) {
-		if (reg_irq & rt5677_irq_descs[i].status_mask) {
-			reg_irq ^= rt5677_irq_descs[i].polarity_mask;
-			irq_fired = true;
+	for (loop = 0; loop < 20; loop++) {
+		/* Read interrupt status */
+		ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
+		if (ret) {
+			dev_err(&i2c->dev,
+				"Failed to read IRQ status: %d\n",
+				ret);
+			goto exit;
+		}
+		/*
+		 * Clear the interrupt by flipping the polarity of the
+		 * interrupt source lines that just fired
+		 */
+		irq_fired = false;
+		for (i = 0; i < RT5677_IRQ_NUM; i++) {
+			if (reg_irq & rt5677_irq_descs[i].status_mask) {
+				reg_irq ^= rt5677_irq_descs[i].polarity_mask;
+				irq_fired = true;
+			}
+		}
+		if (!irq_fired)
+			goto exit;
+
+		ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
+		if (ret) {
+			dev_err(&i2c->dev,
+				"Failed to update IRQ status: %d\n",
+				ret);
+			goto exit;
 		}
-	}
-	if (!irq_fired)
-		goto exit;
-
-	ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
-	if (ret) {
-		dev_err(&i2c->dev,
-			"Failed to update IRQ status: %d\n",
-			ret);
-		goto exit;
-	}
 
-	/* Process interrupts */
-	for (i = 0; i < RT5677_IRQ_NUM; i++) {
-		if ((reg_irq & rt5677_irq_descs[i].enable_mask) &&
-		    (reg_irq & rt5677_irq_descs[i].status_mask)) {
-			virq = irq_find_mapping(rt5677->domain, i);
-			if (virq)
-				handle_nested_irq(virq);
+		/* Process interrupts */
+		for (i = 0; i < RT5677_IRQ_NUM; i++) {
+			if ((reg_irq & rt5677_irq_descs[i].enable_mask) &&
+			    (reg_irq & rt5677_irq_descs[i].status_mask)) {
+				virq = irq_find_mapping(rt5677->domain, i);
+				if (virq)
+					handle_nested_irq(virq);
+			}
 		}
 	}
 exit:
-- 
2.21.0.392.gf8f6787159e-goog
