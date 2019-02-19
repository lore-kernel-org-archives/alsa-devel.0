From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau1977: Add support for setting MICBIAS via DT" to the asoc tree
Date: Tue, 19 Feb 2019 15:50:18 +0000 (GMT)
Message-ID: <20190219155018.58B6A11284BD@debutante.sirena.org.uk>
References: <20190219141139.24216-3-bogdan.togorean@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219141139.24216-3-bogdan.togorean@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bogdan Togorean <bogdan.togorean@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.combroonie@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adau1977: Add support for setting MICBIAS via DT

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

>From 65d257ee12860340947bbc336243b4a9a5d721df Mon Sep 17 00:00:00 2001
From: Bogdan Togorean <bogdan.togorean@gmail.com>
Date: Tue, 19 Feb 2019 16:11:39 +0200
Subject: [PATCH] ASoC: adau1977: Add support for setting MICBIAS via DT

If platform_data is NULL add reading of optional adi,micbias
property from DT. If adi,micbias is not set keep the default
value for micbias.

Signed-off-by: Bogdan Togorean <bogdan.togorean@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1977.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index 116af6a9ce3b..11c53bcb71dd 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -885,13 +885,15 @@ static int adau1977_setup_micbias(struct adau1977 *adau1977)
 	struct adau1977_platform_data *pdata = adau1977->dev->platform_data;
 	unsigned int micbias;
 
-	if (pdata) {
+	if (pdata)
 		micbias = pdata->micbias;
-		if (micbias > ADAU1977_MICBIAS_9V0)
-			return -EINVAL;
-
-	} else {
+	else if (device_property_read_u32(adau1977->dev, "adi,micbias",
+					  &micbias))
 		micbias = ADAU1977_MICBIAS_8V5;
+
+	if (micbias > ADAU1977_MICBIAS_9V0) {
+		dev_err(adau1977->dev, "Invalid value for 'adi,micbias'\n");
+		return -EINVAL;
 	}
 
 	return regmap_update_bits(adau1977->regmap, ADAU1977_REG_MICBIAS,
-- 
2.20.1
