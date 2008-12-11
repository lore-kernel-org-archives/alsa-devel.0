From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCHv2] TWL4030: hands-free start-up sequence.
Date: Thu, 11 Dec 2008 23:28:10 +0800
Message-ID: <1229009290-8767-1-git-send-email-stanley.miao@windriver.com>
References: <20081211125347.GC30808@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 789B21037FB
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 16:21:30 +0100 (CET)
In-Reply-To: <20081211125347.GC30808@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

A special start-up sequence is required to reduce the pop-noise of Class D
amplifier when enable hands-free on TWL4030.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 sound/soc/codecs/twl4030.c |   34 ++++++++++++++++++++++++++++++----
 sound/soc/codecs/twl4030.h |    6 ++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 1377302..5184888 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -322,6 +322,30 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 	return ret;
 }
 
+static int handsfree_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct soc_enum *e = (struct soc_enum *)w->kcontrols->private_value;
+	unsigned char hs_ctl;
+
+	hs_ctl = twl4030_read_reg_cache(w->codec, e->reg);
+
+	if (hs_ctl & TWL4030_HF_CTL_REF_EN) {
+		hs_ctl |= TWL4030_HF_CTL_RAMP_EN;
+		twl4030_write(w->codec, e->reg, hs_ctl);
+		hs_ctl |= TWL4030_HF_CTL_LOOP_EN;
+		twl4030_write(w->codec, e->reg, hs_ctl);
+		hs_ctl |= TWL4030_HF_CTL_HB_EN;
+		twl4030_write(w->codec, e->reg, hs_ctl);
+	} else {
+		hs_ctl &= ~(TWL4030_HF_CTL_RAMP_EN | TWL4030_HF_CTL_LOOP_EN
+				| TWL4030_HF_CTL_HB_EN);
+		twl4030_write(w->codec, e->reg, hs_ctl);
+	}
+
+	return 0;
+}
+
 /*
  * Some of the gain controls in TWL (mostly those which are associated with
  * the outputs) are implemented in an interesting way:
@@ -806,10 +830,12 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("CarkitR Mux", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_carkitr_control),
 	/* HandsfreeL/R */
-	SND_SOC_DAPM_MUX("HandsfreeL Mux", TWL4030_REG_HFL_CTL, 5, 0,
-		&twl4030_dapm_handsfreel_control),
-	SND_SOC_DAPM_MUX("HandsfreeR Mux", TWL4030_REG_HFR_CTL, 5, 0,
-		&twl4030_dapm_handsfreer_control),
+	SND_SOC_DAPM_MUX_E("HandsfreeL Mux", TWL4030_REG_HFL_CTL, 5, 0,
+		&twl4030_dapm_handsfreel_control, handsfree_event,
+		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX_E("HandsfreeR Mux", TWL4030_REG_HFR_CTL, 5, 0,
+		&twl4030_dapm_handsfreer_control, handsfree_event,
+		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 
 	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index a2065d4..54615c7 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -191,6 +191,12 @@
 #define TWL4030_RAMP_DELAY_2581MS	0x1C
 #define TWL4030_RAMP_EN			0x02
 
+/* HFL_CTL (0x29, 0x2A) Fields */
+#define TWL4030_HF_CTL_HB_EN		0x04
+#define TWL4030_HF_CTL_LOOP_EN		0x08
+#define TWL4030_HF_CTL_RAMP_EN		0x10
+#define TWL4030_HF_CTL_REF_EN		0x20
+
 /* APLL_CTL (0x3A) Fields */
 
 #define TWL4030_APLL_EN			0x10
-- 
1.5.6.3
