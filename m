From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: cs35l35: Add multi-device
	synchronisation
Date: Thu, 18 May 2017 16:32:39 +0100
Message-ID: <1495121559-1063-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1495121559-1063-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CC4C2671BE
 for <alsa-devel@alsa-project.org>; Thu, 18 May 2017 17:31:25 +0200 (CEST)
In-Reply-To: <1495121559-1063-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, brian.austin@cirrus.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds multi-device synchronisation capabilities to the
CS35L35 amp.

In stereo mode you can select to have the devices communicate
certain features to each other. Add options to allow the amps to
synchronise the audio group delay, the brown out protection and the
over temperature warning.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs35l35.c | 48 +++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/cs35l35.h |  9 +++++++++
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 375be49..a587269 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -310,11 +310,49 @@ static const struct snd_kcontrol_new cs35l35_aud_controls[] = {
 			amp_gain_tlv),
 };
 
-static const struct snd_kcontrol_new cs35l35_adv_controls[] = {
+static int cs35l35_put_sync(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val;
+	int ret;
+
+	snd_soc_dapm_mutex_lock(dapm);
+
+	ret = regmap_read(cs35l35->regmap, CS35L35_PWRCTL1, &val);
+	if (ret) {
+		dev_err(cs35l35->dev, "Failed to check power state: %d\n", ret);
+		goto err;
+	}
+
+	if (!(val & CS35L35_PDN_ALL)) {
+		dev_err(cs35l35->dev, "Can't change sync when active\n");
+		ret = -EBUSY;
+		goto err;
+	}
+
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+
+err:
+	snd_soc_dapm_mutex_unlock(dapm);
+
+	return ret;
+}
+
+static const struct snd_kcontrol_new cs35l35_stereo_controls[] = {
 	SOC_SINGLE_SX_TLV("Digital Advisory Volume", CS35L35_ADV_DIG_VOL,
 		      0, 0x34, 0xE4, dig_vol_tlv),
 	SOC_SINGLE_TLV("Analog Advisory Volume", CS35L35_AMP_GAIN_ADV_CTL, 0, 19, 0,
 			amp_gain_tlv),
+
+	SOC_SINGLE_EXT("SYNC Audio", CS35L35_MULT_DEV_SYNCH2, 1, 1, 0,
+		       snd_soc_get_volsw, cs35l35_put_sync),
+	SOC_SINGLE_EXT("SYNC VPBR", CS35L35_MULT_DEV_SYNCH2, 2, 1, 0,
+		       snd_soc_get_volsw, cs35l35_put_sync),
+	SOC_SINGLE_EXT("SYNC OTW", CS35L35_MULT_DEV_SYNCH2, 3, 1, 0,
+		       snd_soc_get_volsw, cs35l35_put_sync),
 };
 
 static const struct snd_soc_dapm_widget cs35l35_dapm_widgets[] = {
@@ -872,8 +910,12 @@ static int cs35l35_codec_probe(struct snd_soc_codec *codec)
 			regmap_update_bits(cs35l35->regmap, CS35L35_CLASS_H_CTL,
 					CS35L35_CH_STEREO_MASK,
 					1 << CS35L35_CH_STEREO_SHIFT);
-		ret = snd_soc_add_codec_controls(codec, cs35l35_adv_controls,
-					ARRAY_SIZE(cs35l35_adv_controls));
+
+		regmap_update_bits(cs35l35->regmap, CS35L35_MULT_DEV_SYNCH2,
+				   CS35L35_SYNC_EN_MASK, 1);
+
+		ret = snd_soc_add_codec_controls(codec, cs35l35_stereo_controls,
+					ARRAY_SIZE(cs35l35_stereo_controls));
 		if (ret)
 			return ret;
 	}
diff --git a/sound/soc/codecs/cs35l35.h b/sound/soc/codecs/cs35l35.h
index 621bfef..7cec198 100644
--- a/sound/soc/codecs/cs35l35.h
+++ b/sound/soc/codecs/cs35l35.h
@@ -273,6 +273,15 @@
 #define CS35L35_VMON_OVFL		0x08
 #define CS35L35_IMON_OVFL		0x04
 
+/* Mulit-Device Sync */
+#define CS35L35_SYNC_EN_MASK		0x01
+#define CS35L35_SYNC_MS_MASK		0x20
+#define CS35L35_SYNC_MS_SHIFT		5
+#define CS35L35_SYNC_MS_CTRL_MASK	0x10
+#define CS35L35_SYNC_MS_CTRL_SHIFT	4
+#define CS35L35_SYNC_CLK_SEL_MASK	0x02
+#define CS35L35_SYNC_CLK_SEL_SHIFT	1
+
 #define CS35L35_FORMATS (SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-- 
2.1.4
