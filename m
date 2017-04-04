From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 6/6] ASoC: rt5677: Add OF device ID table
Date: Tue,  4 Apr 2017 15:26:30 -0400
Message-ID: <20170404192630.11408-7-javier@osg.samsung.com>
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

$ modinfo sound/soc/codecs/snd-soc-rt5677.ko | grep alias
alias:          i2c:RT5677CE:00
alias:          i2c:rt5676
alias:          i2c:rt5677

After this patch:

$ modinfo sound/soc/codecs/snd-soc-rt5677.ko | grep alias
alias:          of:N*T*Crealtek,rt5677C*
alias:          of:N*T*Crealtek,rt5677
alias:          i2c:RT5677CE:00
alias:          i2c:rt5676
alias:          i2c:rt5677

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 sound/soc/codecs/rt5677.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index abc802a5a479..65ac4518ad06 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5035,6 +5035,12 @@ static const struct i2c_device_id rt5677_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
 
+static const struct of_device_id rt5677_of_match[] = {
+	{ .compatible = "realtek,rt5677", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5677_of_match);
+
 static const struct acpi_gpio_params plug_det_gpio = { RT5677_GPIO_PLUG_DET, 0, false };
 static const struct acpi_gpio_params mic_present_gpio = { RT5677_GPIO_MIC_PRESENT_L, 0, false };
 static const struct acpi_gpio_params headphone_enable_gpio = { RT5677_GPIO_HP_AMP_SHDN_L, 0, false };
@@ -5294,6 +5300,7 @@ static int rt5677_i2c_remove(struct i2c_client *i2c)
 static struct i2c_driver rt5677_i2c_driver = {
 	.driver = {
 		.name = "rt5677",
+		.of_match_table = rt5677_of_match,
 	},
 	.probe = rt5677_i2c_probe,
 	.remove   = rt5677_i2c_remove,
-- 
2.9.3
