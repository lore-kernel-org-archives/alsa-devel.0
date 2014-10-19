From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 2/2] ASoC: fsl: use strncpy() to prevent
	copying of over-long names
Date: Sun, 19 Oct 2014 09:07:36 +0200
Message-ID: <1413702456-8624-3-git-send-email-daniel@zonque.org>
References: <1413702456-8624-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 2850B260513
 for <alsa-devel@alsa-project.org>; Sun, 19 Oct 2014 09:07:44 +0200 (CEST)
In-Reply-To: <1413702456-8624-1-git-send-email-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Use strncpy() instead of strcpy(). That's not a security issue, as the
source buffer is taken from DT nodes, but we should still enforce bound
checks. Spotted by Coverity.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/fsl/fsl_asrc.c | 2 +-
 sound/soc/fsl/fsl_esai.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 8221104..dd00b9d 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -792,7 +792,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	asrc_priv->pdev = pdev;
-	strcpy(asrc_priv->name, np->name);
+	strncpy(asrc_priv->name, np->name, sizeof(asrc_priv->name) - 1);
 
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index a3b29ed..fda1d46 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -729,7 +729,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	esai_priv->pdev = pdev;
-	strcpy(esai_priv->name, np->name);
+	strncpy(esai_priv->name, np->name, sizeof(esai_priv->name) - 1);
 
 	if (of_property_read_bool(np, "big-endian"))
 		fsl_esai_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
-- 
2.1.0
