From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] ASoC: SPEAr: Convert to use
	devm_ioremap_resource
Date: Mon, 24 Aug 2015 16:52:30 +0800
Message-ID: <1440406350.27868.5.camel@ingics.com>
References: <1440406056.27868.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FEB3260471
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 10:52:35 +0200 (CEST)
Received: by pdob1 with SMTP id b1so51059357pdo.2
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 01:52:34 -0700 (PDT)
In-Reply-To: <1440406056.27868.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Thomas =?ISO-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
List-Id: alsa-devel@alsa-project.org

Use devm_ioremap_resource() instead of open code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/spear/spdif_in.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index a402860..977a078 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -203,35 +203,25 @@ static int spdif_in_probe(struct platform_device *pdev)
 	struct spdif_in_dev *host;
 	struct spear_spdif_platform_data *pdata;
 	struct resource *res, *res_fifo;
+	void __iomem *io_base;
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
+	io_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
 
 	res_fifo = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res_fifo)
 		return -EINVAL;
 
-	if (!devm_request_mem_region(&pdev->dev, res->start,
-				resource_size(res), pdev->name)) {
-		dev_warn(&pdev->dev, "Failed to get memory resourse\n");
-		return -ENOENT;
-	}
-
 	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
 	if (!host) {
 		dev_warn(&pdev->dev, "kzalloc fail\n");
 		return -ENOMEM;
 	}
 
-	host->io_base = devm_ioremap(&pdev->dev, res->start,
-				resource_size(res));
-	if (!host->io_base) {
-		dev_warn(&pdev->dev, "ioremap failed\n");
-		return -ENOMEM;
-	}
-
+	host->io_base = io_base;
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0)
 		return -EINVAL;
-- 
2.1.0
