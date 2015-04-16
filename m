From: weiyj_lk@163.com
Subject: [PATCH -next] ASoC: cs35l32: Remove unused including
	<linux/version.h>
Date: Thu, 16 Apr 2015 21:07:45 +0800
Message-ID: <1429189665-23710-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B639261484
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 15:07:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove including <linux/version.h> that don't need it.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/cs35l32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 60598b2..8f40025 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -13,7 +13,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
