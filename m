From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt286: Fix sync function
Date: Fri, 26 Sep 2014 11:06:40 +0800
Message-ID: <1411700800-1082-2-git-send-email-bardliao@realtek.com>
References: <1411700800-1082-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 951E7260452
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 05:07:07 +0200 (CEST)
In-Reply-To: <1411700800-1082-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We try to write index registers into cache when we write an index
register, but we change the reg value before updating the cache.
As a result, the cache is never be updated. This patch will fix
this issue.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 7a66084..b86b426 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -191,7 +191,6 @@ static int rt286_hw_write(void *context, unsigned int reg, unsigned int value)
 	/*handle index registers*/
 	if (reg <= 0xff) {
 		rt286_hw_write(client, RT286_COEF_INDEX, reg);
-		reg = RT286_PROC_COEF;
 		for (i = 0; i < INDEX_CACHE_SIZE; i++) {
 			if (reg == rt286->index_cache[i].reg) {
 				rt286->index_cache[i].def = value;
@@ -199,6 +198,7 @@ static int rt286_hw_write(void *context, unsigned int reg, unsigned int value)
 			}
 
 		}
+		reg = RT286_PROC_COEF;
 	}
 
 	data[0] = (reg >> 24) & 0xff;
-- 
1.8.1.1.439.g50a6b54
