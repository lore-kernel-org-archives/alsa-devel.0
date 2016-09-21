From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: fix missing clk_disable_unprepare() on error in uni_player_start()" to the asoc tree
Date: Wed, 21 Sep 2016 13:56:17 +0100
Message-ID: <E1bmh4T-0001db-3B@debutante>
References: <1474076073-9569-1-git-send-email-weiyj.lk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474076073-9569-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>Arnaud Pouliquen <arnaud.pouliquen@st.com>, Moise Gergaud <moise.gergaud@st.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: fix missing clk_disable_unprepare() on error in uni_player_start()

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

>From b7c8c5d6927f9e6f3b4c0f8fcc99daa4568ad185 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Sat, 17 Sep 2016 01:34:33 +0000
Subject: [PATCH] ASoC: sti: fix missing clk_disable_unprepare() on error in
 uni_player_start()

Fix the missing clk_disable_unprepare() before return
from uni_player_start() in the error handling case.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 645e4152e6a1..1bc8ebc2528e 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -893,8 +893,10 @@ static int uni_player_start(struct uniperif *player)
 	SET_UNIPERIF_SOFT_RST_SOFT_RST(player);
 
 	ret = reset_player(player);
-	if (ret < 0)
+	if (ret < 0) {
+		clk_disable_unprepare(player->clk);
 		return ret;
+	}
 
 	/*
 	 * Does not use IEC61937 features of the uniperipheral hardware.
-- 
2.8.1
