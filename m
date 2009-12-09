From: jassisinghbrar@gmail.com
Subject: [PATCH 7/7] ASoC: S3C24XX: Remove I2Sv3 specific check
Date: Wed,  9 Dec 2009 13:30:01 +0900
Message-ID: <1260333001-11565-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id BCE12243B0
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 05:36:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Since, now the I2Sv3 driver itself figures out and provides the start
address of the base register, the s3c64xx specific patch can be
discarded in the I2Sv2 core code.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index e994d83..422b74c 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -628,24 +628,6 @@ int s3c_i2sv2_probe(struct platform_device *pdev,
 	/* record our i2s structure for later use in the callbacks */
 	dai->private_data = i2s;
 
-	if (!base) {
-		struct resource *res = platform_get_resource(pdev,
-							     IORESOURCE_MEM,
-							     0);
-		if (!res) {
-			dev_err(dev, "Unable to get register resource\n");
-			return -ENXIO;
-		}
-
-		if (!request_mem_region(res->start, resource_size(res),
-					"s3c64xx-i2s-v4")) {
-			dev_err(dev, "Unable to request register region\n");
-			return -EBUSY;
-		}
-
-		base = res->start;
-	}
-
 	i2s->regs = ioremap(base, 0x100);
 	if (i2s->regs == NULL) {
 		dev_err(dev, "cannot ioremap registers\n");
-- 
1.6.2.5
