From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] ASOC: atmel-pdmic: Simplify use of devm_ioremap_resource
Date: Mon, 4 Jul 2016 18:37:06 +0530
Message-ID: <20160704130706.GA16942@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: alsa-devel@alsa-project.org

Remove unneeded error handling on the result of a call to
platform_get_resource when the value is passed to
devm_ioremap_resource.

The Coccinelle semantic patch that makes this change is as follows:

// <smpl>
@@
expression pdev,res,n,e,e1;
expression ret != 0;
identifier l;
@@

- res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  ... when != res
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  ... when != res
+ res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  e = devm_ioremap_resource(e1, res);
// </smpl>

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 sound/soc/atmel/atmel-pdmic.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index aee4787..5f56da6 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -624,11 +624,6 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "no memory resource\n");
-		return -ENXIO;
-	}
-
 	io_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(io_base)) {
 		ret = PTR_ERR(io_base);
-- 
1.9.1
