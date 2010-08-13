From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/7] ASoC: Automatically manage WM8580 DAC OSR
Date: Fri, 13 Aug 2010 20:35:07 +0100
Message-ID: <1281728107-25386-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100813193305.GB3778@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C96FA10390E
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 21:35:13 +0200 (CEST)
In-Reply-To: <20100813193305.GB3778@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

The DAC OSR should be selected based on the sample clock ratio.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 357f7d5..cb862df 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -94,6 +94,8 @@
 
 #define WM8580_MAX_REGISTER                  0x35
 
+#define WM8580_DACOSR 0x40
+
 /* PLLB4 (register 7h) */
 #define WM8580_PLLB4_MCLKOUTSRC_MASK   0x60
 #define WM8580_PLLB4_MCLKOUTSRC_PLLA   0x20
@@ -481,7 +483,7 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
 	u16 paifa = 0;
 	u16 paifb = 0;
-	int i, ratio;
+	int i, ratio, osr;
 
 	/* bit size */
 	switch (params_format(params)) {
@@ -518,6 +520,22 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(codec->dev, "Running at %dfs with %dHz clock\n",
 		wm8580_sysclk_ratios[i], wm8580->sysclk[dai->driver->id]);
 
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (ratio) {
+		case 128:
+		case 192:
+			osr = WM8580_DACOSR;
+			dev_dbg(codec->dev, "Selecting 64x OSR\n");
+			break;
+		default:
+			osr = 0;
+			dev_dbg(codec->dev, "Selecting 128x OSR\n");
+			break;
+		}
+
+		snd_soc_update_bits(codec, WM8580_PAIF3, WM8580_DACOSR, osr);
+	}
+
 	snd_soc_update_bits(codec, WM8580_PAIF1 + dai->driver->id,
 			    WM8580_AIF_RATE_MASK | WM8580_AIF_BCLKSEL_MASK,
 			    paifa);
-- 
1.7.1
