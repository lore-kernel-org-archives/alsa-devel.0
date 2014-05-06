From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH RESEND 1/4] ASoC: fsl_esai: Fix incorrect
	condition within ratio range check for FP
Date: Tue, 6 May 2014 16:55:59 +0800
Message-ID: <c037ec5758485a4081c40277adb5cebb8ab229bc.1399366227.git.Guangyu.Chen@freescale.com>
References: <cover.1399366227.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 by alsa0.perex.cz (Postfix) with ESMTP id 22F5C2608D4
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

The range here from 1 to 16 is confined to FP divider only while the
sck_div indicates if the calculation contains PSR and PM dividers. So
for the case using PSR and PM since the sck_div is true, the range of
ratio would simply become bigger than 16.

So this patch fixes the condition here and adds one line comments to
make the purpose here clear.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_esai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index b49b78d..d098a48 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -308,7 +308,8 @@ static int fsl_esai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 		return -EINVAL;
 	}
 
-	if (esai_priv->sck_div[tx] && (ratio > 16 || ratio == 0)) {
+	/* The ratio should be contented by FP alone if bypassing PM and PSR */
+	if (!esai_priv->sck_div[tx] && (ratio > 16 || ratio == 0)) {
 		dev_err(dai->dev, "the ratio is out of range (1 ~ 16)\n");
 		return -EINVAL;
 	}
-- 
1.8.4
