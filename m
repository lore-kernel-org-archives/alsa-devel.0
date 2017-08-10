From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: fsi: Delete an error message for a
 failed memory allocation in fsi_probe()
Date: Thu, 10 Aug 2017 18:23:19 +0200
Message-ID: <c78da5a0-fd60-b9fd-7607-51995c1fee8c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 5468C2675CA
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 18:23:41 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 10 Aug 2017 18:18:20 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/sh/fsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 005b21506556..1f41cf1ff830 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1962,10 +1962,8 @@ static int fsi_probe(struct platform_device *pdev)
 	}
 
 	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
-	if (!master) {
-		dev_err(&pdev->dev, "Could not allocate master\n");
+	if (!master)
 		return -ENOMEM;
-	}
 
 	master->base = devm_ioremap_nocache(&pdev->dev,
 					    res->start, resource_size(res));
-- 
2.14.0
