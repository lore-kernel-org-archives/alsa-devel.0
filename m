From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] ad193x: add set_sysclk entry to support
	different clock input
Date: Fri, 21 May 2010 11:57:01 +0800
Message-ID: <1274414221-12200-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 29AAC24657
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 05:58:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/codecs/ad193x.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/ad193x.h |    5 +++++
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index c8ca114..1def75e 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -24,6 +24,7 @@
 
 /* codec private data */
 struct ad193x_priv {
+	unsigned int sysclk;
 	struct snd_soc_codec codec;
 	u8 reg_cache[AD193X_NUM_REGS];
 };
@@ -251,15 +252,32 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int ad193x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(codec);
+	switch (freq) {
+	case 12288000:
+	case 18432000:
+	case 24576000:
+	case 36864000:
+		ad193x->sysclk = freq;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static int ad193x_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct snd_soc_dai *dai)
 {
-	int word_len = 0, reg = 0;
+	int word_len = 0, reg = 0, master_rate = 0;
 
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
+	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(codec);
 
 	/* bit size */
 	switch (params_format(params)) {
@@ -275,6 +293,25 @@ static int ad193x_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
+	switch (ad193x->sysclk) {
+	case 12288000:
+		master_rate = AD193X_PLL_INPUT_256;
+		break;
+	case 18432000:
+		master_rate = AD193X_PLL_INPUT_384;
+		break;
+	case 24576000:
+		master_rate = AD193X_PLL_INPUT_512;
+		break;
+	case 36864000:
+		master_rate = AD193X_PLL_INPUT_768;
+		break;
+	}
+
+	reg = snd_soc_read(codec, AD193X_PLL_CLK_CTRL0);
+	reg = (reg & AD193X_PLL_INPUT_MASK) | master_rate;
+	snd_soc_write(codec, AD193X_PLL_CLK_CTRL0, reg);
+
 	reg = snd_soc_read(codec, AD193X_DAC_CTRL2);
 	reg = (reg & (~AD193X_DAC_WORD_LEN_MASK)) | word_len;
 	snd_soc_write(codec, AD193X_DAC_CTRL2, reg);
@@ -348,6 +385,7 @@ static int ad193x_bus_probe(struct device *dev, void *ctrl_data, int bus_type)
 	/* pll input: mclki/xi */
 	snd_soc_write(codec, AD193X_PLL_CLK_CTRL0, 0x99); /* mclk=24.576Mhz: 0x9D; mclk=12.288Mhz: 0x99 */
 	snd_soc_write(codec, AD193X_PLL_CLK_CTRL1, 0x04);
+	ad193x->sysclk = 12288000;
 
 	ret = snd_soc_register_codec(codec);
 	if (ret != 0) {
@@ -383,6 +421,7 @@ static struct snd_soc_dai_ops ad193x_dai_ops = {
 	.hw_params = ad193x_hw_params,
 	.digital_mute = ad193x_mute,
 	.set_tdm_slot = ad193x_set_tdm_slot,
+	.set_sysclk	= ad193x_set_dai_sysclk,
 	.set_fmt = ad193x_set_dai_fmt,
 };
 
diff --git a/sound/soc/codecs/ad193x.h b/sound/soc/codecs/ad193x.h
index a03c880..654ba64 100644
--- a/sound/soc/codecs/ad193x.h
+++ b/sound/soc/codecs/ad193x.h
@@ -11,6 +11,11 @@
 
 #define AD193X_PLL_CLK_CTRL0    0x800
 #define AD193X_PLL_POWERDOWN           0x01
+#define AD193X_PLL_INPUT_MASK   (~0x6)
+#define AD193X_PLL_INPUT_256    (0 << 1)
+#define AD193X_PLL_INPUT_384    (1 << 1)
+#define AD193X_PLL_INPUT_512    (2 << 1)
+#define AD193X_PLL_INPUT_768    (3 << 1)
 #define AD193X_PLL_CLK_CTRL1    0x801
 #define AD193X_DAC_CTRL0        0x802
 #define AD193X_DAC_POWERDOWN           0x01
-- 
1.5.6.3
