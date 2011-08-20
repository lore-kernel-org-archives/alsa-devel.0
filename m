From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 1/2] sound/soc/fsl/p1022_ds.c: add missing
	of_node_put
Date: Sat, 20 Aug 2011 09:02:00 +0200
Message-ID: <1313823721-16930-1-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 15A4E24770
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 09:02:09 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Axel Lin <axel.lin@gmail.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

dma_channel_np has been accessed at this point, so decrease its reference
count before leaving the function.

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
if (...) { ... when != of_node_put(x)
               when != x = E3
               when != E3 = x
*  return ...;
 }
... when != x = E2
    when != I(...,x,...) S
if (...) { ... when != x = E4
 of_node_put(x); ... return ...; }
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/soc/fsl/p1022_ds.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 8fa4d5f..fcb862e 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -297,8 +297,10 @@ static int get_dma_channel(struct device_node *ssi_np,
 	 * dai->platform name should already point to an allocated buffer.
 	 */
 	ret = of_address_to_resource(dma_channel_np, 0, &res);
-	if (ret)
+	if (ret) {
+		of_node_put(dma_channel_np);
 		return ret;
+	}
 	snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%s",
 		 (unsigned long long) res.start, dma_channel_np->name);
 
