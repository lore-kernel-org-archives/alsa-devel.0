From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: wm8903: disable IRQs during BIAS_OFF
Date: Mon,  9 Sep 2013 12:44:49 -0600
Message-ID: <1378752289-6301-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B8D352651A3
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 20:44:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

If the WM8903 IRQ is triggered after the device is suspended, or before
it is resumed, the underlying I2C bus that the WM8903 is attached to may
not be available. This may cause the IRQ handler to emit the following
error:

    wm8903 0-001a: Failed to read IRQ status: -16

... or perhaps even cause a failure inside the I2C driver.

To prevent this, explicitly mask all interrupt sources when entering
BIAS_OFF. Also, modify the IRQ handler to immediately return if the
device is in BIAS_OFF, so that shared interrupt lines don't cause a
similar problem. This requires that WM8903 interrupts be disabled to
avoid interrupt storms.

During resume (actually, the transition back to BIAS_STANDBY), restore
the desired IRQ mask.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/codecs/wm8903.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index eebcb1d..e847bbe 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1091,6 +1091,22 @@ static const struct snd_soc_dapm_route wm8903_intercon[] = {
 	{ "Right Line Output PGA", NULL, "Charge Pump" },
 };
 
+static void wm8903_setup_mic_det_irqs(struct snd_soc_codec *codec)
+{
+	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
+	int irq_mask = WM8903_MICDET_EINT | WM8903_MICSHRT_EINT;
+
+	/* Enable interrupts we've got a report configured for */
+	if (wm8903->mic_det)
+		irq_mask &= ~WM8903_MICDET_EINT;
+	if (wm8903->mic_short)
+		irq_mask &= ~WM8903_MICSHRT_EINT;
+
+	snd_soc_update_bits(codec, WM8903_INTERRUPT_STATUS_1_MASK,
+			    WM8903_MICDET_EINT | WM8903_MICSHRT_EINT,
+			    irq_mask);
+}
+
 static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
@@ -1169,6 +1185,8 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 					    WM8903_CP_DYN_V,
 					    WM8903_CP_DYN_FREQ |
 					    WM8903_CP_DYN_V);
+
+			wm8903_setup_mic_det_irqs(codec);
 		}
 
 		snd_soc_update_bits(codec, WM8903_VMID_CONTROL_0,
@@ -1177,6 +1195,8 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
+		snd_soc_write(codec, WM8903_INTERRUPT_STATUS_1_MASK, 0xffff);
+
 		snd_soc_update_bits(codec, WM8903_BIAS_CONTROL_0,
 				    WM8903_BIAS_ENA, 0);
 
@@ -1600,7 +1620,6 @@ int wm8903_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		      int det, int shrt)
 {
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-	int irq_mask = WM8903_MICDET_EINT | WM8903_MICSHRT_EINT;
 
 	dev_dbg(codec->dev, "Enabling microphone detection: %x %x\n",
 		det, shrt);
@@ -1610,15 +1629,7 @@ int wm8903_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 	wm8903->mic_det = det;
 	wm8903->mic_short = shrt;
 
-	/* Enable interrupts we've got a report configured for */
-	if (det)
-		irq_mask &= ~WM8903_MICDET_EINT;
-	if (shrt)
-		irq_mask &= ~WM8903_MICSHRT_EINT;
-
-	snd_soc_update_bits(codec, WM8903_INTERRUPT_STATUS_1_MASK,
-			    WM8903_MICDET_EINT | WM8903_MICSHRT_EINT,
-			    irq_mask);
+	wm8903_setup_mic_det_irqs(codec);
 
 	if (det || shrt) {
 		/* Enable mic detection, this may not have been set through
@@ -1642,6 +1653,13 @@ static irqreturn_t wm8903_irq(int irq, void *data)
 	int mic_report, ret;
 	unsigned int int_val, mask, int_pol;
 
+	/*
+	 * During suspend, a shared IRQ may be triggered by some other device.
+	 * If so, just ignore it; WM8903 shouldn't be generating interrupts.
+	 */
+	if (wm8903->codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+		return IRQ_NONE;
+
 	ret = regmap_read(wm8903->regmap, WM8903_INTERRUPT_STATUS_1_MASK,
 			  &mask);
 	if (ret != 0) {
-- 
1.8.1.5
