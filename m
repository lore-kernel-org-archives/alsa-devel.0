From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 12/20] ASoC: davinci-mcasp: Do not inline the
	mcasp_set_ctl_reg function
Date: Thu, 14 Nov 2013 11:35:28 +0200
Message-ID: <1384421737-4467-13-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E13C26513C
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:36:08 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

It brings no benefit to inline this function due to it's size and function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index e4c0fb4..ce1607b 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -90,7 +90,7 @@ static inline u32 mcasp_get_reg(void __iomem *reg)
 	return (unsigned int)__raw_readl(reg);
 }
 
-static inline void mcasp_set_ctl_reg(void __iomem *regs, u32 val)
+static void mcasp_set_ctl_reg(void __iomem *regs, u32 val)
 {
 	int i = 0;
 
-- 
1.8.4.2
