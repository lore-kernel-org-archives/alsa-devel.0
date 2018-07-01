From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 3/3] ASoC: Intel: bytcr_rt5651: Add support
	for externar amplifier enable GPIO
Date: Sun,  1 Jul 2018 20:36:31 +0200
Message-ID: <20180701183631.5532-3-hdegoede@redhat.com>
References: <20180701183631.5532-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BBAC26771A
 for <alsa-devel@alsa-project.org>; Sun,  1 Jul 2018 20:36:36 +0200 (CEST)
In-Reply-To: <20180701183631.5532-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

The rt5651 does not have a built-in speaker amplifier, so it is often
used together with an external amplifier. On Cherry Trail boards this
external amplifier's enable pin is driven through a GPIO, which is
given as the first GPIO in the ACPI resources of the codec fwnode.

This commit adds support to the bytcr_rt5651 for this GPIO, fixing
the speaker not working on CHT devices with a rt5651 codec.

Cc: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Handle the ext amp GPIO entirely in the machine driver, the ext-amp is
 not part of the codec, so it should not be controlled by the codec driver
---
 sound/soc/intel/boards/bytcr_rt5651.c | 65 +++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index d920725ce603..5301205496be 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -26,6 +26,8 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -86,6 +88,7 @@ enum {
 
 struct byt_rt5651_private {
 	struct clk *mclk;
+	struct gpio_desc *ext_amp_gpio;
 	struct snd_soc_jack jack;
 };
 
@@ -208,6 +211,20 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5651_ext_amp_power_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_card *card = w->dapm->card;
+	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		gpiod_set_value_cansleep(priv->ext_amp_gpio, 1);
+	else
+		gpiod_set_value_cansleep(priv->ext_amp_gpio, 0);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget byt_rt5651_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -217,7 +234,9 @@ static const struct snd_soc_dapm_widget byt_rt5651_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			    platform_clock_control, SND_SOC_DAPM_PRE_PMU |
 			    SND_SOC_DAPM_POST_PMD),
-
+	SND_SOC_DAPM_SUPPLY("Ext Amp Power", SND_SOC_NOPM, 0, 0,
+			    rt5651_ext_amp_power_event,
+			    SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
@@ -225,6 +244,7 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 	{"Headset Mic", NULL, "Platform Clock"},
 	{"Internal Mic", NULL, "Platform Clock"},
 	{"Speaker", NULL, "Platform Clock"},
+	{"Speaker", NULL, "Ext Amp Power"},
 	{"Line In", NULL, "Platform Clock"},
 
 	{"Headset Mic", NULL, "micbias1"}, /* lowercase for rt5651 */
@@ -678,6 +698,18 @@ static const struct x86_cpu_id baytrail_cpu_ids[] = {
 	{}
 };
 
+static const struct x86_cpu_id cherrytrail_cpu_ids[] = {
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_AIRMONT },     /* Braswell */
+	{}
+};
+
+static const struct acpi_gpio_params ext_amp_enable_gpios = { 0, 0, false };
+
+static const struct acpi_gpio_mapping byt_rt5651_gpios[] = {
+	{ "ext-amp-enable-gpios", &ext_amp_enable_gpios, 1 },
+	{ },
+};
+
 struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 	u64 aif_value;       /* 1: AIF1, 2: AIF2 */
 	u64 mclock_value;    /* usually 25MHz (0x17d7940), ignored */
@@ -793,9 +825,36 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* Must be called before register_card, also see declaration comment. */
 	ret_val = byt_rt5651_add_codec_device_props(codec_dev);
-	put_device(codec_dev);
-	if (ret_val)
+	if (ret_val) {
+		put_device(codec_dev);
 		return ret_val;
+	}
+
+	/* Cherry Trail devices use an external amplifier enable gpio */
+	if (x86_match_cpu(cherrytrail_cpu_ids)) {
+		devm_acpi_dev_add_driver_gpios(codec_dev, byt_rt5651_gpios);
+		priv->ext_amp_gpio = devm_fwnode_get_index_gpiod_from_child(
+						&pdev->dev, "ext-amp-enable", 0,
+						codec_dev->fwnode,
+						GPIOD_OUT_LOW, "speaker-amp");
+		if (IS_ERR(priv->ext_amp_gpio)) {
+			ret_val = PTR_ERR(priv->ext_amp_gpio);
+			switch (ret_val) {
+			case -ENOENT:
+				priv->ext_amp_gpio = NULL;
+				break;
+			default:
+				dev_err(&pdev->dev, "Failed to get ext-amp-enable GPIO: %d\n",
+					ret_val);
+				/* fall through */
+			case -EPROBE_DEFER:
+				put_device(codec_dev);
+				return ret_val;
+			}
+		}
+	}
+
+	put_device(codec_dev);
 
 	log_quirks(&pdev->dev);
 
-- 
2.17.1
