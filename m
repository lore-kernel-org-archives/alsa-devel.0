From: Marek Vasut <marex@denx.de>
Subject: [PATCH] ASoC: fsl_esai: Clear the xPM bit when using
	xFP
Date: Sat,  7 Apr 2018 15:02:21 +0200
Message-ID: <20180407130221.24770-1-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by alsa0.perex.cz (Postfix) with ESMTP id A6CCC26732A
 for <alsa-devel@alsa-project.org>; Sat,  7 Apr 2018 15:02:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>, Mark Brown <broonie@kernel.org>, "Gustavo A . R . Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

When setting xFP directly, set the xPM predivider to 1, otherwise
it could remain set to previously set incorrect value and interfere
with the correct clocking.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Gustavo A. R. Silva <garsilva@embeddedor.com>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 40a700493f4c..9f69823b50d7 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -128,8 +128,11 @@ static int fsl_esai_divisor_cal(struct snd_soc_dai *dai, bool tx, u32 ratio,
 
 	maxfp = usefp ? 16 : 1;
 
-	if (usefp && fp)
+	if (usefp && fp) {
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCCR(tx),
+				   ESAI_xCCR_xPM_MASK, 0);
 		goto out_fp;
+	}
 
 	if (ratio > 2 * 8 * 256 * maxfp || ratio < 2) {
 		dev_err(dai->dev, "the ratio is out of range (2 ~ %d)\n",
-- 
2.16.2
