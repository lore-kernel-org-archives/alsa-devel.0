From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: Fix the sysclk selection.
Date: Mon, 6 Jan 2014 12:34:36 +0800
Message-ID: <1388982876-20746-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

For spdif there is no need to do the sysclk setting.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 2eb8005..747334c 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -113,12 +113,8 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 				     &dai->sysclk);
 	} else {
 		clk = of_clk_get(*node, 0);
-		if (IS_ERR(clk)) {
-			ret = PTR_ERR(clk);
-			goto parse_error;
-		}
-
-		dai->sysclk = clk_get_rate(clk);
+		if (!IS_ERR(clk))
+			dai->sysclk = clk_get_rate(clk);
 	}
 
 	ret = 0;
-- 
1.8.4
