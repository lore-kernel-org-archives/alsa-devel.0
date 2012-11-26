From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH v3] ASoC: fsl: fix miscompilation of snd-soc-imx-pcm
Date: Mon, 26 Nov 2012 09:50:47 +0100
Message-ID: <1353919847-8395-1-git-send-email-LW@KARO-electronics.de>
References: <20121123114603.GF4529@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121123114603.GF4529@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

thanks your insisting on a better description for the patch, I found a
more appropriate solution for the problem:=20

Compiling the SoC Audio driver for Freescale i.MX as a module
(CONFIG_SND_SOC_IMX_PCM=3Dm) results in a non-functional sound driver
indicated by the error message:
| imx-sgtl5000 sound.1: platform imx-pcm-audio not registered
| imx-sgtl5000 sound.1: snd_soc_register_card failed (-517)
| platform sound.1: Driver imx-sgtl5000 requests probe deferral
instead of the message:
| imx-sgtl5000 sound.1:  sgtl5000 <-> 63fcc000.ssi mapping ok
that is to be expected upon loading the snd-soc-imx-pcm.ko module.

The build log reveals, that the file imx-pcm-dma.o (or imx-pcm-fiq.o
depending on the kernel configuration), which should be linked
together with imx-pcm.o into snd-imx-pcm.ko, is not being compiled in
this case.

The make rules for these files shows that the target object imx-pcm.o
is assigned to the variable snd-soc-imx-pcm-y while
imx-pcm-{dma,fiq}.o are added to to
snd-soc-imx-pcm-$(CONFIG_SND_SOC_IMX_PCM_DMA) and
snd-soc-imx-pcm-$(CONFIG_SND_SOC_IMX_PCM_FIQ) which resolve to
snd-soc-imx-pcm-m in this case.

According to Documentation/kbuild/modules.txt:
|When the module is built from multiple sources, an additional line is
|needed listing the files:
|
|        <module_name>-y :=3D <src1>.o <src2>.o ...
Thus the type of the config variables CONFIG_SND_SOC_IMX_PCM_DMA and
CONFIG_SND_SOC_IMX_PCM_FIQ should be 'bool' instead of 'tristate' to
resolve to 'y' when selected.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 sound/soc/fsl/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 10fd172..3b98159 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -112,12 +112,12 @@ config SND_SOC_IMX_PCM
 	tristate
=20
 config SND_SOC_IMX_PCM_FIQ
-	tristate
+	bool
 	select FIQ
 	select SND_SOC_IMX_PCM
=20
 config SND_SOC_IMX_PCM_DMA
-	tristate
+	bool
 	select SND_SOC_DMAENGINE_PCM
 	select SND_SOC_IMX_PCM
=20
--=20
1.7.2.5
