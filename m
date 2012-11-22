From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [BUGFIX PATCH] ASoC: fsl: fix miscompilation of snd-soc-imx-pcm
Date: Thu, 22 Nov 2012 13:31:06 +0100
Message-ID: <1353587470-11994-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

Due to a broken make rule, imx-pcm-dma.c or imx-pcm-fiq.c (whatever is
selected via Kconfig) will not be compiled when building as module,
resulting in a non-functional sound driver.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 sound/soc/fsl/Makefile |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 515ba66..7bb5c38 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -36,8 +36,12 @@ obj-$(CONFIG_SND_SOC_IMX_AUDMUX) +=3D snd-soc-imx-au=
dmux.o
=20
 obj-$(CONFIG_SND_SOC_IMX_PCM) +=3D snd-soc-imx-pcm.o
 snd-soc-imx-pcm-y :=3D imx-pcm.o
-snd-soc-imx-pcm-$(CONFIG_SND_SOC_IMX_PCM_FIQ) +=3D imx-pcm-fiq.o
-snd-soc-imx-pcm-$(CONFIG_SND_SOC_IMX_PCM_DMA) +=3D imx-pcm-dma.o
+ifneq ($(CONFIG_SND_SOC_IMX_PCM_FIQ),)
+	snd-soc-imx-pcm-objs +=3D imx-pcm-fiq.o
+endif
+ifneq ($(CONFIG_SND_SOC_IMX_PCM_DMA),)
+	snd-soc-imx-pcm-objs +=3D imx-pcm-dma.o
+endif
=20
 # i.MX Machine Support
 snd-soc-eukrea-tlv320-objs :=3D eukrea-tlv320.o
--=20
1.7.2.5
