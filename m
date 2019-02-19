From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/6] ASoC: fsl: Fix of-node refcount unbalance
	in fsl_ssi_probe_from_dt()
Date: Tue, 19 Feb 2019 16:46:47 +0100
Message-ID: <20190219154652.13644-2-tiwai@suse.de>
References: <20190219154652.13644-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2680E265535
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 16:46:53 +0100 (CET)
In-Reply-To: <20190219154652.13644-1-tiwai@suse.de>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

The node obtained from of_find_node_by_path() has to be unreferenced
after the use, but we forgot it for the root node.

Fixes: f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support")
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Only compile-tested.  Please review carefully.  Thanks!

 sound/soc/fsl/fsl_ssi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0a648229e643..09b2967befd9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1439,8 +1439,10 @@ static int fsl_ssi_probe_from_dt(struct fsl_ssi *ssi)
 	 * different name to register the device.
 	 */
 	if (!ssi->card_name[0] && of_get_property(np, "codec-handle", NULL)) {
-		sprop = of_get_property(of_find_node_by_path("/"),
-					"compatible", NULL);
+		struct device_node *root = of_find_node_by_path("/");
+
+		sprop = of_get_property(root, "compatible", NULL);
+		of_node_put(root);
 		/* Strip "fsl," in the compatible name if applicable */
 		p = strrchr(sprop, ',');
 		if (p)
-- 
2.16.4
