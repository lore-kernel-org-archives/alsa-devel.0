From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ASoC: imx: Allow using sound with DT
	descriptions only
Date: Sun,  5 Jan 2014 10:35:26 +0400
Message-ID: <1388903726-2053-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [94.100.177.98])
 by alsa0.perex.cz (Postfix) with ESMTP id 81E78261B28
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 07:35:37 +0100 (CET)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Alexander Shiyan <shc_work@mail.ru>, Takashi Iwai <tiwai@suse.de>, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds new Kconfig symbol to allow using generic sound
cards/codecs based on DT description.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/fsl/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index bb4ab96..51fabc6 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -126,6 +126,16 @@ config SND_SOC_IMX_PCM_DMA
 config SND_SOC_IMX_AUDMUX
 	tristate
 
+config SND_SOC_IMX_DT
+	tristate "SoC Audio support for i.MX DT boards"
+	depends on OF
+	select SND_SOC_FSL_SSI
+	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_IMX_PCM_DMA
+	help
+	  Say Y if you want to add support for SoC audio on an i.MX boards
+	  described in devicetree.
+
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the i.MX31ADS with WM1133-EV1 fitted"
 	depends on MACH_MX31ADS_WM1133_EV1
-- 
1.8.3.2
