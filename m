From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ASoC: rt298: Add DMI match for Broxton-P
	reference platform
Date: Thu, 12 May 2016 09:38:50 +0530
Message-ID: <1463026130-18651-2-git-send-email-vinod.koul@intel.com>
References: <1463026130-18651-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D9DC265068
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 06:03:00 +0200 (CEST)
In-Reply-To: <1463026130-18651-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Ramesh Babu <ramesh.babu@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Broxton-P reference platform also uses combo jack for audio
connector so we need to set codec pdata to use this based on DMI
match for this board.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/rt298.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 45dc5fa24961..f80cfe4d2ef2 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/dmi.h>
 #include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -1127,6 +1128,17 @@ static const struct acpi_device_id rt298_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, rt298_acpi_match);
 
+static const struct dmi_system_id force_combo_jack_table[] = {
+	{
+		.ident = "Intel Broxton P",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Broxton P")
+		}
+	},
+	{ }
+};
+
 static int rt298_i2c_probe(struct i2c_client *i2c,
 			   const struct i2c_device_id *id)
 {
@@ -1184,6 +1196,11 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 				acpiid->driver_data;
 	}
 
+	if (dmi_check_system(force_combo_jack_table)) {
+		rt298->pdata.cbj_en = true;
+		rt298->pdata.gpio2_en = false;
+	}
+
 	/* VREF Charging */
 	regmap_update_bits(rt298->regmap, 0x04, 0x80, 0x80);
 	regmap_update_bits(rt298->regmap, 0x1b, 0x860, 0x860);
-- 
1.9.1
