From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 4/4] ASoC: fsl_ssi: Use 'const _be *' type for
	iprop
Date: Sun, 11 Feb 2018 19:53:21 -0200
Message-ID: <1518386001-4322-4-git-send-email-festevam@gmail.com>
References: <1518386001-4322-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 15800267232
 for <alsa-devel@alsa-project.org>; Sun, 11 Feb 2018 22:53:57 +0100 (CET)
Received: by mail-qk0-f196.google.com with SMTP id h186so4185288qke.8
 for <alsa-devel@alsa-project.org>; Sun, 11 Feb 2018 13:53:57 -0800 (PST)
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

sound/soc/fsl/fsl_ssi.c:1463:48: warning: incorrect type in argument 1 (different base types)
sound/soc/fsl/fsl_ssi.c:1463:48:    expected restricted __be32 const [usertype] *p
sound/soc/fsl/fsl_ssi.c:1463:48:    got unsigned int const [usertype] *[assigned] iprop

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index aecd00f..24fb672 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1377,7 +1377,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *of_id;
 	const char *p, *sprop;
-	const uint32_t *iprop;
+	const __be32 *iprop;
 	struct resource *res;
 	void __iomem *iomem;
 	char name[64];
-- 
2.7.4
