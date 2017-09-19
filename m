From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9713: add ac97 new bus support" to
	the asoc tree
Date: Tue, 19 Sep 2017 17:11:13 +0100
Message-ID: <E1duL7B-0004iy-45@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D26626742C
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 18:11:16 +0200 (CEST)
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
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm9713: add ac97 new bus support

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

>From 9bd400cadae05a26c3a22dd8393081cb96d0e26a Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Wed, 13 Sep 2017 21:37:19 +0200
Subject: [PATCH] ASoC: wm9713: add ac97 new bus support

Add support for the new ac97 bus model, where devices are automatically
discovered on AC-Links.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  |  3 ++-
 sound/soc/codecs/wm9713.c | 39 +++++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c367d11079bc..807901cac1b3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -216,7 +216,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM9090 if I2C
 	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
-	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
+	select SND_SOC_WM9713 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
         help
           Normally ASoC codec drivers are only built if a machine driver which
           uses them is also built since they are only usable with a machine
@@ -1136,6 +1136,7 @@ config SND_SOC_WM9712
 config SND_SOC_WM9713
 	tristate
 	select REGMAP_AC97
+	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_ZX_AUD96P22
 	tristate "ZTE ZX AUD96P22 CODEC"
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 7e4822185feb..df7220656d98 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -17,12 +17,15 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/mfd/wm97xx.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
+#include <sound/ac97/codec.h>
+#include <sound/ac97/compat.h>
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
@@ -38,6 +41,7 @@ struct wm9713_priv {
 	u32 pll_in; /* PLL input frequency */
 	unsigned int hp_mixer[2];
 	struct mutex lock;
+	struct wm97xx_platform_data *mfd_pdata;
 };
 
 #define HPL_MIXER 0
@@ -1205,17 +1209,23 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 static int wm9713_soc_probe(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
-	struct regmap *regmap;
+	struct regmap *regmap = NULL;
 
-	wm9713->ac97 = snd_soc_new_ac97_codec(codec, WM9713_VENDOR_ID,
-		WM9713_VENDOR_ID_MASK);
-	if (IS_ERR(wm9713->ac97))
-		return PTR_ERR(wm9713->ac97);
-
-	regmap = regmap_init_ac97(wm9713->ac97, &wm9713_regmap_config);
-	if (IS_ERR(regmap)) {
-		snd_soc_free_ac97_codec(wm9713->ac97);
-		return PTR_ERR(regmap);
+	if (wm9713->mfd_pdata) {
+		wm9713->ac97 = wm9713->mfd_pdata->ac97;
+		regmap = wm9713->mfd_pdata->regmap;
+	} else {
+#ifdef CONFIG_SND_SOC_AC97_BUS
+		wm9713->ac97 = snd_soc_new_ac97_codec(codec, WM9713_VENDOR_ID,
+						      WM9713_VENDOR_ID_MASK);
+		if (IS_ERR(wm9713->ac97))
+			return PTR_ERR(wm9713->ac97);
+		regmap = regmap_init_ac97(wm9713->ac97, &wm9713_regmap_config);
+		if (IS_ERR(regmap)) {
+			snd_soc_free_ac97_codec(wm9713->ac97);
+			return PTR_ERR(regmap);
+		}
+#endif
 	}
 
 	snd_soc_codec_init_regmap(codec, regmap);
@@ -1228,10 +1238,14 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 
 static int wm9713_soc_remove(struct snd_soc_codec *codec)
 {
+#ifdef CONFIG_SND_SOC_AC97_BUS
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 
-	snd_soc_codec_exit_regmap(codec);
-	snd_soc_free_ac97_codec(wm9713->ac97);
+	if (!wm9713->mfd_pdata) {
+		snd_soc_codec_exit_regmap(codec);
+		snd_soc_free_ac97_codec(wm9713->ac97);
+	}
+#endif
 	return 0;
 }
 
@@ -1262,6 +1276,7 @@ static int wm9713_probe(struct platform_device *pdev)
 
 	mutex_init(&wm9713->lock);
 
+	wm9713->mfd_pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, wm9713);
 
 	return snd_soc_register_codec(&pdev->dev,
-- 
2.14.1
