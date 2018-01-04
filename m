From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] ASoC: Intel - Convert users to use acpi_dev_get_dev_name()
Date: Thu,  4 Jan 2018 18:47:08 +0200
Message-ID: <20180104164709.64387-3-andriy.shevchenko@linux.intel.com>
References: <20180104164709.64387-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180104164709.64387-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Instead of home grown snd_soc_acpi_find_name_from_hid() use
acpi_dev_get_dev_name().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/sound/soc-acpi.h                |  7 -------
 sound/soc/intel/boards/bytcht_da7213.c  |  2 +-
 sound/soc/intel/boards/bytcr_rt5640.c   |  2 +-
 sound/soc/intel/boards/bytcr_rt5651.c   |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c |  2 +-
 sound/soc/soc-acpi.c                    | 33 ---------------------------------
 7 files changed, 5 insertions(+), 45 deletions(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index a7d8d335b043..a71a935b5bc8 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -27,16 +27,9 @@ struct snd_soc_acpi_package_context {
 };
 
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
index c4d82ad41bd7..828f839d0701 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -243,7 +243,7 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_dev_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(codec_name, sizeof(codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index f2c0fc415e52..849344baf233 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -762,7 +762,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_dev_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 488ec48f296a..87bab84c13a7 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -511,7 +511,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_dev_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index f898ee140cdc..9443b4d4f8b0 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -573,7 +573,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_dev_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(cht_rt5645_codec_name, sizeof(cht_rt5645_codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index f8f21eee9b2d..029670048c17 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -396,7 +396,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 
 	/* fixup codec name based on HID */
 	if (mach) {
-		i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+		i2c_name = acpi_dev_get_dev_name(mach->id, NULL, -1);
 		if (i2c_name) {
 			snprintf(drv->codec_name, sizeof(drv->codec_name),
 				 "i2c-%s", i2c_name);
diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index f21df28bc28e..ed2e7f1a77ea 100644
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
 static acpi_status snd_soc_acpi_mach_match(acpi_handle handle, u32 level,
 				       void *context, void **ret)
 {
-- 
2.15.1

