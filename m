From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/6] ASoC: sigmadsp: Drop support support
	SIGMA_ACTION_DELAY
Date: Wed, 19 Nov 2014 18:29:04 +0100
Message-ID: <1416418148-14803-3-git-send-email-lars@metafoo.de>
References: <1416418148-14803-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-042.synserver.de (smtp-out-042.synserver.de
 [212.40.185.42])
 by alsa0.perex.cz (Postfix) with ESMTP id DD2F926062A
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 18:29:09 +0100 (CET)
In-Reply-To: <1416418148-14803-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The official firmware generation tool never emitted any SIGMA_ACTION_DELAY
instructions. Keeping support for it with the new restructured loader that
also supports v2 will be difficult, so drop support for it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sigmadsp.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index 81a38dd..4fd3143 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/crc32.h>
-#include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/kernel.h>
 #include <linux/i2c.h>
@@ -28,9 +27,6 @@ enum {
 	SIGMA_ACTION_WRITEXBYTES = 0,
 	SIGMA_ACTION_WRITESINGLE,
 	SIGMA_ACTION_WRITESAFELOAD,
-	SIGMA_ACTION_DELAY,
-	SIGMA_ACTION_PLLWAIT,
-	SIGMA_ACTION_NOOP,
 	SIGMA_ACTION_END,
 };
 
@@ -79,10 +75,6 @@ process_sigma_action(struct sigma_firmware *ssfw, struct sigma_action *sa)
 		if (ret < 0)
 			return -EINVAL;
 		break;
-	case SIGMA_ACTION_DELAY:
-		udelay(len);
-		len = 0;
-		break;
 	case SIGMA_ACTION_END:
 		return 0;
 	default:
-- 
1.8.0
