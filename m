From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH RESEND 2/4] ASoC: fsl_esai: Only bypass sck_div
	for EXTAL source
Date: Tue, 6 May 2014 16:56:00 +0800
Message-ID: <6c6ffc8939e15e4942f8b45a8a779d6cc16b72d4.1399366227.git.Guangyu.Chen@freescale.com>
References: <cover.1399366227.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 by alsa0.perex.cz (Postfix) with ESMTP id B77A9261A88
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 10:54:41 +0200 (CEST)
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

ESAI can only output EXTAL clock source directly. But for FSYS clock source,
ESAI can not output it without getting through PSR PM dividers.

So this patch adds an extra check in the code.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_esai.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index d098a48..7e1916e 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -259,10 +259,16 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 		return -EINVAL;
 	}
 
-	if (ratio == 1) {
+	/* Only EXTAL source can be output directly without using PSR and PM */
+	if (ratio == 1 && clksrc == esai_priv->extalclk) {
 		/* Bypass all the dividers if not being needed */
 		ecr |= tx ? ESAI_ECR_ETO : ESAI_ECR_ERO;
 		goto out;
+	} else if (ratio < 2) {
+		/* The ratio should be no less than 2 if using other sources */
+		dev_err(dai->dev, "failed to derive required HCK%c rate\n",
+				tx ? 'T' : 'R');
+		return -EINVAL;
 	}
 
 	ret = fsl_esai_divisor_cal(dai, tx, ratio, false, 0);
-- 
1.8.4
