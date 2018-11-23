From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-amplifier: add VCC regulator
	widget" to the asoc tree
Date: Fri, 23 Nov 2018 14:13:34 +0000 (GMT)
Message-ID: <20181123141334.A8245440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BD102678DF
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:13:37 +0100 (CET)
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
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-amplifier: add VCC regulator widget

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

>From 6debd01a74b8c15ab3f2a6f7ff4a7dcbada101cb Mon Sep 17 00:00:00 2001
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Thu, 22 Nov 2018 18:23:21 +0800
Subject: [PATCH] ASoC: simple-amplifier: add VCC regulator widget

Amplifier may have assosicated regulator, so add a widget for it
and appropriate route.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/simple-amplifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/simple-amplifier.c b/sound/soc/codecs/simple-amplifier.c
index 85524acf3e9c..c07e8a80b4b7 100644
--- a/sound/soc/codecs/simple-amplifier.c
+++ b/sound/soc/codecs/simple-amplifier.c
@@ -19,6 +19,7 @@
 
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <sound/soc.h>
 
 #define DRV_NAME "simple-amplifier"
@@ -58,11 +59,14 @@ static const struct snd_soc_dapm_widget simple_amp_dapm_widgets[] = {
 			       (SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)),
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VCC", 20, 0),
 };
 
 static const struct snd_soc_dapm_route simple_amp_dapm_routes[] = {
 	{ "DRV", NULL, "INL" },
 	{ "DRV", NULL, "INR" },
+	{ "OUTL", NULL, "VCC" },
+	{ "OUTR", NULL, "VCC" },
 	{ "OUTL", NULL, "DRV" },
 	{ "OUTR", NULL, "DRV" },
 };
-- 
2.19.1
