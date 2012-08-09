From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: arizona: Implement OPCLK support
Date: Thu,  9 Aug 2012 19:16:57 +0100
Message-ID: <1344536219-6751-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6410E266422
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 19:47:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Arizona devices support two output system clocks. Provide support for
configuring these via set_sysclk(). Once the clock API is more useful
we should migrate over to that.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   66 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |    6 ++--
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 5c9caca..5e96a0a 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -229,6 +229,69 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 }
 EXPORT_SYMBOL_GPL(arizona_out_ev);
 
+static unsigned int arizona_sysclk_48k_rates[] = {
+	6144000,
+	12288000,
+	22579200,
+	49152000,
+};
+
+static unsigned int arizona_sysclk_44k1_rates[] = {
+	5644800,
+	11289600,
+	24576000,
+	45158400,
+};
+
+static int arizona_set_opclk(struct snd_soc_codec *codec, unsigned int clk,
+			     unsigned int freq)
+{
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg;
+	unsigned int *rates;
+	int ref, div, refclk;
+
+	switch (clk) {
+	case ARIZONA_CLK_OPCLK:
+		reg = ARIZONA_OUTPUT_SYSTEM_CLOCK;
+		refclk = priv->sysclk;
+		break;
+	case ARIZONA_CLK_ASYNC_OPCLK:
+		reg = ARIZONA_OUTPUT_ASYNC_CLOCK;
+		refclk = priv->asyncclk;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (refclk % 8000)
+		rates = arizona_sysclk_44k1_rates;
+	else
+		rates = arizona_sysclk_48k_rates;
+
+	for (ref = 0; ref < ARRAY_SIZE(arizona_sysclk_48k_rates) &&
+		     rates[ref] <= refclk; ref++) {
+		div = 1;
+		while (rates[ref] / div >= freq && div < 32) {
+			if (rates[ref] / div == freq) {
+				dev_dbg(codec->dev, "Configured %dHz OPCLK\n",
+					freq);
+				snd_soc_update_bits(codec, reg,
+						    ARIZONA_OPCLK_DIV_MASK |
+						    ARIZONA_OPCLK_SEL_MASK,
+						    (div <<
+						     ARIZONA_OPCLK_DIV_SHIFT) |
+						    ref);
+				return 0;
+			}
+			div++;
+		}
+	}
+
+	dev_err(codec->dev, "Unable to generate %dHz OPCLK\n", freq);
+	return -EINVAL;
+}
+
 int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 		       int source, unsigned int freq, int dir)
 {
@@ -252,6 +315,9 @@ int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 		reg = ARIZONA_ASYNC_CLOCK_1;
 		clk = &priv->asyncclk;
 		break;
+	case ARIZONA_CLK_OPCLK:
+	case ARIZONA_CLK_ASYNC_OPCLK:
+		return arizona_set_opclk(codec, clk_id, freq);
 	default:
 		return -EINVAL;
 	}
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 59caca8..eb66b52 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -17,8 +17,10 @@
 
 #include <sound/soc.h>
 
-#define ARIZONA_CLK_SYSCLK   1
-#define ARIZONA_CLK_ASYNCCLK 2
+#define ARIZONA_CLK_SYSCLK         1
+#define ARIZONA_CLK_ASYNCCLK       2
+#define ARIZONA_CLK_OPCLK          3
+#define ARIZONA_CLK_ASYNC_OPCLK    4
 
 #define ARIZONA_CLK_SRC_MCLK1    0x0
 #define ARIZONA_CLK_SRC_MCLK2    0x1
-- 
1.7.10.4
