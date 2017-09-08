From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 1/8] ASoC: move ACPI common code out of
	Intel/sst tree
Date: Fri,  8 Sep 2017 15:56:55 -0500
Message-ID: <20170908205702.1985-2-pierre-louis.bossart@linux.intel.com>
References: <20170908205702.1985-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D6E72266E17
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 22:57:15 +0200 (CEST)
In-Reply-To: <20170908205702.1985-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

ACPI support is not specific to the Intel/SST driver. Move the enumeration
and matching code which is not hardware-dependent to sound/soc and rename
relevant sst_acpi_ structures and functions with snd_soc_acpi_ prefix

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../common/sst-acpi.h => include/sound/soc-acpi.h  | 44 ++++++++++-------
 sound/soc/Kconfig                                  |  3 ++
 sound/soc/Makefile                                 |  6 +++
 sound/soc/intel/Kconfig                            |  1 +
 sound/soc/intel/atom/sst/sst_acpi.c                | 24 +++++-----
 sound/soc/intel/boards/bytcht_da7213.c             |  6 +--
 sound/soc/intel/boards/bytcht_es8316.c             |  2 +-
 sound/soc/intel/boards/bytcr_rt5640.c              | 11 +++--
 sound/soc/intel/boards/bytcr_rt5651.c              |  8 ++--
 sound/soc/intel/boards/cht_bsw_rt5645.c            | 11 +++--
 sound/soc/intel/boards/cht_bsw_rt5672.c            |  7 +--
 sound/soc/intel/common/Makefile                    |  2 -
 sound/soc/intel/common/sst-acpi.c                  | 18 +++----
 sound/soc/intel/skylake/skl.c                      | 40 ++++++++--------
 .../{intel/common/sst-match-acpi.c => soc-acpi.c}  | 56 +++++++++++-----------
 15 files changed, 130 insertions(+), 109 deletions(-)
 rename sound/soc/intel/common/sst-acpi.h => include/sound/soc-acpi.h (55%)
 rename sound/soc/{intel/common/sst-match-acpi.c => soc-acpi.c} (63%)

diff --git a/sound/soc/intel/common/sst-acpi.h b/include/sound/soc-acpi.h
similarity index 55%
rename from sound/soc/intel/common/sst-acpi.h
rename to include/sound/soc-acpi.h
index afe9b87..75fb32e 100644
--- a/sound/soc/intel/common/sst-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -12,10 +12,13 @@
  *
  */
 
+#ifndef __LINUX_SND_SOC_ACPI_H
+#define __LINUX_SND_SOC_ACPI_H
+
 #include <linux/stddef.h>
 #include <linux/acpi.h>
 
-struct sst_acpi_package_context {
+struct snd_soc_acpi_package_context {
 	char *name;           /* package name */
 	int length;           /* number of elements */
 	struct acpi_buffer *format;
@@ -25,29 +28,32 @@ struct sst_acpi_package_context {
 
 #if IS_ENABLED(CONFIG_ACPI)
 /* translation fron HID to I2C name, needed for DAI codec_name */
-const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN]);
-bool sst_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
-				    struct sst_acpi_package_context *ctx);
+const char *snd_soc_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN]);
+bool snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
+				    struct snd_soc_acpi_package_context *ctx);
 #else
-static inline const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
+static inline const char *
+snd_soc_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
 {
 	return NULL;
 }
-static inline bool sst_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
-					   struct sst_acpi_package_context *ctx)
+static inline bool
+snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
+				   struct snd_soc_acpi_package_context *ctx)
 {
 	return false;
 }
 #endif
 
 /* acpi match */
-struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines);
+struct snd_soc_acpi_mach *
+snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines);
 
 /* acpi check hid */
-bool sst_acpi_check_hid(const u8 hid[ACPI_ID_LEN]);
+bool snd_soc_acpi_check_hid(const u8 hid[ACPI_ID_LEN]);
 
 /* Descriptor for SST ASoC machine driver */
