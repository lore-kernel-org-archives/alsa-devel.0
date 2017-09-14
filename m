From: John Keeping <john@metanate.com>
Subject: [PATCH] ASoC: rockchip: i2s: fix unbalanced clk_disable
Date: Thu, 14 Sep 2017 16:58:55 +0100
Message-ID: <20170914155855.28768-1-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metanate.com (dougal.metanate.com [90.155.101.14])
 by alsa0.perex.cz (Postfix) with ESMTP id F1124266986
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 17:59:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, John Keeping <john@metanate.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

mclk is enabled and disabled only in i2s_runtime_{resume,suspend}() and
we ensure that the device is runtime suspended before reaching this
clk_disable_unprepare() call, so it is wrong to call it again here.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index b6590467fd14..908211e1d6fc 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -692,7 +692,6 @@ static int rockchip_i2s_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		i2s_runtime_suspend(&pdev->dev);
 
-	clk_disable_unprepare(i2s->mclk);
 	clk_disable_unprepare(i2s->hclk);
 
 	return 0;
-- 
2.14.1
