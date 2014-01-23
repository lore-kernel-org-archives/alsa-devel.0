From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 1/8] ASoC: fsl: Add VF610 soc audio card Kconfig
Date: Thu, 23 Jan 2014 13:02:43 +0800
Message-ID: <1390453370-29194-2-git-send-email-Li.Xiubo@freescale.com>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, shawn.guo@linaro.org, kuninori.morimoto.gx@renesas.com
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/Kconfig | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 324988d..bc1fa9c 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -219,3 +219,27 @@ config SND_SOC_IMX_MC13783
 	select SND_SOC_IMX_PCM_DMA
 
 endif # SND_IMX_SOC
+
+menuconfig SND_VF610_SOC
+       tristate "SoC Audio for Freescale VF610 CPUs"
+       select DMA_ENGINE
+       help
+         Say Y or M if you want to add support for codecs attached to
+         the VF610 CPUs.
+
+         This will enable Freeacale SAI and SGTL5000 codec, and an extra
+         TWR-AUDIO-SGTL sub-board is needed for SGTL5000.
+
+if SND_VF610_SOC
+
+config SND_SOC_VF610_SGTL5000
+       tristate "SoC Audio support for VF610 boards with SGTL5000"
+       depends on OF && I2C
+       select SND_SOC_FSL_SAI
+       select SND_SOC_SGTL5000
+       select SND_SIMPLE_CARD
+       help
+         Say Y if you want to add support for SoC audio on an VF610 board with
+         a SGTL5000 codec and a SAI.
+
+endif #SND_VF610_SOC
-- 
1.8.4
