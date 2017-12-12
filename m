From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-codec: enable 12Khz and 24Khz
	audio sample rates" to the asoc tree
Date: Tue, 12 Dec 2017 11:16:50 +0000
Message-ID: <E1eOiYM-0007sd-JT@debutante>
References: <20171212091450.GA13602@andrea-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 76CE126705F
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 12:16:59 +0100 (CET)
In-Reply-To: <20171212091450.GA13602@andrea-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
Cc: alsa-devel@alsa-project.org, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Liam Girdwood <lgirdwood@gmail.com>, Adam Sampson <ats@offog.org>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-codec: enable 12Khz and 24Khz audio sample rates

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 5a0cf02465a0510c48ab34e7ba88b0f8c20b9ea1 Mon Sep 17 00:00:00 2001
From: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
Date: Tue, 12 Dec 2017 10:14:50 +0100
Subject: [PATCH] ASoC: sun4i-codec: enable 12Khz and 24Khz audio sample rates

H3 ASoC supports 12Khz and 24Khz audio sample rates but the current
drivers doesn't advertise these rates properly and they cannot be used.

For example attempt to capture at 12Khz uses 11Khz (same applies to
audio playback):

Recording raw data '/tmp/testS16_LE.raw' : Signed 16 bit Little Endian, Rate 12000 Hz, Stereo
Warning: rate is not accurate (requested = 12000Hz, got = 11025Hz)

This patch fixes the audio sample rates declared and supported by the
driver according to the H3 data sheet.  Specifically for audio playback:

8000, 11050, 12000, 16000, 22050, 24000, 32000, 44100, 48000, 96000, 192000

and for audio capture:

8000, 11050, 12000, 16000, 22050, 24000, 32000, 44100, 48000

Signed-off-by: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 5da4efe7a550..886281673972 100644
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
2.15.1
