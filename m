From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmic: add Kconfig prompt for the
	generic dmic codec." to the asoc tree
Date: Wed, 29 Aug 2018 16:08:58 +0100 (BST)
Message-ID: <20180829150858.F37C8112486B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A296526792D
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 17:08:59 +0200 (CEST)
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
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dmic: add Kconfig prompt for the generic dmic codec.

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

>From 26bcf1c368d9460987d597fb0476d60e51a1bf82 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 29 Aug 2018 17:00:48 +0200
Subject: [PATCH] ASoC: dmic: add Kconfig prompt for the generic dmic codec.

Add Kconfig prompt for the generic digital mic to make it configurable
through menuconfig

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index adaf26e1989c..9989d35e0fc6 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -578,7 +578,11 @@ config SND_SOC_DA9055
 	tristate
 
 config SND_SOC_DMIC
-	tristate
+	tristate "Generic Digital Microphone CODEC"
+	depends on GPIOLIB
+	help
+	  Enable support for the Generic Digital Microphone CODEC.
+	  Select this if your sound card has DMICs.
 
 config SND_SOC_HDMI_CODEC
 	tristate
-- 
2.18.0
