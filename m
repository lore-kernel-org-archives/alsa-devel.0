From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH v2] ASoC: fsl_sai: fix no frame clk in master
	mode
Date: Thu, 10 Dec 2015 11:21:25 +0800
Message-ID: <af420592483389f5420c573b2b23f187a32baea3.1449717000.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0123.outbound.protection.outlook.com [65.55.169.123])
 by alsa0.perex.cz (Postfix) with ESMTP id A365C2614F4
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 04:19:15 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Zidan Wang <zidan.wang@freescale.com>, lgirdwood@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com
List-Id: alsa-devel@alsa-project.org

After several open/close sai test with ctrl+c, there will be
I/O error. The SAI can't work anymore, can't recover. There
will be no frame clock. With adding the software reset in
trigger stop, the issue can be fixed.

This is a hardware bug/errata and reset is the only option.

According to the reference manual, the software reset doesn't
reset any control register but only internal hardware logics
such as bit clock generator, status flags, and FIFO pointers.
(Our purpose is just to reset the clock generator while the
software reset is the only way to do that.)

Since slave mode doesn't use the clock generator, only apply
the reset procedure to the master mode.

For asynchronous mode, TX will not be reset when RX is still
running. In this case, i can't reproduce this issue.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---

v1->v2:
1) refine the commit log and comments
2) Since slave mode doesn't use the clock generator, only apply
   the reset procedure to the master mode.

 sound/soc/fsl/fsl_sai.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 8832901..a55a7de 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -564,6 +564,17 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 					   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
 			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
 					   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
+
+			if (!sai->is_slave_mode) {
+				/* Software Reset for both Tx and Rx */
+				regmap_write(sai->regmap,
+					     FSL_SAI_TCSR, FSL_SAI_CSR_SR);
+				regmap_write(sai->regmap,
+					     FSL_SAI_RCSR, FSL_SAI_CSR_SR);
+				/* Clear SR bit to finish the reset */
+				regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
+				regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
+			}
 		}
 		break;
 	default:
-- 
1.9.1
