From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCHv6 6/9] ASOC: wm8971: add constraint for setting
	set_sysclk()
Date: Mon,  1 Dec 2014 14:51:58 +0800
Message-ID: <1417416721-17271-6-git-send-email-xavier.hsu@linaro.org>
References: <1417416721-17271-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id AD4AF260623
 for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2014 07:52:41 +0100 (CET)
In-Reply-To: <1417416721-17271-1-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
Cc: Xavier Hsu <xavier.hsu@linaro.org>, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 sound/soc/codecs/wm8971.c |   80 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 5f711bd..1f3abbb 100755
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -40,7 +40,9 @@ static struct workqueue_struct *wm8971_workq;
 
 /* codec private data */
 struct wm8971_priv {
+	/* MCLK */
 	unsigned int sysclk;
+	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 
 	/* De-emphasis */
 	struct mutex deemph_mutex;
@@ -530,6 +532,35 @@ static int get_coeff(int mclk, int rate)
 	return -EINVAL;
 }
 
+/* The set of rates we can generate from the above for each SYSCLK */
+static const unsigned int rates_48000[] = {
+	8000, 12000, 16000, 24000, 32000, 48000, 96000
+};
+
+static struct snd_pcm_hw_constraint_list constraints_48000 = {
+	.count  = ARRAY_SIZE(rates_48000),
+	.list   = rates_48000,
+};
+
+static const unsigned int rates_44100[] = {
+	8000, 11025, 22050, 44100, 88200
+};
+
+static struct snd_pcm_hw_constraint_list constraints_44100 = {
+	.count  = ARRAY_SIZE(rates_44100),
+	.list   = rates_44100,
+};
+
+static const unsigned int rates_12[] = {
+	8000, 11025, 12000, 16000, 22050, 24000, 32000, 41100, 48000,
+	88235, 96000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_12 = {
+	.count  = ARRAY_SIZE(rates_12),
+	.list   = rates_12,
+};
+
 static int wm8971_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
 {
@@ -537,15 +568,29 @@ static int wm8971_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
 
 	switch (freq) {
-	case 11289600:
-	case 12000000:
 	case 12288000:
-	case 16934400:
+	case 24576000:
 	case 18432000:
-		wm8971->sysclk = freq;
-		return 0;
+	case 36864000:
+		wm8971->sysclk_constraints = &constraints_48000;
+		break;
+	case 11289600:
+	case 22579200:
+	case 16934400:
+	case 33868800:
+		wm8971->sysclk_constraints = &constraints_44100;
+		break;
+	case 12000000:
+	case 24000000:
+		wm8971->sysclk_constraints = &constraints_12;
+		break;
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
+
+	wm8971->sysclk = freq;
+
+	return 0;
 }
 
 static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
@@ -604,6 +649,28 @@ static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int wm8971_pcm_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+
+	/* The set of sample rates that can be supported depends on the
+	 * MCLK supplied to the CODEC - enforce this.
+	 */
+	if (!wm8971->sysclk) {
+		dev_err(codec->dev,
+			"No MCLK configured, call set_sysclk() on init\n");
+		return -EINVAL;
+	}
+
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   wm8971->sysclk_constraints);
+
+	return 0;
+}
+
 static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
@@ -689,6 +756,7 @@ static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 			SNDRV_PCM_FMTBIT_S24_LE)
 
 static const struct snd_soc_dai_ops wm8971_dai_ops = {
+	.startup	= wm8971_pcm_startup,
 	.hw_params	= wm8971_pcm_hw_params,
 	.digital_mute	= wm8971_mute,
 	.set_fmt	= wm8971_set_dai_fmt,
-- 
1.7.9.5
