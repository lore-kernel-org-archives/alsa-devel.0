From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: [PATCH] da7210: Fencepost error in reg cache read
Date: Wed, 14 Apr 2010 17:03:13 +0300
Message-ID: <1271253793-3539-1-git-send-email-ext-phil.2.carmody@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 21A031037FC
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 16:00:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: morimoto.kuninori@renesas.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

An index equal to the array size may not be accessed.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 sound/soc/codecs/da7210.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 366daf1..96932a8 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -165,7 +165,7 @@ static const u8 da7210_reg[] = {
 static inline u32 da7210_read_reg_cache(struct snd_soc_codec *codec, u32 reg)
 {
 	u8 *cache = codec->reg_cache;
-	BUG_ON(reg > ARRAY_SIZE(da7210_reg));
+	BUG_ON(reg >= ARRAY_SIZE(da7210_reg));
 	return cache[reg];
 }
 
-- 
1.6.0.4
