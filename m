From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mxs-saif: Handle return value of clk_prepare_enable/clk_prepare." to the asoc tree
Date: Wed, 26 Jul 2017 15:16:57 +0100
Message-ID: <E1daN7R-0003UE-4D@debutante>
References: <1500977674-27960-7-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500977674-27960-7-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.combroonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mxs-saif: Handle return value of clk_prepare_enable/clk_prepare.

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

>From 0d97ee867958a092f02e9cd7c865c278bcec18a6 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 25 Jul 2017 15:44:33 +0530
Subject: [PATCH] ASoC: mxs-saif: Handle return value of
 clk_prepare_enable/clk_prepare.

clk_prepare_enable() and clk_prepare() can fail here and
we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mxs/mxs-saif.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index b42f301c6b96..156aa7c00787 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -125,7 +125,9 @@ static int mxs_saif_set_clk(struct mxs_saif *saif,
 	 *
 	 * If MCLK is not used, we just set saif clk to 512*fs.
 	 */
-	clk_prepare_enable(master_saif->clk);
+	ret = clk_prepare_enable(master_saif->clk);
+	if (ret)
+		return ret;
 
 	if (master_saif->mclk_in_use) {
 		switch (mclk / rate) {
@@ -388,6 +390,7 @@ static int mxs_saif_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *cpu_dai)
 {
 	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret;
 
 	/* clear error status to 0 for each re-open */
 	saif->fifo_underrun = 0;
@@ -401,7 +404,9 @@ static int mxs_saif_startup(struct snd_pcm_substream *substream,
 	__raw_writel(BM_SAIF_CTRL_CLKGATE,
 		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
 
-	clk_prepare(saif->clk);
+	ret = clk_prepare(saif->clk);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -468,7 +473,9 @@ static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
 		if (ret)
 			return ret;
 
-		clk_prepare(master_saif->clk);
+		ret = clk_prepare(master_saif->clk);
+		if (ret)
+			return ret;
 	}
 
 	scr = __raw_readl(saif->base + SAIF_CTRL);
-- 
2.13.2
