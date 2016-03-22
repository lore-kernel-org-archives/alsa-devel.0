From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: fix interrupt fails and
	unstable after resume
Date: Tue, 22 Mar 2016 11:57:28 +0800
Message-ID: <1458619048-28405-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 87F992656FD
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 04:57:13 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Modify power management function to sync behavior with set bias function.
And codec needs to config interrupt setting again to recover interrupt.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 70 ++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 106c391..b8af46b 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1204,6 +1204,42 @@ static int nau8825_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 	return nau8825_configure_sysclk(nau8825, clk_id, freq);
 }
 
+static void nau8825_configure_interrupt(struct nau8825 *nau8825)
+{
+	struct regmap *regmap = nau8825->regmap;
+
+	/* IRQ Output Enable */
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
+		NAU8825_IRQ_OUTPUT_EN, NAU8825_IRQ_OUTPUT_EN);
+
+	/* Enable internal VCO needed for interruptions */
+	nau8825_configure_sysclk(nau8825, NAU8825_CLK_INTERNAL, 0);
+
+	/* Enable ADC needed for interrupts
+	 * It is the same as force_enable_pin("ADC") we do later
+	 */
+	regmap_update_bits(regmap, NAU8825_REG_ENA_CTRL,
+		NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
+
+	/* Chip needs one FSCLK cycle in order to generate interrupts,
+	 * as we cannot guarantee one will be provided by the system. Turning
+	 * master mode on then off enables us to generate that FSCLK cycle
+	 * with a minimum of contention on the clock bus.
+	 */
+	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_MASTER);
+	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_SLAVE);
+}
+
+static void nau8825_resume_setup(struct nau8825 *nau8825)
+{
+	struct regmap *regmap = nau8825->regmap;
+
+	nau8825_configure_interrupt(nau8825);
+	nau8825_restart_jack_detection(regmap);
+}
+
 static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 				   enum snd_soc_bias_level level)
 {
@@ -1233,6 +1269,8 @@ static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 					"Failed to sync cache: %d\n", ret);
 				return ret;
 			}
+			if (nau8825->irq)
+				nau8825_resume_setup(nau8825);
 		}
 
 		break;
@@ -1346,29 +1384,9 @@ static int nau8825_read_device_properties(struct device *dev,
 
 static int nau8825_setup_irq(struct nau8825 *nau8825)
 {
-	struct regmap *regmap = nau8825->regmap;
 	int ret;
 
-	/* IRQ Output Enable */
-	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
-		NAU8825_IRQ_OUTPUT_EN, NAU8825_IRQ_OUTPUT_EN);
-
-	/* Enable internal VCO needed for interruptions */
-	nau8825_configure_sysclk(nau8825, NAU8825_CLK_INTERNAL, 0);
-
-	/* Enable ADC needed for interrupts */
-	regmap_update_bits(regmap, NAU8825_REG_ENA_CTRL,
-		NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
-
-	/* Chip needs one FSCLK cycle in order to generate interrupts,
-	 * as we cannot guarantee one will be provided by the system. Turning
-	 * master mode on then off enables us to generate that FSCLK cycle
-	 * with a minimum of contention on the clock bus.
-	 */
-	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
-		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_MASTER);
-	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
-		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_SLAVE);
+	nau8825_configure_interrupt(nau8825);
 
 	ret = devm_request_threaded_irq(nau8825->dev, nau8825->irq, NULL,
 		nau8825_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -1440,24 +1458,22 @@ static int nau8825_i2c_remove(struct i2c_client *client)
 #ifdef CONFIG_PM_SLEEP
 static int nau8825_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct nau8825 *nau8825 = dev_get_drvdata(dev);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(nau8825->dapm);
 
-	disable_irq(client->irq);
+	disable_irq(nau8825->irq);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 	regcache_cache_only(nau8825->regmap, true);
-	regcache_mark_dirty(nau8825->regmap);
 
 	return 0;
 }
 
 static int nau8825_resume(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct nau8825 *nau8825 = dev_get_drvdata(dev);
 
 	regcache_cache_only(nau8825->regmap, false);
-	regcache_sync(nau8825->regmap);
-	enable_irq(client->irq);
+	enable_irq(nau8825->irq);
 
 	return 0;
 }
-- 
2.6.4
