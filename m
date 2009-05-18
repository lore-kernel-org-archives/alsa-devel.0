From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 1/3] ASoC: TWL4030: Enable/disable voice
	digital filters
Date: Sun, 17 May 2009 20:02:31 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F69E8123@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 39C1C1037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 03:02:42 +0200 (CEST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Enable TWL4030 VTXL/VTXR and VRX digital filters for uplink
and downlink paths, respectively.

This patch also corrects voice 8/16kHz mode selection bit
(SEL_16K) of CODEC_MODE register.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl4030.c |   37 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/twl4030.h |    2 +-
 2 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index eaf91ab..e4d683d 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1629,6 +1629,28 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
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
 static int twl4030_voice_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -1665,6 +1687,17 @@ static int twl4030_voice_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static void twl4030_voice_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	/* Enable voice digital filters */
+	twl4030_voice_enable(codec, substream->stream, 0);
+}
+
 static int twl4030_voice_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -1673,6 +1706,9 @@ static int twl4030_voice_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = socdev->card->codec;
 	u8 old_mode, mode;
 
+	/* Enable voice digital filters */
+	twl4030_voice_enable(codec, substream->stream, 1);
+
 	/* bit rate */
 	old_mode = twl4030_read_reg_cache(codec, TWL4030_REG_CODEC_MODE)
 		& ~(TWL4030_CODECPDZ);
@@ -1780,6 +1816,7 @@ static struct snd_soc_dai_ops twl4030_dai_ops = {
 
 static struct snd_soc_dai_ops twl4030_dai_voice_ops = {
 	.startup	= twl4030_voice_startup,
+	.shutdown	= twl4030_voice_shutdown,
 	.hw_params	= twl4030_voice_hw_params,
 	.set_sysclk	= twl4030_voice_set_dai_sysclk,
 	.set_fmt	= twl4030_voice_set_dai_fmt,
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index 3441115..9668bdf 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -110,7 +110,7 @@
 #define TWL4030_APLL_RATE_44100		0x90
 #define TWL4030_APLL_RATE_48000		0xA0
 #define TWL4030_APLL_RATE_96000		0xE0
-#define TWL4030_SEL_16K			0x04
+#define TWL4030_SEL_16K			0x08
 #define TWL4030_CODECPDZ		0x02
 #define TWL4030_OPT_MODE		0x01
 #define TWL4030_OPTION_1		(1 << 0)
-- 
1.5.4.3
