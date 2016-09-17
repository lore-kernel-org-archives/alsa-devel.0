From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: sti: fix missing clk_disable_unprepare() on error in uni_player_start()
Date: Sat, 17 Sep 2016 01:34:33 +0000
Message-ID: <1474076073-9569-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Moise Gergaud <moise.gergaud@st.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix the missing clk_disable_unprepare() before return
from uni_player_start() in the error handling case.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/sti/uniperif_player.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 645e415..1bc8ebc 100644
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
