From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 3/3] ASoC: da7219: Add initial ACPI id for device
Date: Thu, 5 May 2016 11:53:06 +0100
Message-ID: <7ddf6d5b47424ca3777d33a9f91d30ea7c7c439a.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org

This adds "DLGS7219" ACPI id for the codec.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Tested-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
---
 sound/soc/codecs/da7219.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index bc32322..da268b8 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1428,6 +1428,12 @@ static const struct of_device_id da7219_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, da7219_of_match);

+static const struct acpi_device_id da7219_acpi_match[] = {
+	{ .id = "DLGS7219", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, da7219_acpi_match);
+
 static enum da7219_micbias_voltage
 	da7219_of_micbias_lvl(struct device *dev, u32 val)
 {
@@ -1957,6 +1963,7 @@ static struct i2c_driver da7219_i2c_driver = {
 	.driver = {
 		.name = "da7219",
 		.of_match_table = of_match_ptr(da7219_of_match),
+		.acpi_match_table = ACPI_PTR(da7219_acpi_match),
 	},
 	.probe		= da7219_i2c_probe,
 	.remove		= da7219_i2c_remove,
