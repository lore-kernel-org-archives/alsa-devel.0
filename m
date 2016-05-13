From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt298: Add DMI match for Broxton-P
	reference platform" to the asoc tree
Date: Fri, 13 May 2016 08:59:06 +0100
Message-ID: <E1b1802-0004pE-HZ@debutante>
References: <1463026130-18651-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BFEE260438
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 09:59:14 +0200 (CEST)
In-Reply-To: <1463026130-18651-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Ramesh Babu <ramesh.babu@intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Bard Liao <bardliao@realtek.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt298: Add DMI match for Broxton-P reference platform

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

>From b9c17f13ba484d8492278c67cd95b7207def776f Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 12 May 2016 09:38:50 +0530
Subject: [PATCH] ASoC: rt298: Add DMI match for Broxton-P reference platform

Broxton-P reference platform also uses combo jack for audio
connector so we need to set codec pdata to use this based on DMI
match for this board.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 52aacb1d5e4c..a1aaffc20862 100644
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
@@ -1132,6 +1133,17 @@ static const struct acpi_device_id rt298_acpi_match[] = {
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
@@ -1189,6 +1201,11 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
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
2.8.1
