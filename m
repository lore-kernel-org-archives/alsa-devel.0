From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 1/3] ASoC: TWL4030: Enable voice filters for
	voice sidetone
Date: Fri, 19 Jun 2009 03:23:41 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E3543F31C@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 8684A1038A6
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 10:23:49 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Digital voice loopback (sidetone) requires voice filters
to be enabled: VTXL, VTXR, VRX.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl4030.c |   67 +++++++++++++++++++++++++-------------------
 1 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 4dbb853..780217a 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -332,6 +332,28 @@ static void twl4030_power_down(struct snd_soc_codec *codec)
 	twl4030_codec_enable(codec, 0);
 }
 
+/* In case of voice mode, the RX1 L(VRX) for downlink and the TX2 L/R
+ * (VTXL, VTXR) for uplink has to be enabled/disabled. */
+static void twl4030_voice_enable(struct snd_soc_codec *codec, int direction,
+				int enable)
+{
+	u8 reg, mask;
+
+	reg = twl4030_read_reg_cache(codec, TWL4030_REG_OPTION);
+
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+		mask = TWL4030_ARXL1_VRX_EN;
+	else
+		mask = TWL4030_ATXL2_VTXL_EN | TWL4030_ATXR2_VTXR_EN;
+
+	if (enable)
+		reg |= mask;
+	else
+		reg &= ~mask;
+
+	twl4030_write(codec, TWL4030_REG_OPTION, reg);
+}
+
 /* Earpiece */
 static const struct snd_kcontrol_new twl4030_dapm_earpiece_controls[] = {
 	SOC_DAPM_SINGLE("Voice", TWL4030_REG_EAR_CTL, 0, 1, 0),
@@ -712,7 +734,22 @@ static int bypass_event(struct snd_soc_dapm_widget *w,
 
 	reg = twl4030_read_reg_cache(w->codec, m->reg);
 
-	if (m->reg <= TWL4030_REG_ARXR2_APGA_CTL) {
+	if (m->reg == TWL4030_REG_VSTPGA) {
+		/* Voice digital bypass */
+		if (reg) {
+			twl4030->bypass_state |= (1 << 5);
+			twl4030_voice_enable(w->codec,
+					SNDRV_PCM_STREAM_PLAYBACK, 1);
+			twl4030_voice_enable(w->codec,
+					SNDRV_PCM_STREAM_CAPTURE, 1);
+		} else {
+			twl4030->bypass_state &= ~(1 << 5);
+			twl4030_voice_enable(w->codec,
+					SNDRV_PCM_STREAM_PLAYBACK, 0);
+			twl4030_voice_enable(w->codec,
+					SNDRV_PCM_STREAM_CAPTURE, 0);
+		}
+	} else if (m->reg <= TWL4030_REG_ARXR2_APGA_CTL) {
 		/* Analog bypass */
 		if (reg & (1 << m->shift))
 			twl4030->bypass_state |=
@@ -726,12 +763,6 @@ static int bypass_event(struct snd_soc_dapm_widget *w,
 			twl4030->bypass_state |= (1 << 4);
 		else
 			twl4030->bypass_state &= ~(1 << 4);
-	} else if (m->reg == TWL4030_REG_VSTPGA) {
-		/* Voice digital bypass */
-		if (reg)
-			twl4030->bypass_state |= (1 << 5);
-		else
-			twl4030->bypass_state &= ~(1 << 5);
 	} else {
 		/* Digital bypass */
 		if (reg & (0x7 << m->shift))
@@ -1806,28 +1837,6 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-/* In case of voice mode, the RX1 L(VRX) for downlink and the TX2 L/R
- * (VTXL, VTXR) for uplink has to be enabled/disabled. */
-static void twl4030_voice_enable(struct snd_soc_codec *codec, int direction,
-				int enable)
-{
-	u8 reg, mask;
-
-	reg = twl4030_read_reg_cache(codec, TWL4030_REG_OPTION);
-
-	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-		mask = TWL4030_ARXL1_VRX_EN;
-	else
-		mask = TWL4030_ATXL2_VTXL_EN | TWL4030_ATXR2_VTXR_EN;
-
-	if (enable)
-		reg |= mask;
-	else
-		reg &= ~mask;
-
-	twl4030_write(codec, TWL4030_REG_OPTION, reg);
-}
-
 static int twl4030_voice_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-- 
1.5.4.3
