From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5616: allow to build with
	CONFIG_SND_SOC_RT5616" to the asoc tree
Date: Sat, 05 Mar 2016 21:25:12 +0900
Message-ID: <E1acBGi-0003MO-5U@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 512D8266A16
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:25:15 +0100 (CET)
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
To: Caesar Wang <wxt@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5616: allow to build with CONFIG_SND_SOC_RT5616

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

>From 288bc356a881fcdce05f9782736a6a3d9db359a9 Mon Sep 17 00:00:00 2001
From: Caesar Wang <wxt@rock-chips.com>
Date: Fri, 4 Mar 2016 14:54:50 +0800
Subject: [PATCH] ASoC: rt5616: allow to build with CONFIG_SND_SOC_RT5616

This patch fixes that hasn't built the rt5616 driver with
'CONFIG_SND_SOC_RT5616=y' in .config.

The tristate is the prompt on the 'make menuconfig',
in other words, that can't show the prompt and select it
if we don't say what's the tristate.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 50693c867e71..1de259860bc9 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -596,7 +596,7 @@ config SND_SOC_RT298
 	depends on I2C
 
 config SND_SOC_RT5616
-	tristate
+	tristate "Realtek RT5616 CODEC"
 
 config SND_SOC_RT5631
 	tristate "Realtek ALC5631/RT5631 CODEC"
-- 
2.7.0
