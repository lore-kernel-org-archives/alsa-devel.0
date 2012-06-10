From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] ASoC: cs42l52: Remove unneeded version.h
	include
Date: Sun, 10 Jun 2012 03:01:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1206100259470.15651@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115]) by alsa0.perex.cz (Postfix) with ESMTP id 3A14B243DC
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Jun 2012 03:01:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Brian Austin <brian.austin@cirrus.com>, trivial@kernel.org, Liam Girdwood <lrg@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 sound/soc/codecs/cs42l52.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index a710941..ec03abc 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -14,7 +14,6 @@
 
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
