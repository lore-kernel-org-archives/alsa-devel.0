From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl6040: Workaround for headset DC
	offset caused pop noise
Date: Tue, 11 Oct 2011 14:00:13 +0300
Message-ID: <1318330813-31184-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id BCE05243AA
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 13:00:37 +0200 (CEST)
Received: by eyd10 with SMTP id 10so3199764eyd.27
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2011 04:00:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Both Headset DAC need to be enabled at the same time, before any of
the output drivers are enabled.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 include/linux/mfd/twl6040.h |    1 +
 sound/soc/codecs/twl6040.c  |   42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index d9e05ea..0bbb1e7 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -122,6 +122,7 @@
 
 /* HSLCTL/R (0x10/0x11) fields */
 
+#define TWL6040_HSDACENA		(1 << 0)
 #define TWL6040_HSDACMODE		(1 << 1)
 #define TWL6040_HSDRVMODE		(1 << 3)
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 93f8a59..924eaf3 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -91,6 +91,7 @@ struct twl6040_data {
 	int pll_power_mode;
 	int hs_power_mode;
 	int hs_power_mode_locked;
+	int hs_dac_enabled;
 	unsigned int clk_in;
 	unsigned int sysclk;
 	u16 hs_left_step;
@@ -654,6 +655,43 @@ static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
 static int twl6040_hs_dac_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = w->codec;
+	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	u8 hslctl, hsrctl;
+
+	/*
+	 * Workaround for Headset DC offset caused pop noise:
+	 * Both HS DAC need to be turned on (before the HS driver) and off at
+	 * the same time.
+	 */
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		if (!priv->hs_dac_enabled++) {
+			hslctl = twl6040_read_reg_cache(codec,
+							TWL6040_REG_HSLCTL);
+			hslctl |= TWL6040_HSDACENA;
+
+			hsrctl = twl6040_read_reg_cache(codec,
+							TWL6040_REG_HSRCTL);
+			hsrctl |= TWL6040_HSDACENA;
+
+			twl6040_write(codec, TWL6040_REG_HSLCTL, hslctl);
+			twl6040_write(codec, TWL6040_REG_HSRCTL, hsrctl);
+		}
+	} else {
+		if (!--priv->hs_dac_enabled) {
+			hslctl = twl6040_read_reg_cache(codec,
+							TWL6040_REG_HSLCTL);
+			hslctl &= ~TWL6040_HSDACENA;
+
+			hsrctl = twl6040_read_reg_cache(codec,
+							TWL6040_REG_HSRCTL);
+			hsrctl &= ~TWL6040_HSDACENA;
+
+			twl6040_write(codec, TWL6040_REG_HSLCTL, hslctl);
+			twl6040_write(codec, TWL6040_REG_HSRCTL, hsrctl);
+		}
+	}
+
 	msleep(1);
 	return 0;
 }
@@ -1061,11 +1099,11 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 
 	/* DACs */
 	SND_SOC_DAPM_DAC_E("HSDAC Left", "Headset Playback",
-			TWL6040_REG_HSLCTL, 0, 0,
+			SND_SOC_NOPM, 0, 0,
 			twl6040_hs_dac_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_DAC_E("HSDAC Right", "Headset Playback",
-			TWL6040_REG_HSRCTL, 0, 0,
+			SND_SOC_NOPM, 0, 0,
 			twl6040_hs_dac_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_DAC_E("HFDAC Left", "Handsfree Playback",
-- 
1.7.7
