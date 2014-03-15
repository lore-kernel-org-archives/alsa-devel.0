From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 14/16] ASoC: fsl-ssi: Transmit enable
	synchronization
Date: Sat, 15 Mar 2014 13:44:22 +0100
Message-ID: <1394887464-969-15-git-send-email-mpa@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 5147E2650AC
 for <alsa-devel@alsa-project.org>; Sat, 15 Mar 2014 13:45:54 +0100 (CET)
In-Reply-To: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

When the fsl-ssi unit is used in i2s slave mode, it is possible that the
SSI unit starts transmitting data on the wrong channel. This happens
because the SSI does not synchronize with the left-right-clock by
default.

This patch enables transmit enable synchronization.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 1 +
 sound/soc/fsl/fsl_ssi.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index bb6d607..6095a15 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -615,6 +615,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 	fsl_ssi_setup_reg_vals(ssi_private);
 
 	scr = read_ssi(&ssi->scr) & ~(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_I2S_MODE_MASK);
+	scr |= CCSR_SSI_SCR_SYNC_TX_FS;
 
 	mask = CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFDIR | CCSR_SSI_STCR_TXDIR |
 		CCSR_SSI_STCR_TSCKP | CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TFSL |
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 2e95dd7..71c3e7e 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -39,6 +39,7 @@ struct ccsr_ssi {
 	__be32 saccdis; /* 0x.0058 - SSI AC97 Channel Disable Register */
 };
 
+#define CCSR_SSI_SCR_SYNC_TX_FS		0x00001000
 #define CCSR_SSI_SCR_RFR_CLK_DIS	0x00000800
 #define CCSR_SSI_SCR_TFR_CLK_DIS	0x00000400
 #define CCSR_SSI_SCR_TCH_EN		0x00000100
-- 
1.9.0
