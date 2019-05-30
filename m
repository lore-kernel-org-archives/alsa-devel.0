From: =?UTF-8?q?Kov=C3=A1cs=20Tam=C3=A1s?= <kepszlok@zohomail.eu>
Subject: [PATCH V2] ASoC: Intel: Baytrail: add quirk for Aegex
	10 (RU2) tablet
Date: Thu, 30 May 2019 20:52:45 +0200
Message-ID: <20190530185245.10872-1-kepszlok@zohomail.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender-pp-o92.zoho.eu (sender-pp-o92.zoho.eu [185.20.209.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A8ECF8072E
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 20:52:59 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This tablet has an incorrect acpi identifier just like
Thinkpad10 tablet, which is why it is trying to load the RT5640 driver
instead of the RT5762 driver. The RT5640 driver, on the other hand, checks
the hardware ID, so no driver are loaded during boot. This fix resolves to
load the RT5672 driver on this tablet during boot. It also provides the
correct IO configuration, like the jack detect mode 3, for 1.8V pullup. I
would like to thank Pierre-Louis Bossart for helping with this patch.

---
 sound/soc/codecs/rt5670.c                     | 14 +-------------
 .../intel/common/soc-acpi-intel-byt-match.c   | 19 +------------------
 2 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 37cce0439568..9a037108b1ae 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2882,18 +2882,6 @@ static const struct dmi_system_id dmi_platform_intel_quirks[] = {
 						 RT5670_DEV_GPIO |
 						 RT5670_JD_MODE3),
 	},
-	{
-		.callback = rt5670_quirk_cb,
-		.ident = "Aegex 10 tablet (RU2)",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "AEGEX"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "RU2"),
-		},
-		.driver_data = (unsigned long *)(RT5670_DMIC_EN |
-						 RT5670_DMIC2_INR |
-						 RT5670_DEV_GPIO |
-						 RT5670_JD_MODE3),
-	},
 	{}
 };
 
diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index cfed58c23e0b..fe812a909db4 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -22,7 +22,6 @@ static unsigned long byt_machine_id;
 
 #define BYT_THINKPAD_10  1
 #define BYT_POV_P1006W   2
-#define BYT_AEGEX_10     3
 
 static int byt_thinkpad10_quirk_cb(const struct dmi_system_id *id)
 {
@@ -36,12 +35,6 @@ static int byt_pov_p1006w_quirk_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
-static int byt_aegex10_quirk_cb(const struct dmi_system_id *id)
-{
-	byt_machine_id = BYT_AEGEX_10;
-	return 1;
-}
-
 static const struct dmi_system_id byt_table[] = {
 	{
 		.callback = byt_thinkpad10_quirk_cb,
@@ -82,18 +75,9 @@ static const struct dmi_system_id byt_table[] = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "0E57"),
 		},
 	},
-	{
-		/* Aegex 10 tablet (RU2) */
-		.callback = byt_aegex10_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "AEGEX"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "RU2"),
-		},
-	},
 	{ }
 };
 
-/* The Thinkapd 10 and Aegex 10 tablets have the same ID problem */
 static struct snd_soc_acpi_mach byt_thinkpad_10 = {
 	.id = "10EC5640",
 	.drv_name = "cht-bsw-rt5672",
@@ -120,7 +104,6 @@ static struct snd_soc_acpi_mach *byt_quirk(void *arg)
 
 	switch (byt_machine_id) {
 	case BYT_THINKPAD_10:
-	case BYT_AEGEX_10:
 		return &byt_thinkpad_10;
 	case BYT_POV_P1006W:
 		return &byt_pov_p1006w;
