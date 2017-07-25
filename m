From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 06/11] ASoC: mxs-saif: Handle return value of clk_prepare_enable/clk_prepare.
Date: Tue, 25 Jul 2017 15:44:33 +0530
Message-ID: <1500977674-27960-7-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

clk_prepare_enable() and clk_prepare() can fail here and
we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/mxs/mxs-saif.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index b42f301..156aa7c 100644
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
1.9.1
