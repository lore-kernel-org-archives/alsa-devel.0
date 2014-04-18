From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH] ASoC: fsl_spdif: Fix wrong OFFSET of
	STC_SYSCLK_DIV
Date: Fri, 18 Apr 2014 17:32:08 +0800
Message-ID: <1397813528-3083-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 by alsa0.perex.cz (Postfix) with ESMTP id C1A542615AE
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 11:30:50 +0200 (CEST)
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

It should use STC_SYSCLK_DIV_OFFSET. Thus fix it.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_spdif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
index b126679..605a10b 100644
--- a/sound/soc/fsl/fsl_spdif.h
+++ b/sound/soc/fsl/fsl_spdif.h
@@ -144,8 +144,8 @@ enum spdif_gainsel {
 
 /* SPDIF Clock register */
 #define STC_SYSCLK_DIV_OFFSET		11
-#define STC_SYSCLK_DIV_MASK		(0x1ff << STC_TXCLK_SRC_OFFSET)
-#define STC_SYSCLK_DIV(x)		((((x) - 1) << STC_TXCLK_DIV_OFFSET) & STC_SYSCLK_DIV_MASK)
+#define STC_SYSCLK_DIV_MASK		(0x1ff << STC_SYSCLK_DIV_OFFSET)
+#define STC_SYSCLK_DIV(x)		((((x) - 1) << STC_SYSCLK_DIV_OFFSET) & STC_SYSCLK_DIV_MASK)
 #define STC_TXCLK_SRC_OFFSET		8
 #define STC_TXCLK_SRC_MASK		(0x7 << STC_TXCLK_SRC_OFFSET)
 #define STC_TXCLK_SRC_SET(x)		((x << STC_TXCLK_SRC_OFFSET) & STC_TXCLK_SRC_MASK)
-- 
1.8.4
