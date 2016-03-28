From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: cs47l24: Add support for audio trace
	firmware
Date: Mon, 28 Mar 2016 14:29:24 +0100
Message-ID: <1459171764-29921-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1459171764-29921-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F3A52670C5
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 15:29:19 +0200 (CEST)
In-Reply-To: <1459171764-29921-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

cs47l24 supports the audio trace firmware, this streams of audio to be
captured from the CODEC over a compressed audio channel for
analysis/debugging of audio processing firmwares.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs47l24.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 383700a..6b8b557 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -807,6 +807,9 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 	{ "IN2L PGA", NULL, "IN2L" },
 	{ "IN2R PGA", NULL, "IN2R" },
 
+	{ "Audio Trace DSP", NULL, "DSP2" },
+	{ "Audio Trace DSP", NULL, "SYSCLK" },
+
 	ARIZONA_MIXER_ROUTES("OUT1L", "HPOUT1L"),
 	ARIZONA_MIXER_ROUTES("OUT1R", "HPOUT1R"),
 
@@ -1016,6 +1019,27 @@ static struct snd_soc_dai_driver cs47l24_dai[] = {
 			.formats = CS47L24_FORMATS,
 		},
 	},
+	{
+		.name = "cs47l24-cpu-trace",
+		.capture = {
+			.stream_name = "Audio Trace CPU",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = CS47L24_RATES,
+			.formats = CS47L24_FORMATS,
+		},
+		.compress_new = snd_soc_new_compress,
+	},
+	{
+		.name = "cs47l24-dsp-trace",
+		.capture = {
+			.stream_name = "Audio Trace DSP",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = CS47L24_RATES,
+			.formats = CS47L24_FORMATS,
+		},
+	},
 };
 
 static int cs47l24_open(struct snd_compr_stream *stream)
@@ -1027,6 +1051,8 @@ static int cs47l24_open(struct snd_compr_stream *stream)
 
 	if (strcmp(rtd->codec_dai->name, "cs47l24-dsp-voicectrl") == 0) {
 		n_adsp = 2;
+	} else if (strcmp(rtd->codec_dai->name, "cs47l24-dsp-trace") == 0) {
+		n_adsp = 1;
 	} else {
 		dev_err(arizona->dev,
 			"No suitable compressed stream for DAI '%s'\n",
@@ -1041,10 +1067,16 @@ static irqreturn_t cs47l24_adsp2_irq(int irq, void *data)
 {
 	struct cs47l24_priv *priv = data;
 	struct arizona *arizona = priv->core.arizona;
-	int ret;
+	int serviced = 0;
+	int i, ret;
+
+	for (i = 1; i <= 2; ++i) {
+		ret = wm_adsp_compr_handle_irq(&priv->core.adsp[i]);
+		if (ret != -ENODEV)
+			serviced++;
+	}
 
-	ret = wm_adsp_compr_handle_irq(&priv->core.adsp[2]);
-	if (ret == -ENODEV) {
+	if (!serviced) {
 		dev_err(arizona->dev, "Spurious compressed data IRQ\n");
 		return IRQ_NONE;
 	}
-- 
2.1.4
