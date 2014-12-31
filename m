From: Zidan Wang <b50113@freescale.com>
Subject: [alsa-devel][PATCH 3/4] ASoC: wm8960: use pr_debug instead of pr_err
Date: Wed, 31 Dec 2014 11:39:13 +0800
Message-ID: <1419997154-860-3-git-send-email-b50113@freescale.com>
References: <1419997154-860-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419997154-860-1-git-send-email-b50113@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, ckeepax@opensource.wolfsonmicro.com, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zidan Wang <b50113@freescale.com>
List-Id: alsa-devel@alsa-project.org

In machine driver, we should find a appropriate sysclk for codec driver,
and will use codec set_dai_pll to judge if pll can generate such sysclk.
When sample rate changed, we should look for a useful bclk, lrclk division
ratio, and will try set_dai_pll for several times. So use pr_debug so that
don't generate much error logs.

Signed-off-by: Zidan Wang <b50113@freescale.com>
---
 sound/soc/codecs/wm8960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 86a5489..cb42385 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -914,7 +914,7 @@ static int pll_factors(unsigned int source, unsigned int target,
 		pll_div->pre_div = 0;
 
 	if ((Ndiv < 6) || (Ndiv > 12)) {
-		pr_err("WM8960 PLL: Unsupported N=%d\n", Ndiv);
+		pr_debug("WM8960 PLL: Unsupported N=%d\n", Ndiv);
 		return -EINVAL;
 	}
 
-- 
1.9.1
