From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 1/2] ASoC: fsl: Allow to select SAI device
	individually
Date: Wed, 30 Apr 2014 18:10:05 +0800
Message-ID: <1398852606-14345-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 59B81265065
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 12:54:50 +0200 (CEST)
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
index 7a7eaf3..fb73e35 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -3,9 +3,14 @@ menu "SoC Audio for Freescale CPUs"
 comment "Common SoC Audio options for Freescale CPUs:"
 
 config SND_SOC_FSL_SAI
-	tristate
+	tristate "Synchronous Audio Interface (SAI) module support"
 	select REGMAP_MMIO
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+	  Say Y if you want to add Synchronous Audio Interface (SAI)
+	  support for the Freescale CPUs.
+	  This option is only useful for out-of-tree drivers since
+	  in-tree drivers select it automatically.
 
 config SND_SOC_FSL_SSI
 	tristate "Synchronous Serial Interface module support"
-- 
1.8.4
