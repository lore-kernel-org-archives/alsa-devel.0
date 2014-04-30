From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 2/2] ASoC: fsl: Allow to select ESAI device
	individually
Date: Wed, 30 Apr 2014 18:10:06 +0800
Message-ID: <1398852606-14345-2-git-send-email-Li.Xiubo@freescale.com>
References: <1398852606-14345-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 28699265072
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 12:55:01 +0200 (CEST)
In-Reply-To: <1398852606-14345-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

This will be useful for out-of-tree drivers since in-tree drivers
could select it automatically.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index fb73e35..0a11826 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -30,9 +30,14 @@ config SND_SOC_FSL_SPDIF
 	  in-tree drivers select it automatically.
 
 config SND_SOC_FSL_ESAI
-	tristate
+	tristate "Enhanced Serial Audio Interface (ESAI) module support"
 	select REGMAP_MMIO
 	select SND_SOC_FSL_UTILS
+	help
+	  Say Y if you want to add Enhanced Synchronous Audio Interface
+	  (ESAI) support for the Freescale CPUs.
+	  This option is only useful for out-of-tree drivers since
+	  in-tree drivers select it automatically.
 
 config SND_SOC_FSL_UTILS
 	tristate
-- 
1.8.4
