From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Move platform code to board
	file" to the asoc tree
Date: Fri, 16 Jun 2017 17:53:00 +0100
Message-ID: <E1dLuUW-0003wx-Kz@debutante>
References: <20170615124638.65971-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 74A0A2673C9
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 18:53:14 +0200 (CEST)
In-Reply-To: <20170615124638.65971-3-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, John Keeping <john@metanate.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677: Move platform code to board file

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

>From 55e59aa0525a461abcbc226ace7a7eb9d9a07a4a Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 15 Jun 2017 15:46:37 +0300
Subject: [PATCH] ASoC: rt5677: Move platform code to board file

GPIO ACPI mapping table is defined on platform basis. Codec driver
shouldn't have known what platform is using it.

Make codec driver more generic by moving platform code to where it
belongs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c           | 26 --------------------------
 sound/soc/intel/boards/bdw-rt5677.c | 27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 64cf6cc41ad1..36e530a36c82 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -41,15 +41,6 @@
 
 #define RT5677_PR_BASE (RT5677_PR_RANGE_BASE + (0 * RT5677_PR_SPACING))
 
-/* GPIO indexes defined by ACPI */
-enum {
-	RT5677_GPIO_PLUG_DET		= 0,
-	RT5677_GPIO_MIC_PRESENT_L	= 1,
-	RT5677_GPIO_HOTWORD_DET_L	= 2,
-	RT5677_GPIO_DSP_INT		= 3,
-	RT5677_GPIO_HP_AMP_SHDN_L	= 4,
-};
-
 static const struct regmap_range_cfg rt5677_ranges[] = {
 	{
 		.name = "PR",
@@ -5048,28 +5039,11 @@ static const struct acpi_device_id rt5677_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5677_acpi_match);
 #endif
 
-static const struct acpi_gpio_params plug_det_gpio = { RT5677_GPIO_PLUG_DET, 0, false };
-static const struct acpi_gpio_params mic_present_gpio = { RT5677_GPIO_MIC_PRESENT_L, 0, false };
-static const struct acpi_gpio_params headphone_enable_gpio = { RT5677_GPIO_HP_AMP_SHDN_L, 0, false };
-
-static const struct acpi_gpio_mapping bdw_rt5677_gpios[] = {
-	{ "plug-det-gpios", &plug_det_gpio, 1 },
-	{ "mic-present-gpios", &mic_present_gpio, 1 },
-	{ "headphone-enable-gpios", &headphone_enable_gpio, 1 },
-	{ NULL },
-};
-
 static void rt5677_read_acpi_properties(struct rt5677_priv *rt5677,
 		struct device *dev)
 {
-	int ret;
 	u32 val;
 
-	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(dev),
-			bdw_rt5677_gpios);
-	if (ret)
-		dev_warn(dev, "Failed to add driver gpios\n");
-
 	if (!device_property_read_u32(dev, "DCLK", &val))
 		rt5677->pdata.dmic2_clk_pin = val;
 
diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index 14d9693c1641..bb98e94dd6f9 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -16,6 +16,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
@@ -120,6 +121,26 @@ static struct snd_soc_jack_gpio mic_jack_gpio = {
 	.invert			= 1,
 };
 
+/* GPIO indexes defined by ACPI */
+enum {
+	RT5677_GPIO_PLUG_DET		= 0,
+	RT5677_GPIO_MIC_PRESENT_L	= 1,
+	RT5677_GPIO_HOTWORD_DET_L	= 2,
+	RT5677_GPIO_DSP_INT		= 3,
+	RT5677_GPIO_HP_AMP_SHDN_L	= 4,
+};
+
+static const struct acpi_gpio_params plug_det_gpio = { RT5677_GPIO_PLUG_DET, 0, false };
+static const struct acpi_gpio_params mic_present_gpio = { RT5677_GPIO_MIC_PRESENT_L, 0, false };
+static const struct acpi_gpio_params headphone_enable_gpio = { RT5677_GPIO_HP_AMP_SHDN_L, 0, false };
+
+static const struct acpi_gpio_mapping bdw_rt5677_gpios[] = {
+	{ "plug-det-gpios", &plug_det_gpio, 1 },
+	{ "mic-present-gpios", &mic_present_gpio, 1 },
+	{ "headphone-enable-gpios", &headphone_enable_gpio, 1 },
+	{ NULL },
+};
+
 static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_hw_params *params)
 {
@@ -184,6 +205,12 @@ static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
 			snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	int ret;
+
+	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(codec->dev),
+			bdw_rt5677_gpios);
+	if (ret)
+		dev_warn(codec->dev, "Failed to add driver gpios\n");
 
 	/* Enable codec ASRC function for Stereo DAC/Stereo1 ADC/DMIC/I2S1.
 	 * The ASRC clock source is clk_i2s1_asrc.
-- 
2.11.0
