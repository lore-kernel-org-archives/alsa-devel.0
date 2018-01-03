From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/2] ASoC: rt5645: add micbias power control
	select.
Date: Wed,  3 Jan 2018 13:39:02 +0100
Message-ID: <20180103123902.17287-2-hdegoede@redhat.com>
References: <20180103123902.17287-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A84A2668F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 13:39:08 +0100 (CET)
In-Reply-To: <20180103123902.17287-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

We need to set a corresponding control bit before powering micbias up.

Signed-off-by: Bard Liao <bardliao@realtek.com>
[hdegoede@redhat.com: Remove 2 unused variable declarations]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5645.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/rt5645.h |  6 +++++
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index fdab5bf56c61..33546bc356c7 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1943,6 +1943,56 @@ static int rt5650_hp_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5645_set_micbias1_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL2,
+			RT5645_MICBIAS1_POW_CTRL_SEL_MASK,
+			RT5645_MICBIAS1_POW_CTRL_SEL_M);
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL2,
+			RT5645_MICBIAS1_POW_CTRL_SEL_MASK,
+			RT5645_MICBIAS1_POW_CTRL_SEL_A);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5645_set_micbias2_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL2,
+			RT5645_MICBIAS2_POW_CTRL_SEL_MASK,
+			RT5645_MICBIAS2_POW_CTRL_SEL_M);
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL2,
+			RT5645_MICBIAS2_POW_CTRL_SEL_MASK,
+			RT5645_MICBIAS2_POW_CTRL_SEL_A);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("LDO2", RT5645_PWR_MIXER,
 		RT5645_PWR_LDO2_BIT, 0, NULL, 0),
@@ -1981,9 +2031,11 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	/* Input Side */
 	/* micbias */
 	SND_SOC_DAPM_SUPPLY("micbias1", RT5645_PWR_ANLG2,
-			RT5645_PWR_MB1_BIT, 0, NULL, 0),
+			RT5645_PWR_MB1_BIT, 0, rt5645_set_micbias1_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_SUPPLY("micbias2", RT5645_PWR_ANLG2,
-			RT5645_PWR_MB2_BIT, 0, NULL, 0),
+			RT5645_PWR_MB2_BIT, 0, rt5645_set_micbias2_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("DMIC L1"),
 	SND_SOC_DAPM_INPUT("DMIC R1"),
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index cfc5f97549eb..940325b28c29 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2117,6 +2117,12 @@ enum {
 #define RT5645_RXDC_SRC_STO			(0x0 << 7)
 #define RT5645_RXDC_SRC_MONO			(0x1 << 7)
 #define RT5645_RXDC_SRC_SFT			(7)
+#define RT5645_MICBIAS1_POW_CTRL_SEL_MASK	(0x1 << 5)
+#define RT5645_MICBIAS1_POW_CTRL_SEL_A		(0x0 << 5)
+#define RT5645_MICBIAS1_POW_CTRL_SEL_M		(0x1 << 5)
+#define RT5645_MICBIAS2_POW_CTRL_SEL_MASK	(0x1 << 4)
+#define RT5645_MICBIAS2_POW_CTRL_SEL_A		(0x0 << 4)
+#define RT5645_MICBIAS2_POW_CTRL_SEL_M		(0x1 << 4)
 #define RT5645_RXDP2_SEL_MASK			(0x1 << 3)
 #define RT5645_RXDP2_SEL_IF2			(0x0 << 3)
 #define RT5645_RXDP2_SEL_ADC			(0x1 << 3)
-- 
2.14.3
