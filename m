From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Use the IS_ENABLED to supports
	the module build" to the asoc tree
Date: Wed, 26 Jul 2017 15:17:21 +0100
Message-ID: <E1daN7p-0003cr-98@debutante>
References: <1501065140-14843-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 99AFA267465
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 16:17:30 +0200 (CEST)
In-Reply-To: <1501065140-14843-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Use the IS_ENABLED to supports the module build

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From c2bf252536577db77c719f62a54cad2e4be5c4d7 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Wed, 26 Jul 2017 18:32:20 +0800
Subject: [PATCH] ASoC: rt5514: Use the IS_ENABLED to supports the module build

The patch uses the macro IS_ENABLED to make sure that the SPI function also
supports the module build.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 3d0aea8f3801..21cbb566c0d3 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -31,7 +31,7 @@
 
 #include "rl6231.h"
 #include "rt5514.h"
-#if defined(CONFIG_SND_SOC_RT5514_SPI)
+#if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
 #include "rt5514-spi.h"
 #endif
 
@@ -312,7 +312,7 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 
 			request_firmware(&fw, RT5514_FIRMWARE1, codec->dev);
 			if (fw) {
-#if defined(CONFIG_SND_SOC_RT5514_SPI)
+#if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
 				rt5514_spi_burst_write(0x4ff60000, fw->data,
 					((fw->size/8)+1)*8);
 #else
@@ -325,7 +325,7 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 
 			request_firmware(&fw, RT5514_FIRMWARE2, codec->dev);
 			if (fw) {
-#if defined(CONFIG_SND_SOC_RT5514_SPI)
+#if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
 				rt5514_spi_burst_write(0x4ffc0000, fw->data,
 					((fw->size/8)+1)*8);
 #else
-- 
2.13.2
