From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/3] ad193x: add set_pll entry to support
	different clock input
Date: Wed, 21 Apr 2010 17:36:47 +0800
Message-ID: <1271842609-18276-2-git-send-email-21cnbao@gmail.com>
References: <1271842609-18276-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 9220010382E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 11:38:14 +0200 (CEST)
In-Reply-To: <1271842609-18276-1-git-send-email-21cnbao@gmail.com>
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
 sound/soc/codecs/ad193x.c |   31 +++++++++++++++++++++++++++++++
 sound/soc/codecs/ad193x.h |    5 +++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 7ed787e..8a099ac 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -249,6 +249,36 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int ad193x_set_dai_pll(struct snd_soc_dai *codec_dai,
+		int pll_id, int source, unsigned int freq_in, unsigned int freq_out)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	int reg;
+
+	reg = snd_soc_read(codec, AD193X_PLL_CLK_CTRL0);
+
+	switch (freq_in) {
+	case 12288000:
+		reg = (reg & AD193X_PLL_INPUT_MASK) | AD193X_PLL_INPUT_256;
+		break;
+	case 18432000:
+		reg = (reg & AD193X_PLL_INPUT_MASK) | AD193X_PLL_INPUT_384;
+		break;
+	case 24576000:
+		reg = (reg & AD193X_PLL_INPUT_MASK) | AD193X_PLL_INPUT_512;
+		break;
+	case 36864000:
+		reg = (reg & AD193X_PLL_INPUT_MASK) | AD193X_PLL_INPUT_768;
+		break;
+	default:
+		dev_err(codec->dev, "ad193x_set_dai_pll: unsupported pll input freq:%d", freq_in);
+		return -EINVAL;
+	}
+
+	snd_soc_write(codec, AD193X_PLL_CLK_CTRL0, reg);
+	return 0;
+}
+
 static int ad193x_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct snd_soc_dai *dai)
@@ -382,6 +412,7 @@ static struct snd_soc_dai_ops ad193x_dai_ops = {
 	.digital_mute = ad193x_mute,
 	.set_tdm_slot = ad193x_set_tdm_slot,
 	.set_fmt = ad193x_set_dai_fmt,
+	.set_pll = ad193x_set_dai_pll,
 };
 
 /* codec DAI instance */
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
