From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH] ASoC: pcm512x: enable set_sysclk callback
Date: Fri,  1 Jun 2018 16:26:43 -0500
Message-ID: <20180601212643.20101-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 63CE22677C5
 for <alsa-devel@alsa-project.org>; Fri,  1 Jun 2018 23:27:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

For codec master mode, the current pcm512x code relies on the clock API.

Simple boards such as Hifiberry DAC+ PRO rely on 2 local oscillators
to generate 44.1 or 48kHz multiples, with the clock selection being
handled by the machine driver toggling GPIOS.

The RaspberryPi kernel exposes a "hifiberry,dacpro-clk" clock driver
which does nothing but tell the codec driver what rate is set by the
machine driver [1][2]

This patch suggests an alternate fallback solution to let the codec
driver know what the sysclk is based on the existing .set_sysclk
callback.

[1] https://github.com/raspberrypi/linux/blob/rpi-4.14.y/sound/soc/bcm/hifiberry_dacplus.c
[2] https://github.com/raspberrypi/linux/blob/rpi-4.14.y/drivers/clk/clk-hifiberry-dacpro.c

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/pcm512x.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index f0f2d4fd3769..8d6c173c1e25 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -40,6 +40,7 @@ static const char * const pcm512x_supply_names[PCM512x_NUM_SUPPLIES] = {
 struct pcm512x_priv {
 	struct regmap *regmap;
 	struct clk *sclk;
+	int sysclk;
 	struct regulator_bulk_data supplies[PCM512x_NUM_SUPPLIES];
 	struct notifier_block supply_nb[PCM512x_NUM_SUPPLIES];
 	int fmt;
@@ -519,6 +520,29 @@ static int pcm512x_hw_rule_rate(struct snd_pcm_hw_params *params,
 				   ARRAY_SIZE(ranges), ranges, 0);
 }
 
+static int sclk_get_rate(struct pcm512x_priv *pcm512x)
+{
+	if (!IS_ERR(pcm512x->sclk))
+		return clk_get_rate(pcm512x->sclk);
+	else
+		return pcm512x->sysclk;
+}
+
+static int pcm512x_set_sysclk(struct snd_soc_dai *dai,
+			      int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = dai->component;
+	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
+
+	switch (freq) {
+	case 22579200:
+	case 24576000:
+		pcm512x->sysclk = freq;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static int pcm512x_dai_startup_master(struct snd_pcm_substream *substream,
 				      struct snd_soc_dai *dai)
 {
@@ -528,7 +552,7 @@ static int pcm512x_dai_startup_master(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_constraint_ratnums *constraints_no_pll;
 	struct snd_ratnum *rats_no_pll;
 
-	if (IS_ERR(pcm512x->sclk)) {
+	if (IS_ERR(pcm512x->sclk) && !pcm512x->sysclk) {
 		dev_err(dev, "Need SCLK for master mode: %ld\n",
 			PTR_ERR(pcm512x->sclk));
 		return PTR_ERR(pcm512x->sclk);
@@ -551,7 +575,7 @@ static int pcm512x_dai_startup_master(struct snd_pcm_substream *substream,
 	if (!rats_no_pll)
 		return -ENOMEM;
 	constraints_no_pll->rats = rats_no_pll;
-	rats_no_pll->num = clk_get_rate(pcm512x->sclk) / 64;
+	rats_no_pll->num = sclk_get_rate(pcm512x) / 64;
 	rats_no_pll->den_min = 1;
 	rats_no_pll->den_max = 128;
 	rats_no_pll->den_step = 1;
@@ -858,7 +882,7 @@ static int pcm512x_set_dividers(struct snd_soc_dai *dai,
 	}
 
 	if (!pcm512x->pll_out) {
-		sck_rate = clk_get_rate(pcm512x->sclk);
+		sck_rate = sclk_get_rate(pcm512x);
 		bclk_div = params->rate_den * 64 / lrclk_div;
 		bclk_rate = DIV_ROUND_CLOSEST(sck_rate, bclk_div);
 
@@ -875,7 +899,7 @@ static int pcm512x_set_dividers(struct snd_soc_dai *dai,
 		}
 		bclk_rate = ret;
 
-		pllin_rate = clk_get_rate(pcm512x->sclk);
+		pllin_rate = sclk_get_rate(pcm512x);
 
 		sck_rate = pcm512x_find_sck(dai, bclk_rate);
 		if (!sck_rate)
@@ -1323,6 +1347,7 @@ static const struct snd_soc_dai_ops pcm512x_dai_ops = {
 	.startup = pcm512x_dai_startup,
 	.hw_params = pcm512x_hw_params,
 	.set_fmt = pcm512x_set_fmt,
+	.set_sysclk = pcm512x_set_sysclk,
 };
 
 static struct snd_soc_dai_driver pcm512x_dai = {
-- 
2.14.1
