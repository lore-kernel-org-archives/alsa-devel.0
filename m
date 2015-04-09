From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2] ASoC: fsl: Add the audio interface acronyms
	in Kconfig text
Date: Thu, 9 Apr 2015 15:32:09 -0300
Message-ID: <1428604329-23575-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 32979265947
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 20:32:24 +0200 (CEST)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

To keep consistency with the other Kconfig entries, use the audio
interface acronyms (SSI and SPDIF) in the Kconfig menu text.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix typo in 'interfacce'

 sound/soc/fsl/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 081e406..fa44fc6 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -24,7 +24,7 @@ config SND_SOC_FSL_SAI
 	  in-tree drivers select it automatically.
 
 config SND_SOC_FSL_SSI
-	tristate "Synchronous Serial Interface module support"
+	tristate "Synchronous Serial Interface module (SSI) support"
 	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
 	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && (MXC_TZIC || MXC_AVIC)
 	select REGMAP_MMIO
@@ -35,7 +35,7 @@ config SND_SOC_FSL_SSI
 	  in-tree drivers select it automatically.
 
 config SND_SOC_FSL_SPDIF
-	tristate "Sony/Philips Digital Interface module support"
+	tristate "Sony/Philips Digital Interface (SPDIF) module support"
 	select REGMAP_MMIO
 	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
 	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && (MXC_TZIC || MXC_AVIC)
-- 
1.9.1
