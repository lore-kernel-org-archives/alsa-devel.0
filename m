From: Julia Lawall <julia@diku.dk>
Subject: [PATCH] sound/soc/fsl/fsl_dma.c: add missing
	of_node_put
Date: Sat, 20 Aug 2011 09:23:45 +0200
Message-ID: <1313825025-17590-1-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D16524776
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 09:23:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

of_parse_phandle increments the reference count of np, so this should be
decremented before trying the next possibility.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,e1,e2;
@@

*e = of_parse_phandle(...)
... when != of_node_put(e)
    when != true e == NULL
    when != e2 = e
e = e1
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/soc/fsl/fsl_dma.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 0efc04a..b33271b 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -880,10 +880,12 @@ static struct device_node *find_ssi_node(struct device_node *dma_channel_np)
 		np = of_parse_phandle(ssi_np, "fsl,playback-dma", 0);
 		if (np == dma_channel_np)
 			return ssi_np;
+		of_node_put(np);
 
 		np = of_parse_phandle(ssi_np, "fsl,capture-dma", 0);
 		if (np == dma_channel_np)
 			return ssi_np;
+		of_node_put(np);
 	}
 
 	return NULL;
