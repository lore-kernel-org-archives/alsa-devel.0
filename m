From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 3/4] sound/soc/mxs/mxs-saif.c: add missing kfree
Date: Sat, 20 Aug 2011 08:12:40 +0200
Message-ID: <1313820761-12042-3-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id AB25224755
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 08:12:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Dong Aisheng <b29396@freescale.com>
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

The error handling code prior to get_clk also needs to call kfree.  The
label name is changed to reflect its more general use.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
expression E1!=0,E2,E3,E4;
statement S;
iterator I;
@@

(
if (...) { ... when != kfree(x)
               when != x = E3
               when != E3 = x
*  return ...;
 }
... when != x = E2
    when != I(...,x,...) S
if (...) { ... when != x = E4
 kfree(x); ... return ...; }
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/soc/mxs/mxs-saif.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 0b3adae..4a17bc8 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -523,8 +523,10 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	if (!saif)
 		return -ENOMEM;
 
-	if (pdev->id >= ARRAY_SIZE(mxs_saif))
-		return -EINVAL;
+	if (pdev->id >= ARRAY_SIZE(mxs_saif)) {
+		ret = -EINVAL;
+		goto failed;
+	}
 	mxs_saif[pdev->id] = saif;
 
 	saif->clk = clk_get(&pdev->dev, NULL);
@@ -532,7 +534,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		ret = PTR_ERR(saif->clk);
 		dev_err(&pdev->dev, "Cannot get the clock: %d\n",
 			ret);
-		goto failed_clk;
+		goto failed;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -625,7 +627,7 @@ failed_ioremap:
 	release_mem_region(res->start, resource_size(res));
 failed_get_resource:
 	clk_put(saif->clk);
-failed_clk:
+failed:
 	kfree(saif);
 
 	return ret;
