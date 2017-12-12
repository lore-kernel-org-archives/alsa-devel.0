From: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
Subject: [PATCH] ASoC: sun4i-codec: fix to enable 12Khz and
 24Khz audio playback and capture sample rates
Date: Tue, 12 Dec 2017 10:14:50 +0100
Message-ID: <20171212091450.GA13602@andrea-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 3331C266F52
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 10:14:58 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id r78so19361297wme.5
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 01:14:58 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Jon Smirl <jonsmirl@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Adam Sampson <ats@offog.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

H3 ASoC supports 12Khz and 24Khz audio sample rates but the current drivers doesn't advertise these rates properly and they cannot be used.

For example attempt to capture at 12Khz uses 11Khz (same applies to audio playback):
# arecord -f S16_LE -c 2 -r 12000  -D hw:0,0  -t raw /tmp/testS16_LE.raw
Recording raw data '/tmp/testS16_LE.raw' : Signed 16 bit Little Endian, Rate 12000 Hz, Stereo
Warning: rate is not accurate (requested = 12000Hz, got = 11025Hz)

This patch fixes the audio sample rates declared and supported by the driver according to the H3 data sheet.
Specifically for audio playback:
8000, 11050, 12000, 16000, 22050, 24000, 32000, 44100, 48000, 96000, 192000
and for audio capture:
8000, 11050, 12000, 16000, 22050, 24000, 32000, 44100, 48000

Signed-off-by: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 5da4efe..c79e8a4 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -590,12 +590,28 @@ static int sun4i_codec_hw_params(struct snd_pcm_substream *substream,
 					     hwrate);
 }
 
+
+static unsigned int sun4i_codec_src_rates[] = {
+	8000, 11025, 12000, 16000, 22050, 24000, 32000,
+	44100, 48000, 96000, 192000
+};
+
+
+static struct snd_pcm_hw_constraint_list sun4i_codec_constraints = {
+	.count  = ARRAY_SIZE(sun4i_codec_src_rates),
+	.list   = sun4i_codec_src_rates,
+};
+
+
 static int sun4i_codec_startup(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(rtd->card);
 
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, &sun4i_codec_constraints);
+
 	/*
 	 * Stop issuing DRQ when we have room for less than 16 samples
 	 * in our TX FIFO
@@ -633,9 +649,7 @@ static struct snd_soc_dai_driver sun4i_codec_dai = {
 		.channels_max	= 2,
 		.rate_min	= 8000,
 		.rate_max	= 192000,
-		.rates		= SNDRV_PCM_RATE_8000_48000 |
-				  SNDRV_PCM_RATE_96000 |
-				  SNDRV_PCM_RATE_192000,
+		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE |
 				  SNDRV_PCM_FMTBIT_S32_LE,
 		.sig_bits	= 24,
@@ -645,11 +659,8 @@ static struct snd_soc_dai_driver sun4i_codec_dai = {
 		.channels_min	= 1,
 		.channels_max	= 2,
 		.rate_min	= 8000,
-		.rate_max	= 192000,
-		.rates		= SNDRV_PCM_RATE_8000_48000 |
-				  SNDRV_PCM_RATE_96000 |
-				  SNDRV_PCM_RATE_192000 |
-				  SNDRV_PCM_RATE_KNOT,
+		.rate_max	= 48000,
+		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE |
 				  SNDRV_PCM_FMTBIT_S32_LE,
 		.sig_bits	= 24,
@@ -1128,7 +1139,7 @@ static const struct snd_soc_component_driver sun4i_codec_component = {
 	.name = "sun4i-codec",
 };
 
-#define SUN4I_CODEC_RATES	SNDRV_PCM_RATE_8000_192000
+#define SUN4I_CODEC_RATES	SNDRV_PCM_RATE_CONTINUOUS
 #define SUN4I_CODEC_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
 				 SNDRV_PCM_FMTBIT_S32_LE)
 
-- 
2.7.4
