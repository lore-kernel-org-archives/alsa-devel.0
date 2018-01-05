From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/3] ASoC: Intel - Convert to use acpi_dev_get_first_match_name()
Date: Fri,  5 Jan 2018 18:09:35 +0200
Message-ID: <20180105160935.48588-4-andriy.shevchenko@linux.intel.com>
References: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Instead of home grown snd_soc_acpi_find_name_from_hid() use
acpi_dev_get_first_match_name().

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/sound/soc-acpi.h                |  7 -------
 sound/soc/intel/boards/bytcht_da7213.c  |  2 +-
 sound/soc/intel/boards/bytcht_es8316.c  |  2 +-
 sound/soc/intel/boards/bytcr_rt5640.c   |  2 +-
 sound/soc/intel/boards/bytcr_rt5651.c   |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c |  2 +-
 sound/soc/soc-acpi.c                    | 33 ---------------------------------
 8 files changed, 6 insertions(+), 46 deletions(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 703c78483113..5ab6b2069f6b 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -31,16 +31,9 @@ struct snd_soc_acpi_package_context {
 #define SND_SOC_ACPI_I2C_DEVICE_NAME_LEN (4 + ACPI_ID_LEN + 3 + 1)
 
 #if IS_ENABLED(CONFIG_ACPI)
-/* translation fron HID to I2C name, needed for DAI codec_name */
-const char *snd_soc_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN]);
 bool snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
 				    struct snd_soc_acpi_package_context *ctx);
 #else
-static inline const char *
-snd_soc_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
-{
-	return NULL;
-}
 static inline bool
 snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
 				   struct snd_soc_acpi_package_context *ctx)
diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index e78d9e860522..bf6217c3de94 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -244,7 +244,7 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(codec_name, sizeof(codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index a1cc9590747e..4f6af9f43df8 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -259,7 +259,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(codec_name, sizeof(codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 4bfd11968f77..a45180ad5882 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -763,7 +763,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 86baa6906e92..794d984e420b 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -500,7 +500,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index b2a69aae257e..cd3febbffcfe 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -568,7 +568,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(cht_rt5645_codec_name, sizeof(cht_rt5645_codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index c488dca55570..d1d0617bdf15 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -397,7 +397,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 
 	/* fixup codec name based on HID */
 	if (mach) {
-		i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+		i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
 		if (i2c_name) {
 			snprintf(drv->codec_name, sizeof(drv->codec_name),
 				 "i2c-%s", i2c_name);
diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index 7f43c9bf3d09..3d7e1ff79139 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -16,39 +16,6 @@
 
 #include <sound/soc-acpi.h>
 
-static acpi_status snd_soc_acpi_find_name(acpi_handle handle, u32 level,
-				      void *context, void **ret)
-{
-	struct acpi_device *adev;
-	const char *name = NULL;
-
-	if (acpi_bus_get_device(handle, &adev))
-		return AE_OK;
-
-	if (adev->status.present && adev->status.functional) {
-		name = acpi_dev_name(adev);
-		*(const char **)ret = name;
-		return AE_CTRL_TERMINATE;
-	}
-
-	return AE_OK;
-}
-
-const char *snd_soc_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
-{
-	const char *name = NULL;
-	acpi_status status;
-
-	status = acpi_get_devices(hid, snd_soc_acpi_find_name, NULL,
-				  (void **)&name);
-
-	if (ACPI_FAILURE(status) || name[0] == '\0')
-		return NULL;
-
-	return name;
-}
-EXPORT_SYMBOL_GPL(snd_soc_acpi_find_name_from_hid);
-
 struct snd_soc_acpi_mach *
 snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
 {
-- 
2.15.1

