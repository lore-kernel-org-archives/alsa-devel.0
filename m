From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ASoC: rt5645: rename jd_invert flag in
	platform data
Date: Wed, 28 Jun 2017 14:49:37 +0200
Message-ID: <20170628124939.11696-3-tiwai@suse.de>
References: <20170628124939.11696-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C8E0266B9F
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 14:49:41 +0200 (CEST)
In-Reply-To: <20170628124939.11696-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

The jd_invert flag is actually used for level triggered IRQ. Rename
it to let code more readable.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/rt5645.h    | 4 ++--
 sound/soc/codecs/rt5645.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index a5cf6152e778..c427f10a39ae 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -21,8 +21,8 @@ struct rt5645_platform_data {
 	/* 0 = IN2P; 1 = GPIO6; 2 = GPIO10; 3 = GPIO12 */
 
 	unsigned int jd_mode;
-	/* Invert JD when jack insert */
-	bool jd_invert;
+	/* Use level triggered irq */
+	bool level_trigger_irq;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 8e419ea418e9..e0c09bbd3f12 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3151,7 +3151,7 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
 		}
-		if (rt5645->pdata.jd_invert)
+		if (rt5645->pdata.level_trigger_irq)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 				RT5645_JD_1_1_MASK, RT5645_JD_1_1_NOR);
 	} else { /* jack out */
@@ -3172,7 +3172,7 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			snd_soc_dapm_disable_pin(dapm, "LDO2");
 		snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 		snd_soc_dapm_sync(dapm);
-		if (rt5645->pdata.jd_invert)
+		if (rt5645->pdata.level_trigger_irq)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
 	}
@@ -3586,7 +3586,7 @@ static struct rt5645_platform_data buddy_platform_data = {
 	.dmic1_data_pin = RT5645_DMIC_DATA_GPIO5,
 	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
 	.jd_mode = 3,
-	.jd_invert = true,
+	.level_trigger_irq = true,
 };
 
 static struct dmi_system_id dmi_platform_intel_broadwell[] = {
@@ -3838,7 +3838,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt5645->regmap, RT5645_ADDA_CLK1,
 		RT5645_I2S_PD1_MASK, RT5645_I2S_PD1_2);
 
-	if (rt5645->pdata.jd_invert) {
+	if (rt5645->pdata.level_trigger_irq) {
 		regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 			RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
 	}
-- 
2.13.2
