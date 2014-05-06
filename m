From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH RESEND 4/4] ASoC: fsl_esai: Set PCRC and PRRC
	registers at the end of hw_params()
Date: Tue, 6 May 2014 16:56:02 +0800
Message-ID: <512805d1950e9a3e4bade940de7f7f1295a0b7c7.1399366227.git.Guangyu.Chen@freescale.com>
References: <cover.1399366227.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 by alsa0.perex.cz (Postfix) with ESMTP id DC9CB2610C1
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 10:54:39 +0200 (CEST)
In-Reply-To: <cover.1399366227.git.Guangyu.Chen@freescale.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

According to Reference Manual -- ESAI Initialization chapter, as the
standard procedure of ESAI personal reset, the PCRC and PRRC registers
should be remained in its reset value and then configured after T/RCCR
and T/RCR configurations's done but before TE/RE's enabling.

So this patch moves PCRC and PRRC settings to the end of hw_params().

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_esai.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index dd0b171..d719caf 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -479,12 +479,6 @@ static int fsl_esai_startup(struct snd_pcm_substream *substream,
 	}
 
 	if (!dai->active) {
-		/* Reset Port C */
-		regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
-				   ESAI_PRRC_PDC_MASK, ESAI_PRRC_PDC(ESAI_GPIO));
-		regmap_update_bits(esai_priv->regmap, REG_ESAI_PCRC,
-				   ESAI_PCRC_PC_MASK, ESAI_PCRC_PC(ESAI_GPIO));
-
 		/* Set synchronous mode */
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_SAICR,
 				   ESAI_SAICR_SYNC, esai_priv->synchronous ?
@@ -545,6 +539,11 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val);
 
+	/* Remove ESAI personal reset by configuring ESAI_PCRC and ESAI_PRRC */
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
+			   ESAI_PRRC_PDC_MASK, ESAI_PRRC_PDC(ESAI_GPIO));
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_PCRC,
+			   ESAI_PCRC_PC_MASK, ESAI_PCRC_PC(ESAI_GPIO));
 	return 0;
 }
 
-- 
1.8.4
