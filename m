From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 2/2] ASoC: pcm3060: Add clock select
Date: Mon, 11 Feb 2019 07:08:39 +0100
Message-ID: <20190211060839.21417-2-kmarinushkin@birdec.tech>
References: <20190211060839.21417-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 655BD267503
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2019 07:06:18 +0100 (CET)
In-Reply-To: <20190211060839.21417-1-kmarinushkin@birdec.tech>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kirill Marinushkin <kmarinushkin@birdec.tech>
List-Id: alsa-devel@alsa-project.org

ADC and DAC can be clocked from separate or same sources CLK1 and CLK2.
By default, ADC is clocked from CLK1, and DAC - from CLK2.

This commits allows sound cards to selest a proper clock source during
`hw_params()` via `snd_soc_dai_set_sysclk()`. It makes possible to have a
single clock source for both ADC and DAC.

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 27 +++++++++++++++++++++++++++
 sound/soc/codecs/pcm3060.h |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 543cb86fd764..32b26f1c2282 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -18,12 +18,39 @@ static int pcm3060_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	struct snd_soc_component *comp = dai->component;
 	struct pcm3060_priv *priv = snd_soc_component_get_drvdata(comp);
+	unsigned int reg;
+	unsigned int val;
 
 	if (dir != SND_SOC_CLOCK_IN) {
 		dev_err(comp->dev, "unsupported sysclock dir: %d\n", dir);
 		return -EINVAL;
 	}
 
+	switch (clk_id) {
+	case PCM3060_CLK_DEF:
+		val = 0;
+		break;
+
+	case PCM3060_CLK1:
+		val = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG_CSEL : 0);
+		break;
+
+	case PCM3060_CLK2:
+		val = (dai->id == PCM3060_DAI_ID_DAC ? 0 : PCM3060_REG_CSEL);
+		break;
+
+	default:
+		dev_err(comp->dev, "unsupported sysclock id: %d\n", clk_id);
+		return -EINVAL;
+	}
+
+	if (dai->id == PCM3060_DAI_ID_DAC)
+		reg = PCM3060_REG67;
+	else
+		reg = PCM3060_REG72;
+
+	regmap_update_bits(priv->regmap, reg, PCM3060_REG_CSEL, val);
+
 	priv->dai[dai->id].sclk_freq = freq;
 
 	return 0;
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index 6a027b4a845d..75931c9a9d85 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -17,6 +17,11 @@ extern const struct regmap_config pcm3060_regmap;
 #define PCM3060_DAI_ID_ADC	1
 #define PCM3060_DAI_IDS_NUM	2
 
+/* ADC and DAC can be clocked from separate or same sources CLK1 and CLK2 */
+#define PCM3060_CLK_DEF	0 /* default: CLK1->ADC, CLK2->DAC */
+#define PCM3060_CLK1		1
+#define PCM3060_CLK2		2
+
 struct pcm3060_priv_dai {
 	bool is_master;
 	unsigned int sclk_freq;
-- 
2.13.6
