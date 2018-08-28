From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: imply clock and reset
	controllers" to the asoc tree
Date: Tue, 28 Aug 2018 21:48:19 +0100 (BST)
Message-ID: <20180828204820.015EB44007A@finisterre.ee.mobilebroadband>
References: <20180828121721.26488-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B55CD26781A
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:48:21 +0200 (CEST)
In-Reply-To: <20180828121721.26488-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: imply clock and reset controllers

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

>From ac16df938e5107a1e08cf0f52818fa6a5f7bba94 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 28 Aug 2018 14:17:21 +0200
Subject: [PATCH] ASoC: meson: imply clock and reset controllers

Add audio clock controller and ARB reset controller module
implication for the device using them

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 8af8bc358a90..2ccbadc387de 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -4,6 +4,8 @@ menu "ASoC support for Amlogic platforms"
 config SND_MESON_AXG_FIFO
 	tristate
 	select REGMAP_MMIO
+	imply COMMON_CLK_AXG_AUDIO
+	imply RESET_MESON_AUDIO_ARB
 
 config SND_MESON_AXG_FRDDR
 	tristate "Amlogic AXG Playback FIFO support"
@@ -22,6 +24,7 @@ config SND_MESON_AXG_TODDR
 config SND_MESON_AXG_TDM_FORMATTER
 	tristate
 	select REGMAP_MMIO
+	imply COMMON_CLK_AXG_AUDIO
 
 config SND_MESON_AXG_TDM_INTERFACE
 	tristate
@@ -58,6 +61,7 @@ config SND_MESON_AXG_SPDIFOUT
 	tristate "Amlogic AXG SPDIF Output Support"
 	select SND_PCM_IEC958
 	imply SND_SOC_SPDIF
+	imply COMMON_CLK_AXG_AUDIO
 	help
 	  Select Y or M to add support for SPDIF output serializer embedded
 	  in the Amlogic AXG SoC family
-- 
2.18.0
