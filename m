From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: wm8962: Fix null pointer pdata access in
	I2C probe()
Date: Tue, 29 Oct 2013 17:06:27 +0800
Message-ID: <1383037587-19439-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E63222610A9
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 10:06:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

When using DT binding to pass private data, there would be Kernel panic
occuring due to NULL pointer access in wm8962_i2c_probe(). Thus fix it.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/codecs/wm8962.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 2bf9ee7..7dd79c4 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3616,28 +3616,28 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 			   0);
 
 	/* Apply static configuration for GPIOs */
-	for (i = 0; i < ARRAY_SIZE(pdata->gpio_init); i++)
-		if (pdata->gpio_init[i]) {
+	for (i = 0; i < ARRAY_SIZE(wm8962->pdata.gpio_init); i++)
+		if (wm8962->pdata.gpio_init[i]) {
 			wm8962_set_gpio_mode(wm8962, i + 1);
 			regmap_write(wm8962->regmap, 0x200 + i,
-				     pdata->gpio_init[i] & 0xffff);
+				     wm8962->pdata.gpio_init[i] & 0xffff);
 		}
 
 
 	/* Put the speakers into mono mode? */
-	if (pdata->spk_mono)
+	if (wm8962->pdata.spk_mono)
 		regmap_update_bits(wm8962->regmap, WM8962_CLASS_D_CONTROL_2,
 				   WM8962_SPK_MONO_MASK, WM8962_SPK_MONO);
 
 	/* Micbias setup, detection enable and detection
 	 * threasholds. */
-	if (pdata->mic_cfg)
+	if (wm8962->pdata.mic_cfg)
 		regmap_update_bits(wm8962->regmap, WM8962_ADDITIONAL_CONTROL_4,
 				   WM8962_MICDET_ENA |
 				   WM8962_MICDET_THR_MASK |
 				   WM8962_MICSHORT_THR_MASK |
 				   WM8962_MICBIAS_LVL,
-				   pdata->mic_cfg);
+				   wm8962->pdata.mic_cfg);
 
 	/* Latch volume update bits */
 	regmap_update_bits(wm8962->regmap, WM8962_LEFT_INPUT_VOLUME,
@@ -3682,7 +3682,7 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 	}
 
 	if (wm8962->irq) {
-		if (pdata->irq_active_low) {
+		if (wm8962->pdata.irq_active_low) {
 			trigger = IRQF_TRIGGER_LOW;
 			irq_pol = WM8962_IRQ_POL;
 		} else {
-- 
1.8.4
