From: weiyj_lk@163.com
Subject: [PATCH] ASoC: sti: fix return value check in
	uni_player_parse_dt_audio_glue()
Date: Mon, 13 Jun 2016 14:39:57 +0000
Message-ID: <1465828797-17628-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 31AEE265099
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 16:40:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function syscon_regmap_lookup_by_phandle() returns
ERR_PTR() and never returns NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/sti/uniperif_player.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index ee1c7c2..1ac2db2 100644
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
