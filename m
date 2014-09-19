From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: Fix sync function
Date: Fri, 19 Sep 2014 10:16:19 +0800
Message-ID: <1411092979-19260-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C9CE426557A
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 04:16:53 +0200 (CEST)
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
this issue and also correct some incorrect default value in the
cache.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 7dfca82..8ad4b24 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -51,7 +51,7 @@ static struct reg_default rt286_index_def[] = {
 	{ 0x04, 0xaf01 },
 	{ 0x08, 0x000d },
 	{ 0x09, 0xd810 },
-	{ 0x0a, 0x0060 },
+	{ 0x0a, 0x0120 },
 	{ 0x0b, 0x0000 },
 	{ 0x0d, 0x2800 },
 	{ 0x0f, 0x0000 },
@@ -60,7 +60,7 @@ static struct reg_default rt286_index_def[] = {
 	{ 0x33, 0x0208 },
 	{ 0x49, 0x0004 },
 	{ 0x4f, 0x50e9 },
-	{ 0x50, 0x2c00 },
+	{ 0x50, 0x2000 },
 	{ 0x63, 0x2902 },
 	{ 0x67, 0x1111 },
 	{ 0x68, 0x1016 },
@@ -104,7 +104,6 @@ static const struct reg_default rt286_reg[] = {
 	{ 0x02170700, 0x00000000 },
 	{ 0x02270100, 0x00000000 },
 	{ 0x02370100, 0x00000000 },
-	{ 0x02040000, 0x00004002 },
 	{ 0x01870700, 0x00000020 },
 	{ 0x00830000, 0x000000c3 },
 	{ 0x00930000, 0x000000c3 },
@@ -192,7 +191,6 @@ static int rt286_hw_write(void *context, unsigned int reg, unsigned int value)
 	/*handle index registers*/
 	if (reg <= 0xff) {
 		rt286_hw_write(client, RT286_COEF_INDEX, reg);
-		reg = RT286_PROC_COEF;
 		for (i = 0; i < INDEX_CACHE_SIZE; i++) {
 			if (reg == rt286->index_cache[i].reg) {
 				rt286->index_cache[i].def = value;
@@ -200,6 +198,7 @@ static int rt286_hw_write(void *context, unsigned int reg, unsigned int value)
 			}
 
 		}
+		reg = RT286_PROC_COEF;
 	}
 
 	data[0] = (reg >> 24) & 0xff;
-- 
1.8.1.1.439.g50a6b54
