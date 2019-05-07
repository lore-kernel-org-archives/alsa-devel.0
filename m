From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 3/3] ASoC: mediatek: mt6358: save PGA for mixer
	control
Date: Tue,  7 May 2019 18:12:20 +0800
Message-ID: <20190507101220.182466-4-tzungbi@google.com>
References: <20190507101220.182466-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-xc49.google.com (mail-yw1-xc49.google.com
 [IPv6:2607:f8b0:4864:20::c49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DD81F89727
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 12:13:05 +0200 (CEST)
Received: by mail-yw1-xc49.google.com with SMTP id q2so30502773ywd.9
 for <alsa-devel@alsa-project.org>; Tue, 07 May 2019 03:13:05 -0700 (PDT)
In-Reply-To: <20190507101220.182466-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, tiwai@suse.com
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

mt6358_amic_disable() resets PGA to 0.

Save the gain settings from mixer control and restore them when using
the microphone.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/mt6358.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
index 44edbda8afcc..50b3fc5457ea 100644
--- a/sound/soc/codecs/mt6358.c
+++ b/sound/soc/codecs/mt6358.c
@@ -450,6 +450,15 @@ static int mt6358_put_volsw(struct snd_kcontrol *kcontrol,
 		priv->ana_gain[AUDIO_ANALOG_VOLUME_HSOUTR] =
 			(reg >> RG_AUDHSGAIN_SFT) & RG_AUDHSGAIN_MASK;
 		break;
+	case MT6358_AUDENC_ANA_CON0:
+	case MT6358_AUDENC_ANA_CON1:
+		regmap_read(priv->regmap, MT6358_AUDENC_ANA_CON0, &reg);
+		priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP1] =
+			(reg >> RG_AUDPREAMPLGAIN_SFT) & RG_AUDPREAMPLGAIN_MASK;
+		regmap_read(priv->regmap, MT6358_AUDENC_ANA_CON1, &reg);
+		priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP2] =
+			(reg >> RG_AUDPREAMPRGAIN_SFT) & RG_AUDPREAMPRGAIN_MASK;
+		break;
 	}
 
 	return ret;
@@ -470,10 +479,10 @@ static const struct snd_kcontrol_new mt6358_snd_controls[] = {
 			   MT6358_ZCD_CON3, 0, 0x12, 1,
 			   snd_soc_get_volsw, mt6358_put_volsw, playback_tlv),
 	/* ul pga gain */
-	SOC_DOUBLE_R_TLV("PGA Volume",
-			 MT6358_AUDENC_ANA_CON0, MT6358_AUDENC_ANA_CON1,
-			 8, 4, 0,
-			 pga_tlv),
+	SOC_DOUBLE_R_EXT_TLV("PGA Volume",
+			     MT6358_AUDENC_ANA_CON0, MT6358_AUDENC_ANA_CON1,
+			     8, 4, 0,
+			     snd_soc_get_volsw, mt6358_put_volsw, pga_tlv),
 };
 
 /* MUX */
@@ -1750,6 +1759,21 @@ static void mt6358_dmic_disable(struct mt6358_priv *priv)
 	regmap_write(priv->regmap, MT6358_AUDENC_ANA_CON9, 0x0000);
 }
 
+static void mt6358_restore_pga(struct mt6358_priv *priv)
+{
+	unsigned int gain_l, gain_r;
+
+	gain_l = priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP1];
+	gain_r = priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP2];
+
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+			   RG_AUDPREAMPLGAIN_MASK_SFT,
+			   gain_l << RG_AUDPREAMPLGAIN_SFT);
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+			   RG_AUDPREAMPRGAIN_MASK_SFT,
+			   gain_r << RG_AUDPREAMPRGAIN_SFT);
+}
+
 static int mt_mic_type_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol,
 			     int event)
@@ -1774,6 +1798,7 @@ static int mt_mic_type_event(struct snd_soc_dapm_widget *w,
 			mt6358_amic_enable(priv);
 			break;
 		}
+		mt6358_restore_pga(priv);
 
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-- 
2.21.0.1020.gf2820cf01a-goog
