From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: minor corrections for uniplayer"
	to the asoc tree
Date: Thu, 16 Jul 2015 22:01:30 +0100
Message-ID: <E1ZFqHa-0001jZ-7O@finisterre>
References: <1437039367-30842-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C0356266702
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:01:37 +0200 (CEST)
In-Reply-To: <1437039367-30842-2-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: minor corrections for uniplayer

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

>From ed6c75f23383ba4e0fbc935c0b6ab165bc9ff65e Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Thu, 16 Jul 2015 11:36:02 +0200
Subject: [PATCH] ASoC: sti: minor corrections for uniplayer

Minor corrections after code review.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index d66d633..d12d050 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -475,6 +475,7 @@ static int uni_player_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *player = priv->dai_data.uni;
+	int ret;
 
 	if (dir == SND_SOC_CLOCK_IN)
 		return 0;
@@ -482,9 +483,11 @@ static int uni_player_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	if (clk_id != 0)
 		return -EINVAL;
 
-	player->mclk = freq;
+	ret = clk_set_rate(player->clk, freq);
+	if (!ret)
+		player->mclk = freq;
 
-	return clk_set_rate(player->clk, freq);
+	return ret;
 }
 
 static int uni_player_prepare(struct snd_pcm_substream *substream,
@@ -562,6 +565,7 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 	case SND_SOC_DAIFMT_IB_IF:
 		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(player);
 		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(player);
+		break;
 	}
 
 	switch (player->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -840,7 +844,7 @@ int uni_player_init(struct platform_device *pdev,
 	/* Get uniperif resource */
 	player->clk = of_clk_get(pdev->dev.of_node, 0);
 	if (IS_ERR(player->clk))
-		ret = (int)PTR_ERR(player->clk);
+		ret = PTR_ERR(player->clk);
 
 	/* Select the frequency synthesizer clock */
 	if (player->clk_sel) {
-- 
2.1.4
