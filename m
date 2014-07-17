From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 1/2] ASoC: fsl_sai: Reset FIFOs after disabling TE/RE
Date: Thu, 17 Jul 2014 21:21:37 +0800
Message-ID: <9ef07dc9cc98b19e3f81f8374617605bf0d9faeb.1405603108.git.nicoleotsuka@gmail.com>
References: <cover.1405603108.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1405603108.git.nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, b02247@freescale.com, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org

SAI will not clear their FIFOs after disabling TE/RE. Therfore, the driver
should take care the task so as not to let useless data remain in the FIFO.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index c5a0e8a..b10dbd8 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -371,10 +371,13 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		/* Check if the opposite FRDE is also disabled */
 		if (!(tx ? rcsr & FSL_SAI_CSR_FRDE : tcsr & FSL_SAI_CSR_FRDE)) {
+			/* Disable both directions and reset their FIFOs */
 			regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
-					   FSL_SAI_CSR_TERE, 0);
+					   FSL_SAI_CSR_TERE | FSL_SAI_CSR_FR,
+					   FSL_SAI_CSR_FR);
 			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
-					   FSL_SAI_CSR_TERE, 0);
+					   FSL_SAI_CSR_TERE | FSL_SAI_CSR_FR,
+					   FSL_SAI_CSR_FR);
 		}
 		break;
 	default:
-- 
1.8.4
