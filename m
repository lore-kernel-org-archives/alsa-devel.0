From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/6] ASoC: ssm4567: Add OF device ID table
Date: Tue,  4 Apr 2017 15:26:26 -0400
Message-ID: <20170404192630.11408-3-javier@osg.samsung.com>
References: <20170404192630.11408-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170404192630.11408-1-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-ssm4567.ko | grep alias
alias:          acpi*:INT343B:*
alias:          i2c:ssm4567

After this patch:

$ modinfo sound/soc/codecs/snd-soc-ssm4567.ko | grep alias
alias:          acpi*:INT343B:*
alias:          of:N*T*Cadi,ssm4567C*
alias:          of:N*T*Cadi,ssm4567
alias:          i2c:ssm4567

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 sound/soc/codecs/ssm4567.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index 2bb5a11c9ba1..a622623e8558 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -485,6 +485,14 @@ static const struct i2c_device_id ssm4567_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ssm4567_i2c_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id ssm4567_of_match[] = {
+	{ .compatible = "adi,ssm4567", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ssm4567_of_match);
+#endif
+
 #ifdef CONFIG_ACPI
 
 static const struct acpi_device_id ssm4567_acpi_match[] = {
@@ -498,6 +506,7 @@ MODULE_DEVICE_TABLE(acpi, ssm4567_acpi_match);
 static struct i2c_driver ssm4567_driver = {
 	.driver = {
 		.name = "ssm4567",
+		.of_match_table = of_match_ptr(ssm4567_of_match),
 		.acpi_match_table = ACPI_PTR(ssm4567_acpi_match),
 	},
 	.probe = ssm4567_i2c_probe,
-- 
2.9.3
