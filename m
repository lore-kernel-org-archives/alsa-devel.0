From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/4] ASoC: fsl_esai: Use 'const _be *' type for
	iprop
Date: Sun, 11 Feb 2018 19:53:19 -0200
Message-ID: <1518386001-4322-2-git-send-email-festevam@gmail.com>
References: <1518386001-4322-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C6F12670AE
 for <alsa-devel@alsa-project.org>; Sun, 11 Feb 2018 22:53:52 +0100 (CET)
Received: by mail-qk0-f196.google.com with SMTP id d72so16352455qkc.6
 for <alsa-devel@alsa-project.org>; Sun, 11 Feb 2018 13:53:52 -0800 (PST)
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

sound/soc/fsl/fsl_esai.c:860:54: warning: incorrect type in argument 1 (different base types)
sound/soc/fsl/fsl_esai.c:860:54:    expected restricted __be32 const [usertype] *p
sound/soc/fsl/fsl_esai.c:860:54:    got unsigned int const [usertype] *[assigned] iprop

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl_esai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index cef79a1..40a7004 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -788,7 +788,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_esai *esai_priv;
 	struct resource *res;
-	const uint32_t *iprop;
+	const __be32 *iprop;
 	void __iomem *regs;
 	int irq, ret;
 
-- 
2.7.4
