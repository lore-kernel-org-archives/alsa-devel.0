From: John Lin <john.lin@realtek.com>
Subject: [PATCH v3 2/2] ASoC: rt5645: Add jd_invert for
	Broadwell
Date: Mon, 21 Sep 2015 14:12:01 +0800
Message-ID: <1442815921-19061-2-git-send-email-john.lin@realtek.com>
References: <1442815921-19061-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FE7F260537
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 08:12:16 +0200 (CEST)
In-Reply-To: <1442815921-19061-1-git-send-email-john.lin@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, John Lin <john.lin@realtek.com>, benzh@chromium.org, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Broadwell can not triger the IRQ falling and rising simultaneously,
so it can not detect jack-in and jack-out simultaneously.
We add a flag "jd_invert" to platform data. If this flag is set,
codec IRQ will be set to invert that forces IRQ as pulse when jack-in
and jack-out.

Signed-off-by: John Lin <john.lin@realtek.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 include/sound/rt5645.h    | 2 ++
 sound/soc/codecs/rt5645.c | 7 +++++++
 sound/soc/codecs/rt5645.h | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index 22734bc..a5cf615 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -21,6 +21,8 @@ struct rt5645_platform_data {
 	/* 0 = IN2P; 1 = GPIO6; 2 = GPIO10; 3 = GPIO12 */
 
 	unsigned int jd_mode;
+	/* Invert JD when jack insert */
+	bool jd_invert;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e830688..b0d96b6 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2829,6 +2829,9 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
 		}
+		if (rt5645->pdata.jd_invert)
+			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
+				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
 	} else { /* jack out */
 		rt5645->jack_type = 0;
 
@@ -2844,6 +2847,9 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			snd_soc_dapm_disable_pin(dapm, "LDO2");
 		snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 		snd_soc_dapm_sync(dapm);
+		if (rt5645->pdata.jd_invert)
+			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
+				RT5645_JD_1_1_MASK, RT5645_JD_1_1_NOR);
 	}
 
 	return rt5645->jack_type;
@@ -3213,6 +3219,7 @@ static struct rt5645_platform_data buddy_platform_data = {
 	.dmic1_data_pin = RT5645_DMIC_DATA_GPIO5,
 	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
 	.jd_mode = 3,
+	.jd_invert = true,
 };
 
 static int buddy_quirk_cb(const struct dmi_system_id *id)
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 0e4cfc6..90325d9 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -1626,6 +1626,10 @@
 #define RT5645_OT_P_NOR				(0x0 << 10)
 #define RT5645_OT_P_INV				(0x1 << 10)
 #define RT5645_IRQ_JD_1_1_EN			(0x1 << 9)
+#define RT5645_JD_1_1_MASK			(0x1 << 7)
+#define RT5645_JD_1_1_SFT			7
+#define RT5645_JD_1_1_NOR			(0x0 << 7)
+#define RT5645_JD_1_1_INV			(0x1 << 7)
 
 /* IRQ Control 2 (0xbe) */
 #define RT5645_IRQ_MB1_OC_MASK			(0x1 << 15)
-- 
1.8.1.1.439.g50a6b54
