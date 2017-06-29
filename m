From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ASoC: rsnd: constify dev_pm_ops structures.
Date: Thu, 29 Jun 2017 10:40:50 +0530
Message-ID: <6de23d3755cd8c312f213173338e26de6c319f6d.1498712868.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 445FA26720E
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 07:11:42 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id z6so11604765pfk.3
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 22:11:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, hiroyuki.yokoyama.vx@renesas.com, baoyou.xie@linaro.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

dev_pm_ops are not supposed to change at runtime. All functions
working with dev_pm_ops provided by <linux/device.h> work with const
dev_pm_ops. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   8172	    920	      0	   9092	   2384	sound/soc/sh/rcar/core.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   8364	    728	      0	   9092	   2384	sound/soc/sh/rcar/core.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/sh/rcar/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 1744015..e327436 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1281,7 +1281,7 @@ static int rsnd_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops rsnd_pm_ops = {
+static const struct dev_pm_ops rsnd_pm_ops = {
 	.suspend		= rsnd_suspend,
 	.resume			= rsnd_resume,
 };
-- 
1.9.1
