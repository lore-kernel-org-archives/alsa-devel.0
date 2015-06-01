From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 31/47] ASoC: wm8962: Replace direct
	snd_soc_codec dapm field access
Date: Mon,  1 Jun 2015 10:10:50 +0200
Message-ID: <1433146266-1599-31-git-send-email-lars@metafoo.de>
References: <1433146266-1599-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-058.synserver.de
 [212.40.185.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B1A62619E9
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 10:11:26 +0200 (CEST)
In-Reply-To: <1433146266-1599-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level() and replace all
other manual access to codec->dapm with snd_soc_codec_get_dapm().

Also drop the unnecessary comparison in the set_bias_level() callback that
checks if the device is already at the target level. The core already takes
care of this and will not call the callback if the device is already at the
target level.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8962.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 00793b7..c5748fd 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2361,7 +2361,7 @@ static int wm8962_add_widgets(struct snd_soc_codec *codec)
 {
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	struct wm8962_pdata *pdata = &wm8962->pdata;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 
 	snd_soc_add_codec_controls(codec, wm8962_snd_controls,
 			     ARRAY_SIZE(wm8962_snd_controls));
@@ -2446,13 +2446,13 @@ static void wm8962_configure_bclk(struct snd_soc_codec *codec)
 	 * So we here provisionally enable it and then disable it afterward
 	 * if current bias_level hasn't reached SND_SOC_BIAS_ON.
 	 */
-	if (codec->dapm.bias_level != SND_SOC_BIAS_ON)
+	if (snd_soc_codec_get_bias_level(codec) != SND_SOC_BIAS_ON)
 		snd_soc_update_bits(codec, WM8962_CLOCKING2,
 				WM8962_SYSCLK_ENA_MASK, WM8962_SYSCLK_ENA);
 
 	dspclk = snd_soc_read(codec, WM8962_CLOCKING1);
 
-	if (codec->dapm.bias_level != SND_SOC_BIAS_ON)
+	if (snd_soc_codec_get_bias_level(codec) != SND_SOC_BIAS_ON)
 		snd_soc_update_bits(codec, WM8962_CLOCKING2,
 				WM8962_SYSCLK_ENA_MASK, 0);
 
@@ -2510,9 +2510,6 @@ static void wm8962_configure_bclk(struct snd_soc_codec *codec)
 static int wm8962_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	if (level == codec->dapm.bias_level)
-		return 0;
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
@@ -2530,7 +2527,7 @@ static int wm8962_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_update_bits(codec, WM8962_PWR_MGMT_1,
 				    WM8962_VMID_SEL_MASK, 0x100);
 
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
 			msleep(100);
 		break;
 
@@ -2613,7 +2610,7 @@ static int wm8962_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(codec->dev, "hw_params set BCLK %dHz LRCLK %dHz\n",
 		wm8962->bclk, wm8962->lrclk);
 
-	if (codec->dapm.bias_level == SND_SOC_BIAS_ON)
+	if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON)
 		wm8962_configure_bclk(codec);
 
 	return 0;
@@ -3117,7 +3114,7 @@ static irqreturn_t wm8962_irq(int irq, void *data)
 int wm8962_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 {
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	int irq_mask, enable;
 
 	wm8962->jack = jack;
@@ -3163,7 +3160,7 @@ static void wm8962_beep_work(struct work_struct *work)
 	struct wm8962_priv *wm8962 =
 		container_of(work, struct wm8962_priv, beep_work);
 	struct snd_soc_codec *codec = wm8962->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	int i;
 	int reg = 0;
 	int best = 0;
@@ -3414,6 +3411,7 @@ static void wm8962_free_gpio(struct snd_soc_codec *codec)
 
 static int wm8962_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	int ret;
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	int i;
@@ -3461,7 +3459,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	}
 	if (!dmicclk || !dmicdat) {
 		dev_dbg(codec->dev, "DMIC not in use, disabling\n");
-		snd_soc_dapm_nc_pin(&codec->dapm, "DMICDAT");
+		snd_soc_dapm_nc_pin(dapm, "DMICDAT");
 	}
 	if (dmicclk != dmicdat)
 		dev_warn(codec->dev, "DMIC GPIOs partially configured\n");
-- 
2.1.4
