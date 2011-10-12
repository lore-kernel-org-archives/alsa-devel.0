From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] ASoC: twl6040: Workaround for headset DC
	offset caused pop noise
Date: Wed, 12 Oct 2011 14:46:02 +0300
Message-ID: <1318419962-1516-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
	[74.125.149.151])
	by alsa0.perex.cz (Postfix) with ESMTP id B9A63103815
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 15:37:12 +0200 (CEST)
Received: by mail-bw0-f48.google.com with SMTP id r19so55957bka.7
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2011 06:37:10 -0700 (PDT)
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

Both Headset DAC need to be turned on/off at the same time before
any of the output drivers are enabled (HS Left/Right, Earpiece).
Move the HS DAC enable code to sequenced DAPM_SUPPLY, and attach
it to the DACs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi Mark,

Changes since v1:
- Use DAPM_SUPPLY_S for the HS DAC enable code

Regards,
Peter

 include/linux/mfd/twl6040.h |    1 +
 sound/soc/codecs/twl6040.c  |   36 ++++++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index 87a4778..2463c261 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -122,6 +122,7 @@
 
 /* HSLCTL/R (0x10/0x11) fields */
 
+#define TWL6040_HSDACENA		(1 << 0)
 #define TWL6040_HSDACMODE		(1 << 1)
 #define TWL6040_HSDRVMODE		(1 << 3)
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 8648498..6369230 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -654,6 +654,26 @@ static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
 static int twl6040_hs_dac_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = w->codec;
+	u8 hslctl, hsrctl;
+
+	/*
+	 * Workaround for Headset DC offset caused pop noise:
+	 * Both HS DAC need to be turned on (before the HS driver) and off at
+	 * the same time.
+	 */
+	hslctl = twl6040_read_reg_cache(codec, TWL6040_REG_HSLCTL);
+	hsrctl = twl6040_read_reg_cache(codec, TWL6040_REG_HSRCTL);
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		hslctl |= TWL6040_HSDACENA;
+		hsrctl |= TWL6040_HSDACENA;
+	} else {
+		hslctl &= ~TWL6040_HSDACENA;
+		hsrctl &= ~TWL6040_HSDACENA;
+	}
+	twl6040_write(codec, TWL6040_REG_HSLCTL, hslctl);
+	twl6040_write(codec, TWL6040_REG_HSRCTL, hsrctl);
+
 	msleep(1);
 	return 0;
 }
@@ -1103,14 +1123,8 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			TWL6040_REG_DMICBCTL, 4, 0),
 
 	/* DACs */
-	SND_SOC_DAPM_DAC_E("HSDAC Left", "Headset Playback",
-			TWL6040_REG_HSLCTL, 0, 0,
-			twl6040_hs_dac_event,
-			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_DAC_E("HSDAC Right", "Headset Playback",
-			TWL6040_REG_HSRCTL, 0, 0,
-			twl6040_hs_dac_event,
-			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_DAC("HSDAC Left", "Headset Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("HSDAC Right", "Headset Playback", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC_E("HFDAC Left", "Handsfree Playback",
 			TWL6040_REG_HFLCTL, 0, 0,
 			twl6040_power_mode_event,
@@ -1175,6 +1189,9 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			    NULL, 0),
 	SND_SOC_DAPM_SUPPLY("Vibra Right Control", TWL6040_REG_VIBCTLR, 2, 0,
 			    NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("HSDAC Power", 1, SND_SOC_NOPM, 0, 0,
+			      twl6040_hs_dac_event,
+			      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 	/* Analog playback PGAs */
 	SND_SOC_DAPM_PGA("HF Left PGA",
@@ -1204,6 +1221,9 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"AFMAmpL", NULL, "AFML"},
 	{"AFMAmpR", NULL, "AFMR"},
 
+	{"HSDAC Left", NULL, "HSDAC Power"},
+	{"HSDAC Right", NULL, "HSDAC Power"},
+
 	{"Headset Left Playback", "HS DAC", "HSDAC Left"},
 	{"Headset Left Playback", "Line-In amp", "AFMAmpL"},
 
-- 
1.7.7
