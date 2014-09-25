From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: wm8741: Remove unused wm8741_suspend
	define
Date: Thu, 25 Sep 2014 16:19:30 +0200
Message-ID: <1411654770-6511-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-085.synserver.de (smtp-out-085.synserver.de
 [212.40.185.85])
 by alsa0.perex.cz (Postfix) with ESMTP id A5A8B260411
 for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2014 16:19:32 +0200 (CEST)
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This driver has no suspend callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8741.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index a237f16..31bb480 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -413,7 +413,6 @@ static int wm8741_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 #else
-#define wm8741_suspend NULL
 #define wm8741_resume NULL
 #endif
 
-- 
1.8.0
