From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Add recalc_rate function to
	return DAI clock rate" to the asoc tree
Date: Wed,  9 Jan 2019 18:15:17 +0000 (GMT)
Message-ID: <20190109181517.343F61127528@debutante.sirena.org.uk>
References: <ef671ed1c4a5b86036da5b2adf5be7d79ec56c7d.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AD7F26743A
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 19:15:20 +0100 (CET)
In-Reply-To: <ef671ed1c4a5b86036da5b2adf5be7d79ec56c7d.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
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

   ASoC: da7219: Add recalc_rate function to return DAI clock rate

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

>From a58943abcb08cfbe6c36648602d796c5834ee8a9 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 8 Jan 2019 09:13:28 +0000
Subject: [PATCH] ASoC: da7219: Add recalc_rate function to return DAI clock
 rate

By making MCLK parent of DAI clocks, when querying the rate of the
clock the rate returned is now given from the parent clock so
gives the MCLK rate rather than 0 as previously returned. This is
a bit misleading, and actually there's no major reason why we can't
at least return the DAI WCLK rate, as set in HW, so that's what we
now do.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 45 ++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/da7219.h |  1 +
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index a20a610c7ee5..b1df4bb36105 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1767,7 +1767,7 @@ static int da7219_dai_clks_prepare(struct clk_hw *hw)
 {
 	struct da7219_priv *da7219 =
 		container_of(hw, struct da7219_priv, dai_clks_hw);
-	struct snd_soc_component *component = da7219->aad->component;
+	struct snd_soc_component *component = da7219->component;
 
 	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
 				      DA7219_DAI_CLK_EN_MASK,
@@ -1780,7 +1780,7 @@ static void da7219_dai_clks_unprepare(struct clk_hw *hw)
 {
 	struct da7219_priv *da7219 =
 		container_of(hw, struct da7219_priv, dai_clks_hw);
-	struct snd_soc_component *component = da7219->aad->component;
+	struct snd_soc_component *component = da7219->component;
 
 	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
 				      DA7219_DAI_CLK_EN_MASK, 0);
@@ -1790,7 +1790,7 @@ static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
 {
 	struct da7219_priv *da7219 =
 		container_of(hw, struct da7219_priv, dai_clks_hw);
-	struct snd_soc_component *component = da7219->aad->component;
+	struct snd_soc_component *component = da7219->component;
 	u8 clk_reg;
 
 	clk_reg = snd_soc_component_read32(component, DA7219_DAI_CLK_MODE);
@@ -1798,10 +1798,47 @@ static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
 	return !!(clk_reg & DA7219_DAI_CLK_EN_MASK);
 }
 
+static unsigned long da7219_dai_clks_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct da7219_priv *da7219 =
+		container_of(hw, struct da7219_priv, dai_clks_hw);
+	struct snd_soc_component *component = da7219->component;
+	u8 fs = snd_soc_component_read32(component, DA7219_SR);
+
+	switch (fs & DA7219_SR_MASK) {
+	case DA7219_SR_8000:
+		return 8000;
+	case DA7219_SR_11025:
+		return 11025;
+	case DA7219_SR_12000:
+		return 12000;
+	case DA7219_SR_16000:
+		return 16000;
+	case DA7219_SR_22050:
+		return 22050;
+	case DA7219_SR_24000:
+		return 24000;
+	case DA7219_SR_32000:
+		return 32000;
+	case DA7219_SR_44100:
+		return 44100;
+	case DA7219_SR_48000:
+		return 48000;
+	case DA7219_SR_88200:
+		return 88200;
+	case DA7219_SR_96000:
+		return 96000;
+	default:
+		return 0;
+	}
+}
+
 static const struct clk_ops da7219_dai_clks_ops = {
 	.prepare = da7219_dai_clks_prepare,
 	.unprepare = da7219_dai_clks_unprepare,
 	.is_prepared = da7219_dai_clks_is_prepared,
+	.recalc_rate = da7219_dai_clks_recalc_rate,
 };
 
 static int da7219_register_dai_clks(struct snd_soc_component *component)
@@ -1825,6 +1862,7 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 
 	init.name = pdata->dai_clks_name;
 	init.ops = &da7219_dai_clks_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
 	da7219->dai_clks_hw.init = &init;
 
 	dai_clks = devm_clk_register(dev, &da7219->dai_clks_hw);
@@ -1912,6 +1950,7 @@ static int da7219_probe(struct snd_soc_component *component)
 	unsigned int rev;
 	int ret;
 
+	da7219->component = component;
 	mutex_init(&da7219->ctrl_lock);
 	mutex_init(&da7219->pll_lock);
 
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 3a006862f0e7..366cf46118a0 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -809,6 +809,7 @@ struct da7219_aad_priv;
 
 /* Private data */
 struct da7219_priv {
+	struct snd_soc_component *component;
 	struct da7219_aad_priv *aad;
 	struct da7219_pdata *pdata;
 
-- 
2.20.1
