From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs42l52: Fix off-by-one boundary
 checking for cs42l52_get_clk()
Date: Sun, 16 Dec 2012 10:11:29 +0800
Message-ID: <1355623889.9994.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EA05261680
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2012 03:11:41 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id ro12so2876887pbb.38
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2012 18:11:40 -0800 (PST)
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

The caller uses the return value of cs42l52_get_clk as array index,
the valid array index is 0 .. ARRAY_SIZE(clk_map_table) - 1.
Thus we need to ensure ret is less than ARRAY_SIZE(clk_map_table).

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l52.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 99bb1c6..66817f6 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -749,7 +749,7 @@ static int cs42l52_get_clk(int mclk, int rate)
 			}
 		}
 	}
-	if (ret > ARRAY_SIZE(clk_map_table))
+	if (ret >= ARRAY_SIZE(clk_map_table))
 		return -EINVAL;
 	return ret;
 }
-- 
1.7.9.5
