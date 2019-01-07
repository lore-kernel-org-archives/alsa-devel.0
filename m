From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/2] ASoC: da7219: MCLK should be enabled before DAI clocks
Date: Mon, 7 Jan 2019 16:11:46 +0000
Message-ID: <ac23ca274965f4c811c0bbbbfe953589a20610c2.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Akshu Agrawal <Akshu.Agrawal@amd.com>, Daniel Kurtz <djkurtz@google.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

For platforms using the Common Clock Framework to control the
codec's DAI clocks, MCLK should be enabled prior to DAI clocks
being turned on. For some platforms the codec is already
provided with an MCLK reference and can therefore control MCLK
itself as it needs to.

To improve functionality MCLK is now added as a parent to the
DAI clocks, if MCLK was provided, so that if they are enabled MCLK
will automatically be enabled as a prerequisite by the CCF.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index e46e9f4..66dd4c2 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1804,7 +1804,7 @@ static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
 	.is_prepared = da7219_dai_clks_is_prepared,
 };
 
-static void da7219_register_dai_clks(struct snd_soc_component *component)
+static int da7219_register_dai_clks(struct snd_soc_component *component)
 {
 	struct device *dev = component->dev;
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
@@ -1812,9 +1812,17 @@ static void da7219_register_dai_clks(struct snd_soc_component *component)
 	struct clk_init_data init = {};
 	struct clk *dai_clks;
 	struct clk_lookup *dai_clks_lookup;
+	const char *parent_name;
+
+	if (da7219->mclk) {
+		parent_name = __clk_get_name(da7219->mclk);
+		init.parent_names = &parent_name;
+		init.num_parents = 1;
+	} else {
+		init.parent_names = NULL;
+		init.num_parents = 0;
+	}
 
-	init.parent_names = NULL;
-	init.num_parents = 0;
 	init.name = pdata->dai_clks_name;
 	init.ops = &da7219_dai_clks_ops;
 	da7219->dai_clks_hw.init = &init;
@@ -1823,7 +1831,7 @@ static void da7219_register_dai_clks(struct snd_soc_component *component)
 	if (IS_ERR(dai_clks)) {
 		dev_warn(dev, "Failed to register DAI clocks: %ld\n",
 			 PTR_ERR(dai_clks));
-		return;
+		return PTR_ERR(dai_clks);
 	}
 	da7219->dai_clks = dai_clks;
 
@@ -1835,13 +1843,18 @@ static void da7219_register_dai_clks(struct snd_soc_component *component)
 		dai_clks_lookup = clkdev_create(dai_clks, pdata->dai_clks_name,
 						"%s", dev_name(dev));
 		if (!dai_clks_lookup)
-			dev_warn(dev, "Failed to create DAI clkdev");
+			return -ENOMEM;
 		else
 			da7219->dai_clks_lookup = dai_clks_lookup;
 	}
+
+	return 0;
 }
 #else
-static inline void da7219_register_dai_clks(struct snd_soc_component *component) {}
+static inline int da7219_register_dai_clks(struct snd_soc_component *component)
+{
+	return 0;
+}
 #endif /* CONFIG_COMMON_CLK */
 
 static void da7219_handle_pdata(struct snd_soc_component *component)
@@ -1854,8 +1867,6 @@ static void da7219_handle_pdata(struct snd_soc_component *component)
 
 		da7219->wakeup_source = pdata->wakeup_source;
 
-		da7219_register_dai_clks(component);
-
 		/* Mic Bias voltages */
 		switch (pdata->micbias_lvl) {
 		case DA7219_MICBIAS_1_6V:
@@ -1947,6 +1958,11 @@ static int da7219_probe(struct snd_soc_component *component)
 		}
 	}
 
+	/* Register CCF DAI clock control */
+	ret = da7219_register_dai_clks(component);
+	if (ret)
+		return ret;
+
 	/* Default PC counter to free-running */
 	snd_soc_component_update_bits(component, DA7219_PC_COUNT, DA7219_PC_FREERUN_MASK,
 			    DA7219_PC_FREERUN_MASK);
-- 
1.9.1
