From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V2] ASoC: fsl-asoc-card: move 'config
	SND_SOC_FSL_ASOC_CARD' to 'if SND_IMX_SOC'
Date: Tue, 19 Aug 2014 17:36:41 +0800
Message-ID: <bfed4dfd3cf1ef134dac1f114f3d2b8cedf55c68.1408440952.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 985F12655F6
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 11:36:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, shc_work@mail.ru, fabio.estevam@freescale.com, shengjiu.wang@freescale.com, xobs@kosagi.com, arnd@arndb.de, sfr@canb.auug.org.au, timur@tabi.org
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Build kernel with SND_SOC_FSL_ASOC_CARD=m && SND_SOC_FSL_{SSI,SAI,ESAI}=y
leads the following error:

   sound/built-in.o: In function `fsl_sai_probe':
>> fsl_sai.c:(.text+0x5f662): undefined reference to `imx_pcm_dma_init'
   sound/built-in.o: In function `fsl_esai_probe':
>> fsl_esai.c:(.text+0x6044b): undefined reference to `imx_pcm_dma_init'

The config SND_SOC_FSL_ASOC_CARD is for IMX SOC, So move it under condition
of 'if SND_IMX_SOC'.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 sound/soc/fsl/Kconfig |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 417ff70..9348fef 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -58,23 +58,6 @@ config SND_SOC_FSL_ESAI
 config SND_SOC_FSL_UTILS
 	tristate
 
-config SND_SOC_FSL_ASOC_CARD
-	tristate "Generic ASoC Sound Card with ASRC support"
-	depends on OF && I2C
-	select SND_SOC_IMX_AUDMUX
-	select SND_SOC_IMX_PCM_DMA
-	select SND_SOC_FSL_ESAI
-	select SND_SOC_FSL_SAI
-	select SND_SOC_FSL_SSI
-	select SND_SOC_CS42XX8_I2C
-	select SND_SOC_SGTL5000
-	select SND_SOC_WM8962
-	help
-	 ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
-	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888
-	 and SGTL5000.
-	 Say Y if you want to add support for Freescale Generic ASoC Sound Card.
-
 config SND_SOC_IMX_PCM_DMA
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
@@ -285,6 +268,23 @@ config SND_SOC_IMX_MC13783
 	select SND_SOC_MC13783
 	select SND_SOC_IMX_PCM_DMA
 
+config SND_SOC_FSL_ASOC_CARD
+	tristate "Generic ASoC Sound Card with ASRC support"
+	depends on OF && I2C
+	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_IMX_PCM_DMA
+	select SND_SOC_FSL_ESAI
+	select SND_SOC_FSL_SAI
+	select SND_SOC_FSL_SSI
+	select SND_SOC_CS42XX8_I2C
+	select SND_SOC_SGTL5000
+	select SND_SOC_WM8962
+	help
+	 ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
+	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888
+	 and SGTL5000.
+	 Say Y if you want to add support for Freescale Generic ASoC Sound Card.
+
 endif # SND_IMX_SOC
 
 endmenu
-- 
1.7.9.5
