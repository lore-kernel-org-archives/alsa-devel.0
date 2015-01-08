From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 3/3] ASoC: rt5677: Add the specific TDM setting
	for Intel platform.
Date: Thu, 8 Jan 2015 10:31:07 +0800
Message-ID: <1420684267-19211-3-git-send-email-oder_chiou@realtek.com>
References: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C366C2606C9
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 03:31:24 +0100 (CET)
In-Reply-To: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, yang.a.fang@intel.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds the specific TDM setting for Intel platform in the platform
data. It enables the TDM1's capbility that can receive the 100FS data.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 include/sound/rt5677.h    | 3 +++
 sound/soc/codecs/rt5677.c | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/sound/rt5677.h b/include/sound/rt5677.h
index a620704..1137183 100644
--- a/include/sound/rt5677.h
+++ b/include/sound/rt5677.h
@@ -40,6 +40,9 @@ struct rt5677_platform_data {
 
 	/* Set MICBIAS1 VDD 1v8 or 3v3 */
 	bool micbias1_vdd_3v3;
+
+	/* Set TDM mode for Intel */
+	bool tdm_for_intel;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 32c368c..b1c17b0 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4427,7 +4427,7 @@ static int rt5677_probe(struct snd_soc_codec *codec)
 
 	rt5677_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	regmap_write(rt5677->regmap, RT5677_DIG_MISC, 0x0020);
+	regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC, 0x0020, 0x0020);
 	regmap_write(rt5677->regmap, RT5677_PWR_DSP2, 0x0c00);
 
 	for (i = 0; i < RT5677_GPIO_NUM; i++)
@@ -4928,6 +4928,10 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 			RT5677_MICBIAS1_CTRL_VDD_MASK,
 			RT5677_MICBIAS1_CTRL_VDD_3_3V);
 
+	if (rt5677->pdata.tdm_for_intel)
+		regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC, 0x8000,
+			0x8000);
+
 	rt5677_init_gpio(i2c);
 	rt5677_init_irq(i2c);
 
-- 
1.8.1.1.439.g50a6b54
