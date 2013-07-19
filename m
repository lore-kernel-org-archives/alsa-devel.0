From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: wm8962: Provide a .hw_free function
Date: Fri, 19 Jul 2013 09:18:08 -0300
Message-ID: <1374236288-28854-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f49.google.com (mail-yh0-f49.google.com
 [209.85.213.49])
 by alsa0.perex.cz (Postfix) with ESMTP id A9A14265697
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 14:18:19 +0200 (CEST)
Received: by mail-yh0-f49.google.com with SMTP id v1so1483347yhn.22
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 05:18:18 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Currently after playing any audio file, we get the following error message:

$ aplay clarinet.wav 
Playing WAVE 'clarinet.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
$ wm8962 0-001a: Unsupported sysclk ratio 544

This error message appears about 5 seconds after the audio playback has 
finished.

In order to avoid such error message, let's add a .hw_free function which will
zero out wm8962->lrclk and wm8962->bclk, which according to the code below:

	if (!wm8962->bclk || !wm8962->lrclk) {
		dev_dbg(codec->dev, "No audio clocks configured\n");
		return;
	}

,will cause the wm8962_configure_bclk() function not to search a valid sysclk 
ratio after playback has finished.

Suggested-by: Nicolin Chen <b42378@freescale.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8962.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 6a5066c..01033c2 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2914,6 +2914,18 @@ static int wm8962_mute(struct snd_soc_dai *dai, int mute)
 				   WM8962_DAC_MUTE, val);
 }
 
+static int wm8962_hw_free(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
+
+	wm8962->lrclk = 0;
+	wm8962->bclk = 0;
+
+	return 0;
+}
+
 #define WM8962_RATES SNDRV_PCM_RATE_8000_96000
 
 #define WM8962_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
@@ -2921,6 +2933,7 @@ static int wm8962_mute(struct snd_soc_dai *dai, int mute)
 
 static const struct snd_soc_dai_ops wm8962_dai_ops = {
 	.hw_params = wm8962_hw_params,
+	.hw_free = wm8962_hw_free,
 	.set_sysclk = wm8962_set_dai_sysclk,
 	.set_fmt = wm8962_set_dai_fmt,
 	.digital_mute = wm8962_mute,
-- 
1.8.1.2
