From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: Add API to set supported jack type
Date: Tue, 5 Aug 2014 13:52:50 +0800
Message-ID: <1407217970-20126-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D510D261ABF
 for <alsa-devel@alsa-project.org>; Tue,  5 Aug 2014 07:53:24 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

RT286 need to configure the jack type (combo or non-combo) according to the
HW design. This function is given a easy way to set the correct jacy type
for those without platform data supported.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 33 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt286.h |  7 +++++++
 2 files changed, 40 insertions(+)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index e4f6102..dd6b454 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -414,6 +414,39 @@ int rt286_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 }
 EXPORT_SYMBOL_GPL(rt286_mic_detect);
 
+/**
+ * rt286_set_jack_type - Configure the HW supported jack type
+ *
+ * @codec:   RT286 codec
+ * @type:    supported jack type
+ *
+ * RT286 need to configure the jack type (combo or non-combo) according to the
+ * HW design. This function is given a easy way to set the correct jacy type
+ * for those without platform data supported.
+ */
+void rt286_set_jack_type(struct snd_soc_codec *codec,
+				enum rt286_jack_type type)
+{
+	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
+
+	if (RT286_TYPE_COMBO == type)
+		rt286->pdata.cbj_en = true;
+	else
+		rt286->pdata.cbj_en = false;
+
+	if (!rt286->pdata.cbj_en) {
+		regmap_write(rt286->regmap, RT286_CBJ_CTRL2, 0x0000);
+		regmap_write(rt286->regmap, RT286_MIC1_DET_CTRL, 0x0816);
+		regmap_write(rt286->regmap, RT286_MISC_CTRL1, 0x0000);
+		regmap_update_bits(rt286->regmap,
+					RT286_CBJ_CTRL1, 0xf000, 0xb000);
+	} else {
+		regmap_update_bits(rt286->regmap,
+					RT286_CBJ_CTRL1, 0xf000, 0x5000);
+	}
+}
+EXPORT_SYMBOL_GPL(rt286_set_jack_type);
+
 static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -6350, 50, 0);
 static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, 0, 1000, 0);
 
diff --git a/sound/soc/codecs/rt286.h b/sound/soc/codecs/rt286.h
index b539b73..2b1cbe6 100644
--- a/sound/soc/codecs/rt286.h
+++ b/sound/soc/codecs/rt286.h
@@ -192,7 +192,14 @@ enum {
 	RT286_AIFS,
 };
 
+enum rt286_jack_type {
+	RT286_TYPE_COMBO,
+	RT286_TYPE_NONCOMBO,
+};
+
 int rt286_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack);
+void rt286_set_jack_type(struct snd_soc_codec *codec,
+				enum rt286_jack_type type);
 
 #endif /* __RT286_H__ */
 
-- 
1.8.1.1.439.g50a6b54
