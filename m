From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel - Convert to use
	acpi_dev_get_first_match_name()" to the asoc tree
Date: Fri, 12 Jan 2018 21:21:05 +0000
Message-ID: <E1ea6l7-0003nX-IN@debutante>
References: <20180112211617.60941-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A860266B67
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 22:21:10 +0100 (CET)
In-Reply-To: <20180112211617.60941-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel - Convert to use acpi_dev_get_first_match_name()

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

>From 3a1479599a610cd49cbf91da68963ade90ee0fa3 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 12 Jan 2018 23:16:17 +0200
Subject: [PATCH] ASoC: Intel - Convert to use acpi_dev_get_first_match_name()

Instead of home grown snd_soc_acpi_find_name_from_hid() use
acpi_dev_get_first_match_name().

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index 83320af8def2..082224275f52 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -31,16 +31,9 @@ struct snd_soc_acpi_package_context {
 #define SND_ACPI_I2C_ID_LEN (4 + ACPI_ID_LEN + 3 + 1)
 
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
index 6219c04d4731..2179dedb28ad 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -243,7 +243,7 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(codec_name, sizeof(codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 079f35cd4eaf..305e7f4fe55a 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -258,7 +258,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(codec_name, sizeof(codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 4548f75498d0..b6a1cfeec830 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -762,7 +762,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 5a6b7dedb773..456526a93dd5 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -539,7 +539,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index cef6a8c31c8d..976ea6bf9539 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -566,7 +566,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		}
 
 	/* fixup codec name based on HID */
-	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
 	if (i2c_name) {
 		snprintf(cht_rt5645_codec_name, sizeof(cht_rt5645_codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 1f3d38dc4fcb..c14a52d2f714 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -396,7 +396,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 
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
