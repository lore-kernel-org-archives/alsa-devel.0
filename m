From: pascal.huerst@gmail.com
Subject: [PATCH] ASoC: adau1701: Reset codec based on sample
	rate changes
Date: Wed, 23 Mar 2016 12:58:23 +0100
Message-ID: <1458734303-16307-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E782D260534
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 12:58:34 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id l68so3629992wml.3
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 04:58:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lars@metafoo.de
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Pascal Huerst <pascal.huerst@gmail.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Pascal Huerst <pascal.huerst@gmail.com>

Instead of checking if mclk/lrclk ratio has changed, check if
sample rate has changed. In certain cases, the mclk might be
changed in the machine driver, which can lead to the same
mclk/lrclk ration, eventhow the sample rate has changed.

Since the codec has to be programmed differently for every
sample rate, its better to check for samplerate changes instead
of mclk/lrclk ration changes.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
---
 sound/soc/codecs/adau1701.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 202dea1..1dbbcda 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -111,6 +111,7 @@ struct adau1701 {
 	unsigned int dai_fmt;
 	unsigned int pll_clkdiv;
 	unsigned int sysclk;
+	unsigned int current_rate;
 	struct regmap *regmap;
 	struct i2c_client *client;
 	u8 pin_config[12];
@@ -436,22 +437,24 @@ static int adau1701_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
-	unsigned int clkdiv = adau1701->sysclk / params_rate(params);
+	unsigned int rate = params_rate(params);
+	unsigned int clkdiv = adau1701->sysclk / rate;
 	unsigned int val;
 	int ret;

 	/*
-	 * If the mclk/lrclk ratio changes, the chip needs updated PLL
+	 * If the sample rate changes, the chip needs updated PLL
 	 * mode GPIO settings, and a full reset cycle, including a new
 	 * firmware upload.
 	 */
-	if (clkdiv != adau1701->pll_clkdiv) {
-		ret = adau1701_reset(codec, clkdiv, params_rate(params));
+	if (adau1701->current_rate != rate) {
+		adau1701->current_rate = rate;
+		ret = adau1701_reset(codec, clkdiv, rate);
 		if (ret < 0)
 			return ret;
 	}

-	switch (params_rate(params)) {
+	switch (rate) {
 	case 192000:
 		val = ADAU1701_DSPCTRL_SR_192;
 		break;
--
2.5.0
