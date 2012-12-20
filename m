From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs42l52: Catch no-match case in
	cs42l52_get_clk
Date: Thu, 20 Dec 2012 16:53:16 +0800
Message-ID: <1355993596.20315.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id DAFF6265182
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 09:53:25 +0100 (CET)
Received: by mail-pa0-f52.google.com with SMTP id fb1so1924549pad.11
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 00:53:24 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

In the case of no-match, return -EINVAL instead of 0.

Since we assign i to ret in the for loop, ret always less than
ARRAY_SIZE(clk_map_table). Thus remove the boundary checking for ret.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l52.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 99bb1c6..9811a54 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -737,7 +737,7 @@ static const struct cs42l52_clk_para clk_map_table[] = {
 
 static int cs42l52_get_clk(int mclk, int rate)
 {
-	int i, ret = 0;
+	int i, ret = -EINVAL;
 	u_int mclk1, mclk2 = 0;
 
 	for (i = 0; i < ARRAY_SIZE(clk_map_table); i++) {
@@ -749,8 +749,6 @@ static int cs42l52_get_clk(int mclk, int rate)
 			}
 		}
 	}
-	if (ret > ARRAY_SIZE(clk_map_table))
-		return -EINVAL;
 	return ret;
 }
 
-- 
1.7.9.5
