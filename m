From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: wm8962: Disable clock if
	wm8962_runtime_resume() fails
Date: Mon, 28 Mar 2016 08:31:18 -0300
Message-ID: <1459164679-17961-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com
 [209.85.192.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D39D2657B3
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 13:31:44 +0200 (CEST)
Received: by mail-qg0-f42.google.com with SMTP id j35so106047188qge.0
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 04:31:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, ckeepax@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

When regulator_bulk_enable() fails inside wm8962_runtime_resume(),
we should disable the previously enabled clock.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/wm8962.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 8822360..f3f71ba 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3800,7 +3800,7 @@ static int wm8962_runtime_resume(struct device *dev)
 	if (ret != 0) {
 		dev_err(dev,
 			"Failed to enable supplies: %d\n", ret);
-		return ret;
+		goto disable_clock;
 	}
 
 	regcache_cache_only(wm8962->regmap, false);
@@ -3838,6 +3838,10 @@ static int wm8962_runtime_resume(struct device *dev)
 	msleep(5);
 
 	return 0;
+
+disable_clock:
+	clk_disable_unprepare(wm8962->pdata.mclk);
+	return ret;
 }
 
 static int wm8962_runtime_suspend(struct device *dev)
-- 
1.9.1
