From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH] ASoC: TWL4030: Add tristate callbacks for HiFi
	and Voice
Date: Thu, 2 Jul 2009 22:11:40 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E39685527@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 02E7724700
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 05:11:52 +0200 (CEST)
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

Add "set_tristate" callbacks for HiFi and Voice DAIs.
Machine drivers can enable and disable tristate for each
DAI with "snd_soc_dai_set_tristate" function provided by
SoC core.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl4030.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 6da94ca..ffeb53f 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1849,6 +1849,19 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int twl4030_set_tristate(struct snd_soc_dai *dai, int tristate)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 reg = twl4030_read_reg_cache(codec, TWL4030_REG_VOICE_IF);
+
+	if (tristate)
+		reg |= TWL4030_AIF_TRI_EN;
+	else
+		reg &= ~TWL4030_AIF_TRI_EN;
+
+	return twl4030_write(codec, TWL4030_REG_AUDIO_IF, reg);
+}
+
 /* In case of voice mode, the RX1 L(VRX) for downlink and the TX2 L/R
  * (VTXL, VTXR) for uplink has to be enabled/disabled. */
 static void twl4030_voice_enable(struct snd_soc_codec *codec, int direction,
@@ -2023,6 +2036,19 @@ static int twl4030_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int twl4030_voice_set_tristate(struct snd_soc_dai *dai, int tristate)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 reg = twl4030_read_reg_cache(codec, TWL4030_REG_VOICE_IF);
+
+	if (tristate)
+		reg |= TWL4030_VIF_TRI_EN;
+	else
+		reg &= ~TWL4030_VIF_TRI_EN;
+
+	return twl4030_write(codec, TWL4030_REG_VOICE_IF, reg);
+}
+
 #define TWL4030_RATES	 (SNDRV_PCM_RATE_8000_48000)
 #define TWL4030_FORMATS	 (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_S24_LE)
 
@@ -2032,6 +2058,7 @@ static struct snd_soc_dai_ops twl4030_dai_ops = {
 	.hw_params	= twl4030_hw_params,
 	.set_sysclk	= twl4030_set_dai_sysclk,
 	.set_fmt	= twl4030_set_dai_fmt,
+	.set_tristate	= twl4030_set_tristate,
 };
 
 static struct snd_soc_dai_ops twl4030_dai_voice_ops = {
@@ -2040,6 +2067,7 @@ static struct snd_soc_dai_ops twl4030_dai_voice_ops = {
 	.hw_params	= twl4030_voice_hw_params,
 	.set_sysclk	= twl4030_voice_set_dai_sysclk,
 	.set_fmt	= twl4030_voice_set_dai_fmt,
+	.set_tristate	= twl4030_voice_set_tristate,
 };
 
 struct snd_soc_dai twl4030_dai[] = {
-- 
1.5.4.3
