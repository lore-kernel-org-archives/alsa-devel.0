From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ASoC: fsl: Fix build problem
Date: Wed, 11 Jun 2014 00:13:52 -0700
Message-ID: <1402470832-24889-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
 [209.85.160.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 561CC2654A7
 for <alsa-devel@alsa-project.org>; Wed, 11 Jun 2014 09:19:53 +0200 (CEST)
Received: by mail-pb0-f44.google.com with SMTP id rq2so7164806pbb.3
 for <alsa-devel@alsa-project.org>; Wed, 11 Jun 2014 00:19:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linuxppc-dev@lists.ozlabs.org
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

Commit 432481220 (ASoC: fsl-ssi: Use regmap) removed struct ccsr_ssi.
Unfortunately, the structure is still used. This causes
mpc85xx_smp_defconfig and mpc85xx_defconfig builds to fail with

sound/soc/fsl/fsl_dma.c:926:50:
  error: invalid use of undefined type 'struct ccsr_ssi'
  dma->ssi_stx_phys = res.start + offsetof(struct ccsr_ssi, stx0);
ound/soc/fsl/fsl_dma.c:927:50:
  error: invalid use of undefined type 'struct ccsr_ssi'
  dma->ssi_srx_phys = res.start + offsetof(struct ccsr_ssi, srx0);

Fix by using constants, similar to original commit.

Cc: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 sound/soc/fsl/fsl_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 6bb0ea5..a609aaf 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -923,8 +923,8 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
 
 	/* Store the SSI-specific information that we need */
-	dma->ssi_stx_phys = res.start + offsetof(struct ccsr_ssi, stx0);
-	dma->ssi_srx_phys = res.start + offsetof(struct ccsr_ssi, srx0);
+	dma->ssi_stx_phys = res.start + CCSR_SSI_STX0;
+	dma->ssi_srx_phys = res.start + CCSR_SSI_SRX0;
 
 	iprop = of_get_property(ssi_np, "fsl,fifo-depth", NULL);
 	if (iprop)
-- 
1.9.1
