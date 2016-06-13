From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: fix return value check in uni_player_parse_dt_audio_glue()" to the asoc tree
Date: Mon, 13 Jun 2016 16:47:33 +0100
Message-ID: <E1bCU5N-0002ww-Az@finisterre>
References: <1465828797-17628-1-git-send-email-weiyj_lk@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465828797-17628-1-git-send-email-weiyj_lk@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: fix return value check in uni_player_parse_dt_audio_glue()

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

>From 7d267ddfd560da3232f4deed3427839dd0126a4a Mon Sep 17 00:00:00 2001
From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Date: Mon, 13 Jun 2016 14:39:57 +0000
Subject: [PATCH] ASoC: sti: fix return value check in
 uni_player_parse_dt_audio_glue()

In case of error, the function syscon_regmap_lookup_by_phandle() returns
ERR_PTR() and never returns NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index ee1c7c245bc7..1ac2db205a0d 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -1029,9 +1029,9 @@ static int uni_player_parse_dt_audio_glue(struct platform_device *pdev,
 
 	regmap = syscon_regmap_lookup_by_phandle(node, "st,syscfg");
 
-	if (!regmap) {
+	if (IS_ERR(regmap)) {
 		dev_err(&pdev->dev, "sti-audio-clk-glue syscf not found\n");
-		return -EINVAL;
+		return PTR_ERR(regmap);
 	}
 
 	player->clk_sel = regmap_field_alloc(regmap, regfield[0]);
-- 
2.8.1