-struct sst_acpi_mach {
+struct snd_soc_acpi_mach {
 	/* ACPI ID for the matching machine driver. Audio codec for instance */
 	const u8 id[ACPI_ID_LEN];
 	/* machine driver name */
@@ -57,26 +63,28 @@ struct sst_acpi_mach {
 
 	/* board name */
 	const char *board;
-	struct sst_acpi_mach * (*machine_quirk)(void *arg);
+	struct snd_soc_acpi_mach * (*machine_quirk)(void *arg);
 	const void *quirk_data;
 	void *pdata;
 };
 
-#define SST_ACPI_MAX_CODECS 3
+#define SND_SOC_ACPI_MAX_CODECS 3
 
 /**
- * struct sst_codecs: Structure to hold secondary codec information apart from
- * the matched one, this data will be passed to the quirk function to match
- * with the ACPI detected devices
+ * struct snd_soc_acpi_codecs: Structure to hold secondary codec information
+ * apart from the matched one, this data will be passed to the quirk function
+ * to match with the ACPI detected devices
  *
  * @num_codecs: number of secondary codecs used in the platform
  * @codecs: holds the codec IDs
  *
  */
-struct sst_codecs {
+struct snd_soc_acpi_codecs {
 	int num_codecs;
-	u8 codecs[SST_ACPI_MAX_CODECS][ACPI_ID_LEN];
+	u8 codecs[SND_SOC_ACPI_MAX_CODECS][ACPI_ID_LEN];
 };
 
 /* check all codecs */
-struct sst_acpi_mach *sst_acpi_codec_list(void *arg);
+struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg);
+
+#endif
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index c0abad2..d227581 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -36,6 +36,9 @@ config SND_SOC_COMPRESS
 config SND_SOC_TOPOLOGY
 	bool
 
+config SND_SOC_ACPI
+	tristate
+
 # All the supported SoCs
 source "sound/soc/adi/Kconfig"
 source "sound/soc/amd/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 39c27a5..95f2a73 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -14,6 +14,12 @@ ifneq ($(CONFIG_SND_SOC_AC97_BUS),)
 snd-soc-core-objs += soc-ac97.o
 endif
 
+ifneq ($(CONFIG_SND_SOC_ACPI),)
+snd-soc-acpi-objs := soc-acpi.o
+endif
+
+obj-$(CONFIG_SND_SOC_ACPI) += snd-soc-acpi.o
+
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/
 obj-$(CONFIG_SND_SOC)	+= generic/
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index b3c7f55..d03199c 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -41,6 +41,7 @@ config SND_SOC_INTEL_SST_ACPI
 
 config SND_SOC_INTEL_SST_MATCH
 	tristate
+	select SND_SOC_ACPI if ACPI
 
 config SND_SOC_INTEL_HASWELL
 	tristate
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index ff4a517..f69977f 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -41,9 +41,9 @@
 #include <acpi/acpi_bus.h>
 #include <asm/cpu_device_id.h>
 #include <asm/iosf_mbi.h>
+#include <sound/soc-acpi.h>
 #include "../sst-mfld-platform.h"
 #include "../../common/sst-dsp.h"
-#include "../../common/sst-acpi.h"
 #include "sst.h"
 
 /* LPE viewpoint addresses */
@@ -285,7 +285,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	int ret = 0;
 	struct intel_sst_drv *ctx;
 	const struct acpi_device_id *id;
-	struct sst_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach;
 	struct platform_device *mdev;
 	struct platform_device *plat_dev;
 	struct sst_platform_info *pdata;
@@ -297,8 +297,8 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	dev_dbg(dev, "for %s\n", id->id);
 
-	mach = (struct sst_acpi_mach *)id->driver_data;
-	mach = sst_acpi_find_machine(mach);
+	mach = (struct snd_soc_acpi_mach *)id->driver_data;
+	mach = snd_soc_acpi_find_machine(mach);
 	if (mach == NULL) {
 		dev_err(dev, "No matching machine driver found\n");
 		return -ENODEV;
@@ -436,7 +436,7 @@ static const struct dmi_system_id cht_table[] = {
 };
 
 
-static struct sst_acpi_mach cht_surface_mach = {
+static struct snd_soc_acpi_mach cht_surface_mach = {
 	.id = "10EC5640",
 	.drv_name = "cht-bsw-rt5645",
 	.fw_filename = "intel/fw_sst_22a8.bin",
@@ -444,7 +444,7 @@ static struct sst_acpi_mach cht_surface_mach = {
 	.pdata = &chv_platform_data,
 };
 
-static struct sst_acpi_mach byt_thinkpad_10 = {
+static struct snd_soc_acpi_mach byt_thinkpad_10 = {
 	.id = "10EC5640",
 	.drv_name = "cht-bsw-rt5672",
 	.fw_filename = "intel/fw_sst_0f28.bin",
@@ -452,9 +452,9 @@ static struct sst_acpi_mach byt_thinkpad_10 = {
 	.pdata = &byt_rvp_platform_data,
 };
 
-static struct sst_acpi_mach *cht_quirk(void *arg)
+static struct snd_soc_acpi_mach *cht_quirk(void *arg)
 {
-	struct sst_acpi_mach *mach = arg;
+	struct snd_soc_acpi_mach *mach = arg;
 
 	dmi_check_system(cht_table);
 
@@ -464,9 +464,9 @@ static struct sst_acpi_mach *cht_quirk(void *arg)
 		return mach;
 }
 
-static struct sst_acpi_mach *byt_quirk(void *arg)
+static struct snd_soc_acpi_mach *byt_quirk(void *arg)
 {
-	struct sst_acpi_mach *mach = arg;
+	struct snd_soc_acpi_mach *mach = arg;
 
 	dmi_check_system(byt_table);
 
@@ -477,7 +477,7 @@ static struct sst_acpi_mach *byt_quirk(void *arg)
 }
 
 
-static struct sst_acpi_mach sst_acpi_bytcr[] = {
+static struct snd_soc_acpi_mach sst_acpi_bytcr[] = {
 	{
 		.id = "10EC5640",
 		.drv_name = "bytcr_rt5640",
@@ -561,7 +561,7 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 };
 
 /* Cherryview-based platforms: CherryTrail and Braswell */
-static struct sst_acpi_mach sst_acpi_chv[] = {
+static struct snd_soc_acpi_mach sst_acpi_chv[] = {
 	{
 		.id = "10EC5670",
 		.drv_name = "cht-bsw-rt5672",
diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index 18873e2..ee8f8e5 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -27,9 +27,9 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-acpi.h>
 #include "../../codecs/da7213.h"
 #include "../atom/sst-atom-controls.h"
-#include "../common/sst-acpi.h"
 
 static const struct snd_kcontrol_new controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
@@ -234,7 +234,7 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 	int ret_val = 0;
 	int i;
 	struct snd_soc_card *card;
-	struct sst_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
 	int dai_index = 0;
 
@@ -252,7 +252,7 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = sst_acpi_find_name_from_hid(mach->id);
+	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
 	if (i2c_name != NULL) {
 		snprintf(codec_name, sizeof(codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 5263546..4e1d9a5 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -29,8 +29,8 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-acpi.h>
 #include "../atom/sst-atom-controls.h"
-#include "../common/sst-acpi.h"
 #include "../common/sst-dsp.h"
 
 struct byt_cht_es8316_private {
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 7cee09d..09f755b 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -32,9 +32,9 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
+#include <sound/soc-acpi.h>
 #include "../../codecs/rt5640.h"
 #include "../atom/sst-atom-controls.h"
-#include "../common/sst-acpi.h"
 #include "../common/sst-dsp.h"
 
 enum {
@@ -759,7 +759,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
-	struct sst_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
 	int i;
 	int dai_index;
@@ -785,7 +785,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = sst_acpi_find_name_from_hid(mach->id);
+	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
 	if (i2c_name != NULL) {
 		snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
 			"%s%s", "i2c-", i2c_name);
@@ -819,7 +819,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		/* format specified: 2 64-bit integers */
 		struct acpi_buffer format = {sizeof("NN"), "NN"};
 		struct acpi_buffer state = {0, NULL};
-		struct sst_acpi_package_context pkg_ctx;
+		struct snd_soc_acpi_package_context pkg_ctx;
 		bool pkg_found = false;
 
 		state.length = sizeof(chan_package);
@@ -831,7 +831,8 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		pkg_ctx.state = &state;
 		pkg_ctx.data_valid = false;
 
-		pkg_found = sst_acpi_find_package_from_hid(mach->id, &pkg_ctx);
+		pkg_found = snd_soc_acpi_find_package_from_hid(mach->id,
+							       &pkg_ctx);
 		if (pkg_found) {
 			if (chan_package.aif_value == 1) {
 				dev_info(&pdev->dev, "BIOS Routing: AIF1 connected\n");
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index e4ece0b9..99156ef 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -31,9 +31,9 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
+#include <sound/soc-acpi.h>
 #include "../../codecs/rt5651.h"
 #include "../atom/sst-atom-controls.h"
-#include "../common/sst-acpi.h"
 
 enum {
 	BYT_RT5651_DMIC_MAP,
@@ -450,7 +450,7 @@ static char byt_rt5651_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
-	struct sst_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
 	int i;
 	int dai_index;
@@ -474,7 +474,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = sst_acpi_find_name_from_hid(mach->id);
+	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
 	if (i2c_name != NULL) {
 		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
 			"%s%s", "i2c-", i2c_name);
@@ -495,7 +495,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = sst_acpi_find_name_from_hid(mach->id);
+	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
 	if (i2c_name != NULL) {
 		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
 			"%s%s", "i2c-", i2c_name);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index d553e2b..434fce1 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -32,9 +32,9 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
+#include <sound/soc-acpi.h>
 #include "../../codecs/rt5645.h"
 #include "../atom/sst-atom-controls.h"
-#include "../common/sst-acpi.h"
 
 #define CHT_PLAT_CLK_3_HZ	19200000
 #define CHT_CODEC_DAI1	"rt5645-aif1"
@@ -549,7 +549,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	int i;
 	struct cht_mc_private *drv;
 	struct snd_soc_card *card = snd_soc_cards[0].soc_card;
-	struct sst_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
 	int dai_index = 0;
 	bool found = false;
@@ -589,7 +589,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		}
 
 	/* fixup codec name based on HID */
-	i2c_name = sst_acpi_find_name_from_hid(mach->id);
+	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
 	if (i2c_name != NULL) {
 		snprintf(cht_rt5645_codec_name, sizeof(cht_rt5645_codec_name),
 			"%s%s", "i2c-", i2c_name);
@@ -622,7 +622,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		/* format specified: 2 64-bit integers */
 		struct acpi_buffer format = {sizeof("NN"), "NN"};
 		struct acpi_buffer state = {0, NULL};
-		struct sst_acpi_package_context pkg_ctx;
+		struct snd_soc_acpi_package_context pkg_ctx;
 		bool pkg_found = false;
 
 		state.length = sizeof(chan_package);
@@ -634,7 +634,8 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		pkg_ctx.state = &state;
 		pkg_ctx.data_valid = false;
 
-		pkg_found = sst_acpi_find_package_from_hid(mach->id, &pkg_ctx);
+		pkg_found = snd_soc_acpi_find_package_from_hid(mach->id,
+							       &pkg_ctx);
 		if (pkg_found) {
 			if (chan_package.aif_value == 1) {
 				dev_info(&pdev->dev, "BIOS Routing: AIF1 connected\n");
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index f799b76..0103c52 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -24,9 +24,10 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
+#include <sound/soc-acpi.h>
 #include "../../codecs/rt5670.h"
 #include "../atom/sst-atom-controls.h"
-#include "../common/sst-acpi.h"
+
 
 /* The platform clock #3 outputs 19.2Mhz clock to codec as I2S MCLK */
 #define CHT_PLAT_CLK_3_HZ	19200000
@@ -403,7 +404,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
 	struct cht_mc_private *drv;
-	struct sst_acpi_mach *mach = pdev->dev.platform_data;
+	struct snd_soc_acpi_mach *mach = pdev->dev.platform_data;
 	const char *i2c_name;
 	int i;
 
@@ -415,7 +416,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 
 	/* fixup codec name based on HID */
 	if (mach) {
-		i2c_name = sst_acpi_find_name_from_hid(mach->id);
+		i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
 		if (i2c_name) {
 			snprintf(drv->codec_name, sizeof(drv->codec_name),
 				 "i2c-%s", i2c_name);
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 1a35149..2c958ec 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -1,10 +1,8 @@
 snd-soc-sst-dsp-objs := sst-dsp.o
 snd-soc-sst-acpi-objs := sst-acpi.o
-snd-soc-sst-match-objs := sst-match-acpi.o
 snd-soc-sst-ipc-objs := sst-ipc.o
 snd-soc-sst-firmware-objs := sst-firmware.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
-obj-$(CONFIG_SND_SOC_INTEL_SST_MATCH) += snd-soc-sst-match.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_FIRMWARE) += snd-soc-sst-firmware.o
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 1285cc5..9866998 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -21,7 +21,7 @@
 #include <linux/platform_device.h>
 
 #include "sst-dsp.h"
-#include "sst-acpi.h"
+#include <sound/soc-acpi.h>
 
 #define SST_LPT_DSP_DMA_ADDR_OFFSET	0x0F0000
 #define SST_WPT_DSP_DMA_ADDR_OFFSET	0x0FE000
@@ -30,7 +30,7 @@
 /* Descriptor for setting up SST platform data */
 struct sst_acpi_desc {
 	const char *drv_name;
-	struct sst_acpi_mach *machines;
+	struct snd_soc_acpi_mach *machines;
 	/* Platform resource indexes. Must set to -1 if not used */
 	int resindex_lpe_base;
 	int resindex_pcicfg_base;
@@ -49,7 +49,7 @@ struct sst_acpi_priv {
 	struct platform_device *pdev_pcm;
 	struct sst_pdata sst_pdata;
 	struct sst_acpi_desc *desc;
-	struct sst_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach;
 };
 
 static void sst_acpi_fw_cb(const struct firmware *fw, void *context)
@@ -59,7 +59,7 @@ static void sst_acpi_fw_cb(const struct firmware *fw, void *context)
 	struct sst_acpi_priv *sst_acpi = platform_get_drvdata(pdev);
 	struct sst_pdata *sst_pdata = &sst_acpi->sst_pdata;
 	struct sst_acpi_desc *desc = sst_acpi->desc;
-	struct sst_acpi_mach *mach = sst_acpi->mach;
+	struct snd_soc_acpi_mach *mach = sst_acpi->mach;
 
 	sst_pdata->fw = fw;
 	if (!fw) {
@@ -85,7 +85,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sst_acpi_priv *sst_acpi;
 	struct sst_pdata *sst_pdata;
-	struct sst_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach;
 	struct sst_acpi_desc *desc;
 	struct resource *mmio;
 	int ret = 0;
@@ -99,7 +99,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	desc = (struct sst_acpi_desc *)id->driver_data;
-	mach = sst_acpi_find_machine(desc->machines);
+	mach = snd_soc_acpi_find_machine(desc->machines);
 	if (mach == NULL) {
 		dev_err(dev, "No matching ASoC machine driver found\n");
 		return -ENODEV;
@@ -179,7 +179,7 @@ static int sst_acpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct sst_acpi_mach haswell_machines[] = {
+static struct snd_soc_acpi_mach haswell_machines[] = {
 	{ "INT33CA", "haswell-audio", "intel/IntcSST1.bin", NULL, NULL, NULL },
 	{}
 };
@@ -197,7 +197,7 @@ static struct sst_acpi_desc sst_acpi_haswell_desc = {
 	.dma_size = SST_LPT_DSP_DMA_SIZE,
 };
 
-static struct sst_acpi_mach broadwell_machines[] = {
+static struct snd_soc_acpi_mach broadwell_machines[] = {
 	{ "INT343A", "broadwell-audio", "intel/IntcSST2.bin", NULL, NULL, NULL },
 	{ "RT5677CE", "bdw-rt5677", "intel/IntcSST2.bin", NULL, NULL, NULL },
 	{}
@@ -217,7 +217,7 @@ static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 };
 
 #if !IS_ENABLED(CONFIG_SND_SST_IPC_ACPI)
-static struct sst_acpi_mach baytrail_machines[] = {
+static struct snd_soc_acpi_mach baytrail_machines[] = {
 	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master", NULL, NULL, NULL },
 	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-48kHz_i2s_master", NULL, NULL, NULL },
 	{}
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index f94b484..aa4c655 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -28,7 +28,7 @@
 #include <linux/firmware.h>
 #include <linux/delay.h>
 #include <sound/pcm.h>
-#include "../common/sst-acpi.h"
+#include <sound/soc-acpi.h>
 #include <sound/hda_register.h>
 #include <sound/hdaudio.h>
 #include <sound/hda_i915.h>
@@ -439,10 +439,10 @@ static int skl_machine_device_register(struct skl *skl, void *driver_data)
 {
 	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
 	struct platform_device *pdev;
-	struct sst_acpi_mach *mach = driver_data;
+	struct snd_soc_acpi_mach *mach = driver_data;
 	int ret;
 
-	mach = sst_acpi_find_machine(mach);
+	mach = snd_soc_acpi_find_machine(mach);
 	if (mach == NULL) {
 		dev_err(bus->dev, "No matching machine driver found\n");
 		return -ENODEV;
@@ -875,33 +875,33 @@ static void skl_remove(struct pci_dev *pci)
 	dev_set_drvdata(&pci->dev, NULL);
 }
 
-static struct sst_codecs skl_codecs = {
+static struct snd_soc_acpi_codecs skl_codecs = {
 	.num_codecs = 1,
 	.codecs = {"10508825"}
 };
 
-static struct sst_codecs kbl_codecs = {
+static struct snd_soc_acpi_codecs kbl_codecs = {
 	.num_codecs = 1,
 	.codecs = {"10508825"}
 };
 
-static struct sst_codecs bxt_codecs = {
+static struct snd_soc_acpi_codecs bxt_codecs = {
 	.num_codecs = 1,
 	.codecs = {"MX98357A"}
 };
 
-static struct sst_codecs kbl_poppy_codecs = {
+static struct snd_soc_acpi_codecs kbl_poppy_codecs = {
 	.num_codecs = 1,
 	.codecs = {"10EC5663"}
 };
 
-static struct sst_codecs kbl_5663_5514_codecs = {
+static struct snd_soc_acpi_codecs kbl_5663_5514_codecs = {
 	.num_codecs = 2,
 	.codecs = {"10EC5663", "10EC5514"}
 };
 
 
-static struct sst_acpi_mach sst_skl_devdata[] = {
+static struct snd_soc_acpi_mach sst_skl_devdata[] = {
 	{
 		.id = "INT343A",
 		.drv_name = "skl_alc286s_i2s",
@@ -911,7 +911,7 @@ static struct sst_acpi_mach sst_skl_devdata[] = {
 		.id = "INT343B",
 		.drv_name = "skl_n88l25_s4567",
 		.fw_filename = "intel/dsp_fw_release.bin",
-		.machine_quirk = sst_acpi_codec_list,
+		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &skl_codecs,
 		.pdata = &skl_dmic_data
 	},
@@ -919,14 +919,14 @@ static struct sst_acpi_mach sst_skl_devdata[] = {
 		.id = "MX98357A",
 		.drv_name = "skl_n88l25_m98357a",
 		.fw_filename = "intel/dsp_fw_release.bin",
-		.machine_quirk = sst_acpi_codec_list,
+		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &skl_codecs,
 		.pdata = &skl_dmic_data
 	},
 	{}
 };
 
-static struct sst_acpi_mach sst_bxtp_devdata[] = {
+static struct snd_soc_acpi_mach sst_bxtp_devdata[] = {
 	{
 		.id = "INT343A",
 		.drv_name = "bxt_alc298s_i2s",
@@ -936,13 +936,13 @@ static struct sst_acpi_mach sst_bxtp_devdata[] = {
 		.id = "DLGS7219",
 		.drv_name = "bxt_da7219_max98357a_i2s",
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
-		.machine_quirk = sst_acpi_codec_list,
+		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &bxt_codecs,
 	},
 	{}
 };
 
-static struct sst_acpi_mach sst_kbl_devdata[] = {
+static struct snd_soc_acpi_mach sst_kbl_devdata[] = {
 	{
 		.id = "INT343A",
 		.drv_name = "kbl_alc286s_i2s",
@@ -952,7 +952,7 @@ static struct sst_acpi_mach sst_kbl_devdata[] = {
 		.id = "INT343B",
 		.drv_name = "kbl_n88l25_s4567",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
-		.machine_quirk = sst_acpi_codec_list,
+		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &kbl_codecs,
 		.pdata = &skl_dmic_data
 	},
@@ -960,7 +960,7 @@ static struct sst_acpi_mach sst_kbl_devdata[] = {
 		.id = "MX98357A",
 		.drv_name = "kbl_n88l25_m98357a",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
-		.machine_quirk = sst_acpi_codec_list,
+		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &kbl_codecs,
 		.pdata = &skl_dmic_data
 	},
@@ -968,7 +968,7 @@ static struct sst_acpi_mach sst_kbl_devdata[] = {
 		.id = "MX98927",
 		.drv_name = "kbl_r5514_5663_max",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
-		.machine_quirk = sst_acpi_codec_list,
+		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &kbl_5663_5514_codecs,
 		.pdata = &skl_dmic_data
 	},
@@ -976,7 +976,7 @@ static struct sst_acpi_mach sst_kbl_devdata[] = {
 		.id = "MX98927",
 		.drv_name = "kbl_rt5663_m98927",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
-		.machine_quirk = sst_acpi_codec_list,
+		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &kbl_poppy_codecs,
 		.pdata = &skl_dmic_data
 	},
@@ -989,7 +989,7 @@ static struct sst_acpi_mach sst_kbl_devdata[] = {
 	{}
 };
 
-static struct sst_acpi_mach sst_glk_devdata[] = {
+static struct snd_soc_acpi_mach sst_glk_devdata[] = {
 	{
 		.id = "INT343A",
 		.drv_name = "glk_alc298s_i2s",
@@ -998,7 +998,7 @@ static struct sst_acpi_mach sst_glk_devdata[] = {
 	{}
 };
 
-static const struct sst_acpi_mach sst_cnl_devdata[] = {
+static const struct snd_soc_acpi_mach sst_cnl_devdata[] = {
 	{
 		.id = "INT34C2",
 		.drv_name = "cnl_rt274",
diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/soc-acpi.c
similarity index 63%
rename from sound/soc/intel/common/sst-match-acpi.c
rename to sound/soc/soc-acpi.c
index 56d26f3..f21df28 100644
--- a/sound/soc/intel/common/sst-match-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -1,5 +1,5 @@
 /*
- * sst_match_apci.c - SST (LPE) match for ACPI enumeration.
+ * soc-apci.c - support for ACPI enumeration.
  *
  * Copyright (c) 2013-15, Intel Corporation.
  *
@@ -14,9 +14,9 @@
  * more details.
  */
 
-#include "sst-acpi.h"
+#include <sound/soc-acpi.h>
 
-static acpi_status sst_acpi_find_name(acpi_handle handle, u32 level,
+static acpi_status snd_soc_acpi_find_name(acpi_handle handle, u32 level,
 				      void *context, void **ret)
 {
 	struct acpi_device *adev;
@@ -34,12 +34,12 @@ static acpi_status sst_acpi_find_name(acpi_handle handle, u32 level,
 	return AE_OK;
 }
 
-const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
+const char *snd_soc_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
 {
 	const char *name = NULL;
 	acpi_status status;
 
-	status = acpi_get_devices(hid, sst_acpi_find_name, NULL,
+	status = acpi_get_devices(hid, snd_soc_acpi_find_name, NULL,
 				  (void **)&name);
 
 	if (ACPI_FAILURE(status) || name[0] == '\0')
@@ -47,9 +47,9 @@ const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
 
 	return name;
 }
-EXPORT_SYMBOL_GPL(sst_acpi_find_name_from_hid);
+EXPORT_SYMBOL_GPL(snd_soc_acpi_find_name_from_hid);
 
-static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
+static acpi_status snd_soc_acpi_mach_match(acpi_handle handle, u32 level,
 				       void *context, void **ret)
 {
 	unsigned long long sta;
@@ -63,26 +63,27 @@ static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
 	return AE_OK;
 }
 
-bool sst_acpi_check_hid(const u8 hid[ACPI_ID_LEN])
+bool snd_soc_acpi_check_hid(const u8 hid[ACPI_ID_LEN])
 {
 	acpi_status status;
 	bool found = false;
 
-	status = acpi_get_devices(hid, sst_acpi_mach_match, &found, NULL);
+	status = acpi_get_devices(hid, snd_soc_acpi_mach_match, &found, NULL);
 
 	if (ACPI_FAILURE(status))
 		return false;
 
 	return found;
 }
-EXPORT_SYMBOL_GPL(sst_acpi_check_hid);
+EXPORT_SYMBOL_GPL(snd_soc_acpi_check_hid);
 
-struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines)
+struct snd_soc_acpi_mach *
+snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
 {
-	struct sst_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach;
 
 	for (mach = machines; mach->id[0]; mach++) {
-		if (sst_acpi_check_hid(mach->id) == true) {
+		if (snd_soc_acpi_check_hid(mach->id) == true) {
 			if (mach->machine_quirk == NULL)
 				return mach;
 
@@ -92,14 +93,14 @@ struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(sst_acpi_find_machine);
+EXPORT_SYMBOL_GPL(snd_soc_acpi_find_machine);
 
-static acpi_status sst_acpi_find_package(acpi_handle handle, u32 level,
-					void *context, void **ret)
+static acpi_status snd_soc_acpi_find_package(acpi_handle handle, u32 level,
+					     void *context, void **ret)
 {
 	struct acpi_device *adev;
 	acpi_status status = AE_OK;
-	struct sst_acpi_package_context *pkg_ctx = context;
+	struct snd_soc_acpi_package_context *pkg_ctx = context;
 
 	pkg_ctx->data_valid = false;
 
@@ -137,37 +138,38 @@ static acpi_status sst_acpi_find_package(acpi_handle handle, u32 level,
 	return AE_OK;
 }
 
-bool sst_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
-				struct sst_acpi_package_context *ctx)
+bool snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
+				struct snd_soc_acpi_package_context *ctx)
 {
 	acpi_status status;
 
-	status = acpi_get_devices(hid, sst_acpi_find_package, ctx, NULL);
+	status = acpi_get_devices(hid, snd_soc_acpi_find_package, ctx, NULL);
 
 	if (ACPI_FAILURE(status) || !ctx->data_valid)
 		return false;
 
 	return true;
 }
-EXPORT_SYMBOL_GPL(sst_acpi_find_package_from_hid);
+EXPORT_SYMBOL_GPL(snd_soc_acpi_find_package_from_hid);
 
-struct sst_acpi_mach *sst_acpi_codec_list(void *arg)
+struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
 {
-	struct sst_acpi_mach *mach = arg;
-	struct sst_codecs *codec_list = (struct sst_codecs *) mach->quirk_data;
+	struct snd_soc_acpi_mach *mach = arg;
+	struct snd_soc_acpi_codecs *codec_list =
+		(struct snd_soc_acpi_codecs *) mach->quirk_data;
 	int i;
 
 	if (mach->quirk_data == NULL)
 		return mach;
 
 	for (i = 0; i < codec_list->num_codecs; i++) {
-		if (sst_acpi_check_hid(codec_list->codecs[i]) != true)
+		if (snd_soc_acpi_check_hid(codec_list->codecs[i]) != true)
 			return NULL;
 	}
 
 	return mach;
 }
-EXPORT_SYMBOL_GPL(sst_acpi_codec_list);
+EXPORT_SYMBOL_GPL(snd_soc_acpi_codec_list);
 
 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Intel Common ACPI Match module");
+MODULE_DESCRIPTION("ALSA SoC ACPI module");
-- 
2.9.3
