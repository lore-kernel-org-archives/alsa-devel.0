From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 17/22] ASoC: tas2552: Add support for word
	length configuration
Date: Thu, 4 Jun 2015 15:22:41 +0300
Message-ID: <1433420571-5421-18-git-send-email-peter.ujfalusi@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ECC12664F0
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:23:35 +0200 (CEST)
In-Reply-To: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Configure the word length based on the params_width of the stream.
Also configure the clock per frame value which is used when tas2552 is bus
master.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 38 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tas2552.h | 10 ++++++++++
 2 files changed, 48 insertions(+)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 9c081344bd90..13b435f9a9b1 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -166,7 +166,45 @@ static int tas2552_hw_params(struct snd_pcm_substream *substream,
 	struct tas2552_data *tas2552 = dev_get_drvdata(codec->dev);
 	int sample_rate, pll_clk;
 	int d;
+	int cpf;
 	u8 p, j;
+	u8 ser_ctrl1_reg;
+
+	switch (params_width(params)) {
+	case 16:
+		ser_ctrl1_reg = TAS2552_WORDLENGTH_16BIT;
+		cpf = 32 + tas2552->tdm_delay;
+		break;
+	case 20:
+		ser_ctrl1_reg = TAS2552_WORDLENGTH_20BIT;
+		cpf = 64 + tas2552->tdm_delay;
+		break;
+	case 24:
+		ser_ctrl1_reg = TAS2552_WORDLENGTH_24BIT;
+		cpf = 64 + tas2552->tdm_delay;
+		break;
+	case 32:
+		ser_ctrl1_reg = TAS2552_WORDLENGTH_32BIT;
+		cpf = 64 + tas2552->tdm_delay;
+		break;
+	default:
+		dev_err(codec->dev, "Not supported sample size: %d\n",
+			params_width(params));
+		return -EINVAL;
+	}
+
+	if (cpf <= 32)
+		ser_ctrl1_reg |= TAS2552_CLKSPERFRAME_32;
+	else if (cpf <= 64)
+		ser_ctrl1_reg |= TAS2552_CLKSPERFRAME_64;
+	else if (cpf <= 128)
+		ser_ctrl1_reg |= TAS2552_CLKSPERFRAME_128;
+	else
+		ser_ctrl1_reg |= TAS2552_CLKSPERFRAME_256;
+
+	snd_soc_update_bits(codec, TAS2552_SER_CTRL_1,
+			    TAS2552_WORDLENGTH_MASK | TAS2552_CLKSPERFRAME_MASK,
+			    ser_ctrl1_reg);
 
 	if (!tas2552->pll_clkin)
 		return -EINVAL;
diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
index 5bdc7eaaddea..de0ab0d27520 100644
--- a/sound/soc/codecs/tas2552.h
+++ b/sound/soc/codecs/tas2552.h
@@ -66,11 +66,21 @@
 #define TAS2552_SDOUT_TRISTATE		(1 << 2)
 
 /* Serial Interface Control Register Masks */
+#define TAS2552_WORDLENGTH_16BIT	(0x0 << 0)
+#define TAS2552_WORDLENGTH_20BIT	(0x1 << 0)
+#define TAS2552_WORDLENGTH_24BIT	(0x2 << 0)
+#define TAS2552_WORDLENGTH_32BIT	(0x3 << 0)
+#define TAS2552_WORDLENGTH_MASK		TAS2552_WORDLENGTH_32BIT
 #define TAS2552_DATAFORMAT_I2S		(0x0 << 2)
 #define TAS2552_DATAFORMAT_DSP		(0x1 << 2)
 #define TAS2552_DATAFORMAT_RIGHT_J	(0x2 << 2)
 #define TAS2552_DATAFORMAT_LEFT_J	(0x3 << 2)
 #define TAS2552_DATAFORMAT_MASK		TAS2552_DATAFORMAT_LEFT_J
+#define TAS2552_CLKSPERFRAME_32		(0x0 << 4)
+#define TAS2552_CLKSPERFRAME_64		(0x1 << 4)
+#define TAS2552_CLKSPERFRAME_128	(0x2 << 4)
+#define TAS2552_CLKSPERFRAME_256	(0x3 << 4)
+#define TAS2552_CLKSPERFRAME_MASK	TAS2552_CLKSPERFRAME_256
 #define TAS2552_BCLKDIR			(1 << 6)
 #define TAS2552_WCLKDIR			(1 << 7)
 
-- 
2.4.2
