From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH] ASoC: fsl_ssi: Set default slot number for
	common cases
Date: Thu, 9 Jan 2014 17:41:54 +0800
Message-ID: <1389260514-11365-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A1F926529D
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 10:41:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, timur@tabi.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

For those platforms using DAI master mode like I2S, it's better to pre-set
a default slot number so that there's no need for these common cases to set
the slot number from its machine driver any more.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 94dedcb..57ab45b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -711,6 +711,16 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 	if (ssi_private->imx_ac97)
 		fsl_ssi_setup_ac97(ssi_private);
 
+	/* Set a default slot number so that there is no need for those common
+	 * cases like I2S mode to call the extra set_tdm_slot() any more.
+	 */
+	if (!ssi_private->imx_ac97) {
+		write_ssi_mask(&ssi->stccr, CCSR_SSI_SxCCR_DC_MASK,
+				CCSR_SSI_SxCCR_DC(2));
+		write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_DC_MASK,
+				CCSR_SSI_SxCCR_DC(2));
+	}
+
 	return 0;
 }
 
-- 
1.8.4
