From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: fsl_asrc: Select
	SND_SOC_GENERIC_DMAENGINE_PCM
Date: Wed, 30 Jul 2014 11:27:06 -0300
Message-ID: <1406730426-11023-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id C681C261647
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 16:27:30 +0200 (CEST)
Received: by mail-vc0-f176.google.com with SMTP id id10so1883857vcb.7
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 07:27:29 -0700 (PDT)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Building a kernel with SND_SOC_GENERIC_DMAENGINE_PCM=n leads to the following
error:

ERROR: "snd_dmaengine_pcm_prepare_slave_config" [sound/soc/fsl/snd-soc-fsl-asrc.ko] undefined!

Let SND_SOC_FSL_ASRC select SND_SOC_GENERIC_DMAENGINE_PCM in order to fix such
error.

Reported-by: kbuild test robot <fengguang.wu@intel.com> 
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 2fb8a43..f54a8fc 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -5,6 +5,7 @@ comment "Common SoC Audio options for Freescale CPUs:"
 config SND_SOC_FSL_ASRC
 	tristate "Asynchronous Sample Rate Converter (ASRC) module support"
 	select REGMAP_MMIO
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y if you want to add Asynchronous Sample Rate Converter (ASRC)
 	  support for the Freescale CPUs.
-- 
1.9.1
