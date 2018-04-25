From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Use u32 variable type when
	using regmap_read()
Date: Wed, 25 Apr 2018 19:53:52 -0300
Message-ID: <1524696832-7684-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 79D29267766
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 00:54:09 +0200 (CEST)
Received: by mail-qt0-f195.google.com with SMTP id q13-v6so29068592qtl.3
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 15:54:09 -0700 (PDT)
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

Convert the sisr and sisr2 variable types to u32 to avoid the following
sparse warnings:

sound/soc/fsl/fsl_ssi.c:391:42: warning: incorrect type in argument 3 (different base types)
sound/soc/fsl/fsl_ssi.c:391:42:    expected unsigned int *val
sound/soc/fsl/fsl_ssi.c:391:42:    got restricted __be32 *<noident>
sound/soc/fsl/fsl_ssi.c:393:17: warning: restricted __be32 degrades to integer
sound/soc/fsl/fsl_ssi.c:393:15: warning: incorrect type in assignment (different base types)
sound/soc/fsl/fsl_ssi.c:393:15:    expected restricted __be32 [usertype] sisr2
sound/soc/fsl/fsl_ssi.c:393:15:    got unsigned int
sound/soc/fsl/fsl_ssi.c:396:50: warning: incorrect type in argument 3 (different base types)
sound/soc/fsl/fsl_ssi.c:396:50:    expected unsigned int [unsigned] val
sound/soc/fsl/fsl_ssi.c:396:50:    got restricted __be32 [usertype] sisr2
sound/soc/fsl/fsl_ssi.c:398:42: warning: incorrect type in argument 2 (different base types)
sound/soc/fsl/fsl_ssi.c:398:42:    expected unsigned int [unsigned] [usertype] sisr
sound/soc/fsl/fsl_ssi.c:398:42:    got restricted __be32 [addressable] [usertype] sisr

In other places where regmap_read() is used a u32 variable is passed
to store the register read value, so do the same here as well.

regmap API already takes care of endianness, so the usage of u32 is safe.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl_ssi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 89df2d9..1544166 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -385,8 +385,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 {
 	struct fsl_ssi *ssi = dev_id;
 	struct regmap *regs = ssi->regs;
-	__be32 sisr;
-	__be32 sisr2;
+	u32 sisr, sisr2;
 
 	regmap_read(regs, REG_SSI_SISR, &sisr);
 
-- 
2.7.4
