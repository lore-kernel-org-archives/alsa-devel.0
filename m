From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 3/6] ASoC: fsl_sai: Drop useless channels check
	in hw_params()
Date: Fri, 20 Dec 2013 16:41:02 +0800
Message-ID: <96e94a82209c0ba9cce7bbacaa2adbabf12ea45d.1387528048.git.Guangyu.Chen@freescale.com>
References: <cover.1387528048.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C9D526558D
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 09:40:45 +0100 (CET)
In-Reply-To: <cover.1387528048.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, linux@arm.linux.org.uk
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, timur@tabi.org, lgirdwood@gmail.com, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

SAi only supports two data channels on hardware level and the driver also does
register the min->1 and max->2, so no need to check channels.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 6f1e8aa..f899e82 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -278,10 +278,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 		val_cr5 |= FSL_SAI_CR5_FBT(0);
 
 	val_cr4 |= FSL_SAI_CR4_FRSZ(channels);
-	if (channels == 2 || channels == 1)
-		val_mr = ~0UL - ((1 << channels) - 1);
-	else
-		return -EINVAL;
+	val_mr = ~0UL - ((1 << channels) - 1);
 
 	sai_writel(sai, val_cr4, sai->base + reg_cr4);
 	sai_writel(sai, val_cr5, sai->base + reg_cr5);
-- 
1.8.4
