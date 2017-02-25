From: Cristian Done <done.cristian@gmail.com>
Subject: [PATCH] ASoC: sh: Remove redundant out of memory
	message
Date: Sat, 25 Feb 2017 12:16:29 +0200
Message-ID: <20170225101629.12694-1-done.cristian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id EE4E6266AFA
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 11:16:47 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id r18so6334358wmd.3
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 02:16:47 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com
Cc: Cristian Done <done.cristian@gmail.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Cristian Done <done.cristian@gmail.com>
---
 sound/soc/sh/fsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index ead520182e26..6793dc359114 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1964,7 +1964,6 @@ static int fsi_probe(struct platform_device *pdev)
 
 	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
 	if (!master) {
-		dev_err(&pdev->dev, "Could not allocate master\n");
 		return -ENOMEM;
 	}
 
-- 
2.11.0
