From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH RESEND 2/2] ASoC: fsl: Allow to select
	individual common options
Date: Sun, 16 Mar 2014 08:21:35 +0400
Message-ID: <1394943695-22845-2-git-send-email-shc_work@mail.ru>
References: <1394943695-22845-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp17.mail.ru (smtp17.mail.ru [94.100.176.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A86C2608C7
 for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2014 05:21:51 +0100 (CET)
In-Reply-To: <1394943695-22845-1-git-send-email-shc_work@mail.ru>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

This patch allow to select individual common sound options and
as a result allow using sound cards/codecs based on DT description.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/fsl/Kconfig | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 94c9350..14216da 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,16 +1,28 @@
 menu "SoC Audio for Freescale CPUs"
 
+comment "Common SoC Audio options for Freescale CPUs:"
+
 config SND_SOC_FSL_SAI
 	tristate
 	select REGMAP_MMIO
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
 	select REGMAP_MMIO
+	help
+	  Say Y if you want to add Sony/Philips Digital Interface (SPDIF)
+	  support for the Freescale CPUs.
+	  This option is only useful for out-of-tree drivers since
+	  in-tree drivers select it automatically.
 
 config SND_SOC_FSL_ESAI
 	tristate
@@ -24,7 +36,12 @@ config SND_SOC_IMX_PCM_DMA
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
