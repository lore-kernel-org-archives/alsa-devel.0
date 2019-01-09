From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: MCLK should be enabled before
	DAI clocks" to the asoc tree
Date: Wed,  9 Jan 2019 18:15:19 +0000 (GMT)
Message-ID: <20190109181519.0E7791127528@debutante.sirena.org.uk>
References: <ac23ca274965f4c811c0bbbbfe953589a20610c2.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BEA1267442
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 19:15:21 +0100 (CET)
In-Reply-To: <ac23ca274965f4c811c0bbbbfe953589a20610c2.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Daniel Kurtz <djkurtz@google.com>, Akshu Agrawal <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: MCLK should be enabled before DAI clocks

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a6028cc60aad18d5d7c25d99b5cb8c24399387c3 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 7 Jan 2019 16:11:46 +0000
Subject: [PATCH] ASoC: da7219: MCLK should be enabled before DAI clocks

For platforms using the Common Clock Framework to control the
codec's DAI clocks, MCLK should be enabled prior to DAI clocks
being turned on. For some platforms the codec is already
provided with an MCLK reference and can therefore control MCLK
itself as it needs to.

To improve functionality MCLK is now added as a parent to the
DAI clocks, if MCLK was provided, so that if they are enabled MCLK
will automatically be enabled as a prerequisite by the CCF.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 513ec0368653..a20a610c7ee5 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1804,7 +1804,7 @@ static const struct clk_ops da7219_dai_clks_ops = {
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
2.20.1
