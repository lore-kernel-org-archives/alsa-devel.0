From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/4] ASoC: fsl_utils: Use 'const _be *' type
	for iprop
Date: Sun, 11 Feb 2018 19:53:20 -0200
Message-ID: <1518386001-4322-3-git-send-email-festevam@gmail.com>
References: <1518386001-4322-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id C6E742670AE
 for <alsa-devel@alsa-project.org>; Sun, 11 Feb 2018 22:53:55 +0100 (CET)
Received: by mail-qk0-f195.google.com with SMTP id h186so4185227qke.8
 for <alsa-devel@alsa-project.org>; Sun, 11 Feb 2018 13:53:55 -0800 (PST)
In-Reply-To: <1518386001-4322-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The 'iprop' variable is passed as an argument to the be32_to_cpup()
function, which expects a 'const _be *' type.

Change the iprop variable type so that the following build warnings
with W=1 are gone:

sound/soc/fsl/fsl_utils.c:72:40: warning: incorrect type in argument 1 (different base types)
sound/soc/fsl/fsl_utils.c:72:40:    expected restricted __be32 const [usertype] *p
sound/soc/fsl/fsl_utils.c:72:40:    got unsigned int const [usertype] *[assigned] iprop
sound/soc/fsl/fsl_utils.c:80:32: warning: incorrect type in argument 1 (different base types)
sound/soc/fsl/fsl_utils.c:80:32:    expected restricted __be32 const [usertype] *p
sound/soc/fsl/fsl_utils.c:80:32:    got unsigned int const [usertype] *[assigned] iprop

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index b9e42b5..7592b04 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -36,7 +36,7 @@ int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
 {
 	struct resource res;
 	struct device_node *dma_channel_np, *dma_np;
-	const u32 *iprop;
+	const __be32 *iprop;
 	int ret;
 
 	dma_channel_np = of_parse_phandle(ssi_np, name, 0);
-- 
2.7.4
