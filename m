From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/6] ASoc: rt5645: Add OF device ID table
Date: Tue,  4 Apr 2017 15:26:25 -0400
Message-ID: <20170404192630.11408-2-javier@osg.samsung.com>
References: <20170404192630.11408-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170404192630.11408-1-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-rt5645.ko | grep alias
alias:          acpi*:10EC3270:*
alias:          acpi*:10EC5640:*
alias:          acpi*:10EC5650:*
alias:          acpi*:10EC5648:*
alias:          acpi*:10EC5645:*
alias:          i2c:rt5650
alias:          i2c:rt5645

After this patch:

$ modinfo sound/soc/codecs/snd-soc-rt5645.ko | grep alias
alias:          of:N*T*Crealtek,rt5650C*
alias:          of:N*T*Crealtek,rt5650
alias:          of:N*T*Crealtek,rt5645C*
alias:          of:N*T*Crealtek,rt5645
alias:          acpi*:10EC3270:*
alias:          acpi*:10EC5640:*
alias:          acpi*:10EC5650:*
alias:          acpi*:10EC5648:*
alias:          acpi*:10EC5645:*
alias:          i2c:rt5650
alias:          i2c:rt5645

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 sound/soc/codecs/rt5645.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e149f3ce5401..87844a45886a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3542,6 +3542,15 @@ static const struct i2c_device_id rt5645_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id rt5645_of_match[] = {
+	{ .compatible = "realtek,rt5645", },
+	{ .compatible = "realtek,rt5650", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5645_of_match);
+#endif
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5645", 0 },
@@ -3912,6 +3921,7 @@ static void rt5645_i2c_shutdown(struct i2c_client *i2c)
 static struct i2c_driver rt5645_i2c_driver = {
 	.driver = {
 		.name = "rt5645",
+		.of_match_table = of_match_ptr(rt5645_of_match),
 		.acpi_match_table = ACPI_PTR(rt5645_acpi_match),
 	},
 	.probe = rt5645_i2c_probe,
-- 
2.9.3
