From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: Fix error handling if of_clk_get() fails" to the asoc tree
Date: Sun, 30 Apr 2017 21:58:24 +0900
Message-ID: <E1d4oQi-00044Z-E9@finisterre>
References: <20170428132210.jvjrltku25sepivw@mwanda>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170428132210.jvjrltku25sepivw@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Arnaud POULIQUEN <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.orgArnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: Fix error handling if of_clk_get() fails

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

>From 65ed0a8d1f24abd79be149253025de8949321900 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 28 Apr 2017 16:22:10 +0300
Subject: [PATCH] ASoC: sti: Fix error handling if of_clk_get() fails

We intended to return here.  The current code has a static checker
warning because we set "ret" but don't use it.

Fixes: 76c2145ded6b ("ASoC: sti: Add CPU DAI driver for playback")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index d7e8dd46d2cc..d8b6936e544e 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -1074,7 +1074,7 @@ int uni_player_init(struct platform_device *pdev,
 	player->clk = of_clk_get(pdev->dev.of_node, 0);
 	if (IS_ERR(player->clk)) {
 		dev_err(player->dev, "Failed to get clock\n");
-		ret = PTR_ERR(player->clk);
+		return PTR_ERR(player->clk);
 	}
 
 	/* Select the frequency synthesizer clock */
-- 
2.11.0

