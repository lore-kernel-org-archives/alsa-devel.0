From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 02/16] ASoC: fsl-ssi: Fix i2s_mode variable setup
Date: Sat, 15 Mar 2014 13:44:10 +0100
Message-ID: <1394887464-969-3-git-send-email-mpa@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

In fsl_ssi_hw_params() we update the I2S and NET bits using the i2s_mode
variable. The fsl_ssi_set_dai_fmt() function only writes the i2s-mode to
the i2s_mode variable and not the NET bit. This fixes it by adding that
bit to i2s_mode.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 144934e..fdb123d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -745,7 +745,6 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	fsl_ssi_setup_reg_vals(ssi_private);
 
 	scr = read_ssi(&ssi->scr) & ~(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_I2S_MODE_MASK);
-	scr |= CCSR_SSI_SCR_NET;
 
 	mask = CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFDIR | CCSR_SSI_STCR_TXDIR |
 		CCSR_SSI_STCR_TSCKP | CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TFSL |
@@ -753,14 +752,15 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	stcr = read_ssi(&ssi->stcr) & ~mask;
 	srcr = read_ssi(&ssi->srcr) & ~mask;
 
+	ssi_private->i2s_mode = CCSR_SSI_SCR_NET;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 		case SND_SOC_DAIFMT_CBS_CFS:
-			ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_MASTER;
+			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_MASTER;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
-			ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_SLAVE;
+			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_SLAVE;
 			break;
 		default:
 			return -EINVAL;
@@ -785,7 +785,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 			CCSR_SSI_STCR_TXBIT0;
 		break;
 	case SND_SOC_DAIFMT_AC97:
-		ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_NORMAL;
+		ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_NORMAL;
 		break;
 	default:
 		return -EINVAL;
-- 
1.9.0
