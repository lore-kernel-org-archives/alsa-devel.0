From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] ASoC: fsl: Allow to select individual
	common options
Date: Wed,  5 Feb 2014 21:31:52 +0400
Message-ID: <1391621512-15064-2-git-send-email-shc_work@mail.ru>
References: <1391621512-15064-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp43.i.mail.ru (smtp43.i.mail.ru [94.100.177.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 1225726501D
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 18:32:04 +0100 (CET)
In-Reply-To: <1391621512-15064-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Alexander Shiyan <shc_work@mail.ru>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nicolin Chen <Guangyu.Chen@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch allow to select individual common sound options and
as a result allow using sound cards/codecs based on DT description.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/fsl/Kconfig | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index ecc1092..ed74c19 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,14 +1,26 @@
 menu "SoC Audio for Freescale CPUs"
 
+comment "Common SoC Audio options for Freescale CPUs:"
+
 config SND_SOC_FSL_SAI
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_SOC_FSL_SSI
-	tristate
+	tristate "Synchronous Serial Interface module support"
+	help
+	  Say Y if you want to add Synchronous Serial Interface (SSI)
+	  support for the Freescale CPUs.
+	  This option is only useful for out-of-tree drivers since
+	  in-tree drivers select it automatically.
 
 config SND_SOC_FSL_SPDIF
-	tristate
+	tristate "Sony/Philips Digital Interface module support"
+	help
+	  Say Y if you want to add Sony/Philips Digital Interface (SPDIF)
+	  support for the Freescale CPUs.
+	  This option is only useful for out-of-tree drivers since
+	  in-tree drivers select it automatically.
 
 config SND_SOC_FSL_ESAI
 	tristate
@@ -21,7 +33,12 @@ config SND_SOC_IMX_PCM_DMA
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_SOC_IMX_AUDMUX
-	tristate
+	tristate "Digital Audio Mux module support"
+	help
+	  Say Y if you want to add Digital Audio Mux (AUDMUX) support
+	  for the ARM i.MX CPUs.
+	  This option is only useful for out-of-tree drivers since
+	  in-tree drivers select it automatically.
 
 config SND_POWERPC_SOC
 	tristate "SoC Audio for Freescale PowerPC CPUs"
-- 
1.8.3.2
