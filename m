From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_es8316: Add quirk for
	inverted jack detect" to the asoc tree
Date: Mon,  8 Apr 2019 14:24:39 +0700 (+07)
Message-ID: <20190408072439.397E5441D3C@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC14EF89731
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2019 09:24:55 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcht_es8316: Add quirk for inverted jack detect

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

>From ba49cf6f8e4ad44ee752eb13413a26a7191893ae Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 29 Mar 2019 22:50:44 +0100
Subject: [PATCH] ASoC: Intel: bytcht_es8316: Add quirk for inverted jack
 detect

Add a quirk to support boards whose jack detection mechanism is
inverted.

It will set the 'everest,jack-detect-inverted' boolean device property
for the es8316 codec driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 6937c00cf63d..ccf552e92d53 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -40,6 +40,9 @@
 #include "../atom/sst-atom-controls.h"
 #include "../common/sst-dsp.h"
 
+/* jd-inv + terminating entry */
+#define MAX_NO_PROPS 2
+
 struct byt_cht_es8316_private {
 	struct clk *mclk;
 	struct snd_soc_jack jack;
@@ -55,6 +58,7 @@ enum {
 #define BYT_CHT_ES8316_MAP(quirk)		((quirk) & GENMASK(3, 0))
 #define BYT_CHT_ES8316_SSP0			BIT(16)
 #define BYT_CHT_ES8316_MONO_SPEAKER		BIT(17)
+#define BYT_CHT_ES8316_JD_INVERTED		BIT(18)
 
 static int quirk;
 
@@ -72,6 +76,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk SSP0 enabled");
 	if (quirk & BYT_CHT_ES8316_MONO_SPEAKER)
 		dev_info(dev, "quirk MONO_SPEAKER enabled\n");
+	if (quirk & BYT_CHT_ES8316_JD_INVERTED)
+		dev_info(dev, "quirk JD_INVERTED enabled\n");
 }
 
 static int byt_cht_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
@@ -438,12 +444,14 @@ static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
 	static const char * const mic_name[] = { "in1", "in2" };
+	struct property_entry props[MAX_NO_PROPS] = {};
 	struct byt_cht_es8316_private *priv;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
 	struct acpi_device *adev;
 	struct device *codec_dev;
+	unsigned int cnt = 0;
 	int dai_index = 0;
 	int i;
 	int ret = 0;
@@ -513,6 +521,15 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	if (!codec_dev)
 		return -EPROBE_DEFER;
 
+	if (quirk & BYT_CHT_ES8316_JD_INVERTED)
+		props[cnt++] = PROPERTY_ENTRY_BOOL("everest,jack-detect-inverted");
+
+	if (cnt) {
+		ret = device_add_properties(codec_dev, props);
+		if (ret)
+			return ret;
+	}
+
 	devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
 	priv->speaker_en_gpio =
 		gpiod_get_index(codec_dev, "speaker-enable", 0,
-- 
2.20.1
