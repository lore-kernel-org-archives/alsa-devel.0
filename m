From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt286: Correct default value
Date: Fri, 26 Sep 2014 11:06:39 +0800
Message-ID: <1411700800-1082-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 93804260451
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 05:07:07 +0200 (CEST)
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

This patch corrects some incorrect default value in the cache.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index e4f6102..7a66084 100644
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
-- 
1.8.1.1.439.g50a6b54
