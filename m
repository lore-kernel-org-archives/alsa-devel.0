From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: jz4740: Handle return value of clk_prepare_enable." to the asoc tree
Date: Wed, 26 Jul 2017 15:16:54 +0100
Message-ID: <E1daN7O-0003TF-0C@debutante>
References: <1500977674-27960-8-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500977674-27960-8-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.combroonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: jz4740: Handle return value of clk_prepare_enable.

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From eae37345c8653a3c797c1763c95289d924ee37a2 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 25 Jul 2017 15:44:34 +0530
Subject: [PATCH] ASoC: jz4740: Handle return value of clk_prepare_enable.

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/jz4740/jz4740-i2s.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 794a3499e567..99394c036998 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -133,6 +133,7 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf, ctrl;
+	int ret;
 
 	if (dai->active)
 		return 0;
@@ -141,7 +142,9 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	ctrl |= JZ_AIC_CTRL_FLUSH;
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
 
-	clk_prepare_enable(i2s->clk_i2s);
+	ret = clk_prepare_enable(i2s->clk_i2s);
+	if (ret)
+		return ret;
 
 	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
 	conf |= JZ_AIC_CONF_ENABLE;
@@ -352,11 +355,18 @@ static int jz4740_i2s_resume(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf;
+	int ret;
 
-	clk_prepare_enable(i2s->clk_aic);
+	ret = clk_prepare_enable(i2s->clk_aic);
+	if (ret)
+		return ret;
 
 	if (dai->active) {
-		clk_prepare_enable(i2s->clk_i2s);
+		ret = clk_prepare_enable(i2s->clk_i2s);
+		if (ret) {
+			clk_disable_unprepare(i2s->clk_aic);
+			return ret;
+		}
 
 		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
 		conf |= JZ_AIC_CONF_ENABLE;
@@ -387,8 +397,11 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf;
+	int ret;
 
-	clk_prepare_enable(i2s->clk_aic);
+	ret = clk_prepare_enable(i2s->clk_aic);
+	if (ret)
+		return ret;
 
 	jz4740_i2c_init_pcm_config(i2s);
 	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
-- 
2.13.2
