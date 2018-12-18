From: Mark Brown <broonie@kernel.org>
Subject: Applied "ARM: omap2plus_defconfig: Update the audio
	options" to the asoc tree
Date: Tue, 18 Dec 2018 12:23:40 +0000 (GMT)
Message-ID: <20181218122340.2E30211254FF@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B136B26782E
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 13:23:40 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ARM: omap2plus_defconfig: Update the audio options

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3162b05fb74cd107b2a66f20485c62514b20048f Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 17 Dec 2018 14:21:39 +0200
Subject: [PATCH] ARM: omap2plus_defconfig: Update the audio options

Use the new options for default audio support and enable Nokia n900 audio
as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/configs/omap2plus_defconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 6491419b1dad..2274e45623f9 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -381,13 +381,13 @@ CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
-CONFIG_SND_EDMA_SOC=m
-CONFIG_SND_AM33XX_SOC_EVM=m
-CONFIG_SND_OMAP_SOC=m
-CONFIG_SND_OMAP_SOC_HDMI_AUDIO=m
-CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
-CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
-CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
+CONFIG_SND_SOC_TLV320AIC3X=m
+CONFIG_SND_SOC_DAVINCI_MCASP=m
+CONFIG_SND_SOC_NOKIA_RX51=m
+CONFIG_SND_SOC_OMAP_HDMI=m
+CONFIG_SND_SOC_OMAP_ABE_TWL6040=m
+CONFIG_SND_SOC_OMAP3_PANDORA=m
+CONFIG_SND_SOC_OMAP3_TWL4030=m
 CONFIG_SND_SOC_CPCAP=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
-- 
2.19.0.rc2
