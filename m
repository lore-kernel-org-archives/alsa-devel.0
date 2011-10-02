From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: kirkwood-i2s: Add __devexit_p at
	necessary place
Date: Sun, 02 Oct 2011 09:18:17 +0800
Message-ID: <1317518297.8024.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id AB301246E9
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 03:18:26 +0200 (CEST)
Received: by pzd13 with SMTP id 13so8188078pzd.2
	for <alsa-devel@alsa-project.org>; Sat, 01 Oct 2011 18:18:24 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

According to the comments in include/linux/init.h:

"Pointers to __devexit functions must use __devexit_p(function_name), the
wrapper will insert either the function_name or NULL, depending on the config
options."

We have __devexit annotation for kirkwood_i2s_dev_remove(), thus add __devexit_p
at necessary place.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/kirkwood/kirkwood-i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index d0bcf3f..715e841 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -476,7 +476,7 @@ static __devexit int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 
 static struct platform_driver kirkwood_i2s_driver = {
 	.probe  = kirkwood_i2s_dev_probe,
-	.remove = kirkwood_i2s_dev_remove,
+	.remove = __devexit_p(kirkwood_i2s_dev_remove),
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
-- 
1.7.4.1
