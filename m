From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: add ACPI support" to the asoc
	tree
Date: Mon, 13 Mar 2017 16:58:14 +0000
Message-ID: <E1cnTIU-00057u-8X@debutante>
References: <1489105142-25878-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2FE6266D16
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:58:25 +0100 (CET)
In-Reply-To: <1489105142-25878-2-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: vinod.koul@intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Adam.Thomson.Opensource@diasemi.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7213: add ACPI support

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

>From 8f42c23a9861df7796e019d32fd5c4dea01c8e51 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 9 Mar 2017 18:18:58 -0600
Subject: [PATCH] ASoC: da7213: add ACPI support

Add DLGS7212 and DLGS7213 HID

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7213.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 12da55882c06..6dd7578f0bb8 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -12,6 +12,7 @@
  * option) any later version.
  */
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -1528,12 +1529,23 @@ static int da7213_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+#if defined(CONFIG_OF)
 /* DT */
 static const struct of_device_id da7213_of_match[] = {
 	{ .compatible = "dlg,da7213", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da7213_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id da7213_acpi_match[] = {
+	{ "DLGS7212", 0},
+	{ "DLGS7213", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, da7213_acpi_match);
+#endif
 
 static enum da7213_micbias_voltage
 	da7213_of_micbias_lvl(struct snd_soc_codec *codec, u32 val)
@@ -1844,6 +1856,7 @@ static struct i2c_driver da7213_i2c_driver = {
 	.driver = {
 		.name = "da7213",
 		.of_match_table = of_match_ptr(da7213_of_match),
+		.acpi_match_table = ACPI_PTR(da7213_acpi_match),
 	},
 	.probe		= da7213_i2c_probe,
 	.remove		= da7213_remove,
-- 
2.11.0
