From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 2/2] ASoC: acpi: remove hard-coded
	i2c-device name length
Date: Thu, 11 Jan 2018 13:52:09 -0600
Message-ID: <20180111195209.5809-3-pierre-louis.bossart@linux.intel.com>
References: <20180111195209.5809-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 32C4B267930
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 20:52:39 +0100 (CET)
In-Reply-To: <20180111195209.5809-1-pierre-louis.bossart@linux.intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jeremy@jcline.org, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Remove hard-codec [16] array size, replace with clearer description and
dependency on ACPI_ID_LEN
No functionality change

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-acpi.h                | 3 +++
 sound/soc/intel/boards/bytcht_da7213.c  | 2 +-
 sound/soc/intel/boards/bytcht_es8316.c  | 2 +-
 sound/soc/intel/boards/bytcr_rt5640.c   | 2 +-
 sound/soc/intel/boards/bytcr_rt5651.c   | 2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c | 4 ++--
 sound/soc/intel/boards/cht_bsw_rt5672.c | 2 +-
 7 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index d1aaf876cd26..83320af8def2 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -27,6 +27,9 @@ struct snd_soc_acpi_package_context {
 	bool data_valid;
 };
 
+/* codec name is used in DAIs is i2c-<HID>:00 with HID being 8 chars */
+#define SND_ACPI_I2C_ID_LEN (4 + ACPI_ID_LEN + 3 + 1)
+
 #if IS_ENABLED(CONFIG_ACPI)
 /* translation fron HID to I2C name, needed for DAI codec_name */
 const char *snd_soc_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN]);
diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index c4d82ad41bd7..6219c04d4731 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -219,7 +219,7 @@ static struct snd_soc_card bytcht_da7213_card = {
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
-static char codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
+static char codec_name[SND_ACPI_I2C_ID_LEN];
 
 static int bytcht_da7213_probe(struct platform_device *pdev)
 {
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index ae24f6205f05..079f35cd4eaf 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -232,7 +232,7 @@ static struct snd_soc_card byt_cht_es8316_card = {
 	.fully_routed = true,
 };
 
-static char codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
+static char codec_name[SND_ACPI_I2C_ID_LEN];
 
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index f2c0fc415e52..4548f75498d0 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -713,7 +713,7 @@ static struct snd_soc_card byt_rt5640_card = {
 	.fully_routed = true,
 };
 
-static char byt_rt5640_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
+static char byt_rt5640_codec_name[SND_ACPI_I2C_ID_LEN];
 static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
 static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 22c9cc5d135e..5a6b7dedb773 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -509,7 +509,7 @@ static struct snd_soc_card byt_rt5651_card = {
 	.fully_routed = true,
 };
 
-static char byt_rt5651_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
+static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
 
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index f898ee140cdc..f368151678a8 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -49,7 +49,7 @@ struct cht_acpi_card {
 struct cht_mc_private {
 	struct snd_soc_jack jack;
 	struct cht_acpi_card *acpi_card;
-	char codec_name[16];
+	char codec_name[SND_ACPI_I2C_ID_LEN];
 	struct clk *mclk;
 };
 
@@ -506,7 +506,7 @@ static struct cht_acpi_card snd_soc_cards[] = {
 	{"10EC5650", CODEC_TYPE_RT5650, &snd_soc_card_chtrt5650},
 };
 
-static char cht_rt5645_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
+static char cht_rt5645_codec_name[SND_ACPI_I2C_ID_LEN];
 static char cht_rt5645_codec_aif_name[12]; /*  = "rt5645-aif[1|2]" */
 static char cht_rt5645_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index f8f21eee9b2d..1f3d38dc4fcb 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -35,7 +35,7 @@
 
 struct cht_mc_private {
 	struct snd_soc_jack headset;
-	char codec_name[16];
+	char codec_name[SND_ACPI_I2C_ID_LEN];
 	struct clk *mclk;
 };
 
-- 
2.14.1
