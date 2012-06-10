From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] ASoC: lm49453: Remove a unneeded version.h include
Date: Sun, 10 Jun 2012 03:02:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1206100301120.15651@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, trivial@kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 sound/soc/codecs/lm49453.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 802b9f1..c1bc945 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -12,7 +12,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
1.7.10.4


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
