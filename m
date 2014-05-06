From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 1/2] ASoC: fsl_spdif: Fix incorrect usage of
	regmap_read()
Date: Tue, 6 May 2014 16:41:39 +0800
Message-ID: <1399365699-21084-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 665F926072A
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 10:39:50 +0200 (CEST)
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

We should not copy the return value into this val since it's supposed to
get the value of the register not the success result of regmap_read().
Thus fix it.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index b912d45..9ea2dd4 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -762,7 +762,7 @@ static int fsl_spdif_vbit_get(struct snd_kcontrol *kcontrol,
 	struct regmap *regmap = spdif_priv->regmap;
 	u32 val;
 
-	val = regmap_read(regmap, REG_SPDIF_SIS, &val);
+	regmap_read(regmap, REG_SPDIF_SIS, &val);
 	ucontrol->value.integer.value[0] = (val & INT_VAL_NOGOOD) != 0;
 	regmap_write(regmap, REG_SPDIF_SIC, INT_VAL_NOGOOD);
 
-- 
1.8.4
