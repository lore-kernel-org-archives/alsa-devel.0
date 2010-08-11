From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 01/14] ASoC: multi-component - TI OMAP Platform
Date: Wed, 11 Aug 2010 09:46:20 +0100
Message-ID: <1281516393-6060-2-git-send-email-lrg@slimlogic.co.uk>
References: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F33AF103859
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 10:46:49 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 42so11847202wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 01:46:49 -0700 (PDT)
In-Reply-To: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Update the TI OMAP platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o Moved zoom2 audio platform data to board-zoom2.c
 o Moved n810 audio platform data to board-n810.c
 o Moved RX51 audio platform data to board-rx51-peripherals.c
 o Added ASoC DAI and DMA platform devices.
 o Misc fixes from Jarkko Nikula

CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 arch/arm/mach-omap1/devices.c                 |   26 +++++
 arch/arm/mach-omap2/board-n8x0.c              |   15 +++
 arch/arm/mach-omap2/board-rx51-peripherals.c  |   14 +++-
 arch/arm/mach-omap2/board-zoom2.c             |   28 +++++-
 arch/arm/mach-omap2/devices.c                 |   39 ++++++++
 arch/arm/mach-omap2/include/mach/board-zoom.h |    2 +
 arch/arm/plat-omap/include/plat/mcbsp.h       |    7 ++
 drivers/input/misc/twl4030-vibra.c            |    4 +-
 drivers/mfd/twl-core.c                        |    6 +-
 drivers/mfd/twl4030-codec.c                   |    8 +-
 include/linux/i2c/twl.h                       |    6 +-
 sound/soc/omap/am3517evm.c                    |   25 ++---
 sound/soc/omap/ams-delta.c                    |   53 ++++-------
 sound/soc/omap/igep0020.c                     |   22 ++---
 sound/soc/omap/mcpdm.c                        |   19 +----
 sound/soc/omap/mcpdm.h                        |    2 +
 sound/soc/omap/n810.c                         |   42 ++-------
 sound/soc/omap/omap-mcbsp.c                   |  123 ++++++++++++-------------
 sound/soc/omap/omap-mcbsp.h                   |    2 -
 sound/soc/omap/omap-mcpdm.c                   |   71 +++++++++-----
 sound/soc/omap/omap-mcpdm.h                   |   29 ------
 sound/soc/omap/omap-pcm.c                     |   47 +++++++---
 sound/soc/omap/omap-pcm.h                     |    2 -
 sound/soc/omap/omap2evm.c                     |   25 ++----
 sound/soc/omap/omap3beagle.c                  |   23 ++---
 sound/soc/omap/omap3evm.c                     |   30 ++-----
 sound/soc/omap/omap3pandora.c                 |   36 +++----
 sound/soc/omap/osk5912.c                      |   24 ++---
 sound/soc/omap/overo.c                        |   22 ++---
 sound/soc/omap/rx51.c                         |   37 +++-----
 sound/soc/omap/sdp3430.c                      |   56 +++++-------
 sound/soc/omap/sdp4430.c                      |   23 ++---
 sound/soc/omap/zoom2.c                        |   64 +++++--------
 33 files changed, 452 insertions(+), 480 deletions(-)
 delete mode 100644 sound/soc/omap/omap-mcpdm.h

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 379100c..eb98eb8 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -25,6 +25,7 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/omap7xx.h>
+#include <plat/mcbsp.h>
 
 /*-------------------------------------------------------------------------*/
 
@@ -267,6 +268,30 @@ static inline void omap_init_sti(void)
 static inline void omap_init_sti(void) {}
 #endif
 
+#if defined(CONFIG_SND_SOC) || defined(CONFIG_SND_SOC_MODULE)
+
+static struct platform_device omap_pcm = {
+	.name	= "omap-pcm-audio",
+	.id	= -1,
+};
+
+OMAP_MCBSP_PLATFORM_DEVICE(1);
+OMAP_MCBSP_PLATFORM_DEVICE(2);
+OMAP_MCBSP_PLATFORM_DEVICE(3);
+
+static void omap_init_audio(void)
+{
+	platform_device_register(&omap_mcbsp1);
+	platform_device_register(&omap_mcbsp2);
+	if (!cpu_is_omap7xx())
+		platform_device_register(&omap_mcbsp3);
+	platform_device_register(&omap_pcm);
+}
+
+#else
+static inline void omap_init_audio(void) {}
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -299,6 +324,7 @@ static int __init omap1_init_devices(void)
 	omap_init_rtc();
 	omap_init_spi100k();
 	omap_init_sti();
+	omap_init_audio();
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 3ccc34e..04df912 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -20,6 +20,7 @@
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/usb/musb.h>
+#include <sound/tlv320aic3x.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -612,11 +613,25 @@ static int n8x0_menelaus_late_init(struct device *dev)
 	return 0;
 }
 
+static struct aic3x_setup_data n810_aic33_setup = {
+	.gpio_func[0] = AIC3X_GPIO1_FUNC_DISABLED,
+	.gpio_func[1] = AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT,
+};
+
+static struct aic3x_pdata n810_aic33_data = {
+	.setup = &n810_aic33_setup,
+	.gpio_reset = -1,
+};
+
 static struct i2c_board_info __initdata n8x0_i2c_board_info_1[] = {
 	{
 		I2C_BOARD_INFO("menelaus", 0x72),
 		.irq = INT_24XX_SYS_NIRQ,
 	},
+	{
+		I2C_BOARD_INFO("tlv320aic3x", 0x1b),
+		.platform_data = &n810_aic33_data,
+	},
 };
 
 static struct menelaus_platform_data n8x0_menelaus_platform_data = {
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index abdf321..28978c0 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/mmc/host.h>
+#include <sound/tlv320aic3x.h>
 
 #include <plat/mcspi.h>
 #include <plat/mux.h>
@@ -686,7 +687,6 @@ static struct twl4030_power_data rx51_t2scripts_data __initdata = {
 };
 
 
-
 static struct twl4030_platform_data rx51_twldata __initdata = {
 	.irq_base		= TWL4030_IRQ_BASE,
 	.irq_end		= TWL4030_IRQ_END,
@@ -716,9 +716,21 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 	},
 };
 
+/* Audio setup data */
+static struct aic3x_setup_data rx51_aic34_setup = {
+	.gpio_func[0] = AIC3X_GPIO1_FUNC_DISABLED,
+	.gpio_func[1] = AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT,
+};
+
+static struct aic3x_pdata rx51_aic34_data = {
+	.setup = &rx51_aic34_setup,
+	.gpio_reset = 60,
+};
+
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
+		.platform_data = &rx51_aic34_data,
 	},
 };
 
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 803ef14..410fe00 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/i2c/twl.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -34,8 +35,11 @@ static void __init omap_zoom2_init_irq(void)
 	omap_gpio_init();
 }
 
-/* REVISIT: These audio entries can be removed once MFD code is merged */
-#if 0
+/* EXTMUTE callback function */
+void zoom2_set_hs_extmute(int mute)
+{
+	gpio_set_value(ZOOM2_HEADSET_EXTMUTE_GPIO, mute);
+}
 
 static struct twl4030_madc_platform_data zoom2_madc_data = {
 	.irq_line	= 1,
@@ -43,6 +47,9 @@ static struct twl4030_madc_platform_data zoom2_madc_data = {
 
 static struct twl4030_codec_audio_data zoom2_audio_data = {
 	.audio_mclk = 26000000,
+	.ramp_delay_value = 3,	/* 161 ms */
+	.hs_extmute = 1,
+	.set_hs_extmute = zoom2_set_hs_extmute,
 };
 
 static struct twl4030_codec_data zoom2_codec_data = {
@@ -64,10 +71,24 @@ static struct twl4030_platform_data zoom2_twldata = {
 	.vmmc1          = &zoom2_vmmc1,
 	.vmmc2          = &zoom2_vmmc2,
 	.vsim           = &zoom2_vsim,
+};
 
+static struct i2c_board_info __initdata zoom2_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl4030", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = INT_34XX_SYS_NIRQ,
+		.platform_data = &zoom2_twldata,
+	},
 };
 
-#endif
+static int __init omap3_zoom2_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 2600, zoom2_i2c_boardinfo,
+			ARRAY_SIZE(zoom2_i2c_boardinfo));
+	return 0;
+}
+
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
@@ -81,6 +102,7 @@ static void __init omap_zoom2_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	zoom_peripherals_init();
+	omap3_zoom2_i2c_init();
 	zoom_debugboard_init();
 }
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 03e6c9e..f9a5961 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -29,6 +29,7 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/dma.h>
+#include <plat/mcbsp.h>
 
 #include "mux.h"
 
@@ -289,6 +290,43 @@ static inline void omap_init_sti(void)
 static inline void omap_init_sti(void) {}
 #endif
 
+#if defined(CONFIG_SND_SOC) || defined(CONFIG_SND_SOC_MODULE)
+
+static struct platform_device omap_pcm = {
+	.name	= "omap-pcm-audio",
+	.id	= -1,
+};
+
+/*
+ * OMAP2420 has 2 McBSP ports
+ * OMAP2430 has 5 McBSP ports
+ * OMAP3 has 5 McBSP ports
+ * OMAP4 has 4 McBSP ports
+ */
+OMAP_MCBSP_PLATFORM_DEVICE(1);
+OMAP_MCBSP_PLATFORM_DEVICE(2);
+OMAP_MCBSP_PLATFORM_DEVICE(3);
+OMAP_MCBSP_PLATFORM_DEVICE(4);
+OMAP_MCBSP_PLATFORM_DEVICE(5);
+
+static void omap_init_audio(void)
+{
+	platform_device_register(&omap_mcbsp1);
+	platform_device_register(&omap_mcbsp2);
+	if (cpu_is_omap243x() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		platform_device_register(&omap_mcbsp3);
+		platform_device_register(&omap_mcbsp4);
+	}
+	if (cpu_is_omap243x() || cpu_is_omap34xx())
+		platform_device_register(&omap_mcbsp5);
+
+	platform_device_register(&omap_pcm);
+}
+
+#else
+static inline void omap_init_audio(void) {}
+#endif
+
 #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
 
 #include <plat/mcspi.h>
@@ -901,6 +939,7 @@ static int __init omap2_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_hsmmc_reset();
+	omap_init_audio();
 	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h b/arch/arm/mach-omap2/include/mach/board-zoom.h
index c93b29e..b6a010f 100644
--- a/arch/arm/mach-omap2/include/mach/board-zoom.h
+++ b/arch/arm/mach-omap2/include/mach/board-zoom.h
@@ -3,3 +3,5 @@
  */
 extern int __init zoom_debugboard_init(void);
 extern void __init zoom_peripherals_init(void);
+
+#define ZOOM2_HEADSET_EXTMUTE_GPIO	153
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index b4ff6a1..5b20103 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -30,6 +30,13 @@
 #include <mach/hardware.h>
 #include <plat/clock.h>
 
+/* macro for building platform_device for McBSP ports */
+#define OMAP_MCBSP_PLATFORM_DEVICE(port_nr)		\
+static struct platform_device omap_mcbsp##port_nr = {	\
+	.name	= "omap-mcbsp-dai",			\
+	.id	= OMAP_MCBSP##port_nr,			\
+}
+
 #define OMAP7XX_MCBSP1_BASE	0xfffb1000
 #define OMAP7XX_MCBSP2_BASE	0xfffb1800
 
diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 4f9b2af..014dd4a 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -271,7 +271,7 @@ static struct platform_driver twl4030_vibra_driver = {
 	.probe		= twl4030_vibra_probe,
 	.remove		= __devexit_p(twl4030_vibra_remove),
 	.driver		= {
-		.name	= "twl4030_codec_vibra",
+		.name	= "twl4030-vibra",
 		.owner	= THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm	= &twl4030_vibra_pm_ops,
@@ -291,7 +291,7 @@ static void __exit twl4030_vibra_exit(void)
 }
 module_exit(twl4030_vibra_exit);
 
-MODULE_ALIAS("platform:twl4030_codec_vibra");
+MODULE_ALIAS("platform:twl4030-vibra");
 
 MODULE_DESCRIPTION("TWL4030 Vibra driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 720e099..5d0fb60 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -698,17 +698,17 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 
 	if (twl_has_codec() && pdata->codec && twl_class_is_4030()) {
 		sub_chip_id = twl_map[TWL_MODULE_AUDIO_VOICE].sid;
-		child = add_child(sub_chip_id, "twl4030_codec",
+		child = add_child(sub_chip_id, "twl4030-audio",
 				pdata->codec, sizeof(*pdata->codec),
 				false, 0, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
 
-	/* Phoenix*/
+	/* Phoenix codec driver is probed directly atm */
 	if (twl_has_codec() && pdata->codec && twl_class_is_6030()) {
 		sub_chip_id = twl_map[TWL_MODULE_AUDIO_VOICE].sid;
-		child = add_child(sub_chip_id, "twl6040_codec",
+		child = add_child(sub_chip_id, "twl6040-codec",
 				pdata->codec, sizeof(*pdata->codec),
 				false, 0, 0);
 		if (IS_ERR(child))
diff --git a/drivers/mfd/twl4030-codec.c b/drivers/mfd/twl4030-codec.c
index add6f67..9a4b196 100644
--- a/drivers/mfd/twl4030-codec.c
+++ b/drivers/mfd/twl4030-codec.c
@@ -207,14 +207,14 @@ static int __devinit twl4030_codec_probe(struct platform_device *pdev)
 
 	if (pdata->audio) {
 		cell = &codec->cells[childs];
-		cell->name = "twl4030_codec_audio";
+		cell->name = "twl4030-codec";
 		cell->platform_data = pdata->audio;
 		cell->data_size = sizeof(*pdata->audio);
 		childs++;
 	}
 	if (pdata->vibra) {
 		cell = &codec->cells[childs];
-		cell->name = "twl4030_codec_vibra";
+		cell->name = "twl4030-vibra";
 		cell->platform_data = pdata->vibra;
 		cell->data_size = sizeof(*pdata->vibra);
 		childs++;
@@ -249,14 +249,14 @@ static int __devexit twl4030_codec_remove(struct platform_device *pdev)
 	return 0;
 }
 
-MODULE_ALIAS("platform:twl4030_codec");
+MODULE_ALIAS("platform:twl4030-audio");
 
 static struct platform_driver twl4030_codec_driver = {
 	.probe		= twl4030_codec_probe,
 	.remove		= __devexit_p(twl4030_codec_remove),
 	.driver		= {
 		.owner	= THIS_MODULE,
-		.name	= "twl4030_codec",
+		.name	= "twl4030-audio",
 	},
 };
 
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 6de90bf..4793d8a 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -553,8 +553,12 @@ extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts);
 extern int twl4030_remove_script(u8 flags);
 
 struct twl4030_codec_audio_data {
-	unsigned int	audio_mclk;
+	unsigned int audio_mclk; /* not used, will be removed */
+	unsigned int digimic_delay; /* in ms */
 	unsigned int ramp_delay_value;
+	unsigned int offset_cncl_path;
+	unsigned int check_defaults:1;
+	unsigned int reset_registers:1;
 	unsigned int hs_extmute:1;
 	void (*set_hs_extmute)(int mute);
 };
diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index 135901b..68bd902 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -40,8 +40,8 @@ static int am3517evm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
 	/* Set codec DAI configuration */
@@ -111,8 +111,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"MICIN", NULL, "Mic In"},
 };
 
-static int am3517evm_aic23_init(struct snd_soc_codec *codec)
+static int am3517evm_aic23_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+
 	/* Add am3517-evm specific widgets */
 	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
 				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
@@ -134,8 +136,10 @@ static int am3517evm_aic23_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link am3517evm_dai = {
 	.name = "TLV320AIC23",
 	.stream_name = "AIC23",
-	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &tlv320aic23_dai,
+	.cpu_dai_name ="omap-mcbsp-dai.0",
+	.codec_dai_name = "tlv320aic23-hifi",
+	.platform_name = "omap-pcm-audio",
+	.codec_name = "tlv320aic23-codec",
 	.init = am3517evm_aic23_init,
 	.ops = &am3517evm_ops,
 };
@@ -143,17 +147,10 @@ static struct snd_soc_dai_link am3517evm_dai = {
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_am3517evm = {
 	.name = "am3517evm",
-	.platform = &omap_soc_platform,
 	.dai_link = &am3517evm_dai,
 	.num_links = 1,
 };
 
-/* Audio subsystem */
-static struct snd_soc_device am3517evm_snd_devdata = {
-	.card = &snd_soc_am3517evm,
-	.codec_dev = &soc_codec_dev_tlv320aic23,
-};
-
 static struct platform_device *am3517evm_snd_device;
 
 static int __init am3517evm_soc_init(void)
@@ -172,9 +169,7 @@ static int __init am3517evm_soc_init(void)
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(am3517evm_snd_device, &am3517evm_snd_devdata);
-	am3517evm_snd_devdata.dev = &am3517evm_snd_device->dev;
-	*(unsigned int *)am3517evm_dai.cpu_dai->private_data = 0; /* McBSP1 */
+	platform_set_drvdata(am3517evm_snd_device, &snd_soc_am3517evm);
 
 	ret = platform_device_add(am3517evm_snd_device);
 	if (ret)
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index b0f618e..5481f12 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -323,7 +323,7 @@ static void cx81801_receive(struct tty_struct *tty,
 					ARRAY_SIZE(ams_delta_hook_switch_pins),
 					ams_delta_hook_switch_pins);
 		if (ret)
-			dev_warn(codec->socdev->card->dev,
+			dev_warn(codec->dev,
 				"Failed to link hook switch to DAPM pins, "
 				"will continue with hook switch unlinked.\n");
 
@@ -383,7 +383,7 @@ static int ams_delta_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 
 	/* Set cpu DAI configuration */
-	return snd_soc_dai_set_fmt(rtd->dai->cpu_dai,
+	return snd_soc_dai_set_fmt(rtd->cpu_dai,
 				   SND_SOC_DAIFMT_DSP_A |
 				   SND_SOC_DAIFMT_NB_NF |
 				   SND_SOC_DAIFMT_CBM_CFM);
@@ -398,7 +398,7 @@ static struct snd_soc_ops ams_delta_ops = {
 static int ams_delta_set_bias_level(struct snd_soc_card *card,
 					enum snd_soc_bias_level level)
 {
-	struct snd_soc_codec *codec = card->codec;
+	struct snd_soc_codec *codec = card->rtd->codec;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -461,18 +461,19 @@ static void ams_delta_shutdown(struct snd_pcm_substream *substream)
  * Card initialization
  */
 
-static int ams_delta_cx20442_init(struct snd_soc_codec *codec)
+static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_dai *codec_dai = codec->dai;
-	struct snd_soc_card *card = codec->socdev->card;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_card *card = rtd->card;
 	int ret;
 	/* Codec is ready, now add/activate board specific controls */
 
 	/* Set up digital mute if not provided by the codec */
-	if (!codec_dai->ops) {
-		codec_dai->ops = &ams_delta_dai_ops;
-	} else if (!codec_dai->ops->digital_mute) {
-		codec_dai->ops->digital_mute = ams_delta_digital_mute;
+	if (!codec_dai->driver->ops) {
+		codec_dai->driver->ops = &ams_delta_dai_ops;
+	} else if (!codec_dai->driver->ops->digital_mute) {
+		codec_dai->driver->ops->digital_mute = ams_delta_digital_mute;
 	} else {
 		ams_delta_ops.startup = ams_delta_startup;
 		ams_delta_ops.shutdown = ams_delta_shutdown;
@@ -483,7 +484,7 @@ static int ams_delta_cx20442_init(struct snd_soc_codec *codec)
 
 	/* Add hook switch - can be used to control the codec from userspace
 	 * even if line discipline fails */
-	ret = snd_soc_jack_new(card, "hook_switch",
+	ret = snd_soc_jack_new(rtd->codec, "hook_switch",
 				SND_JACK_HEADSET, &ams_delta_hook_switch);
 	if (ret)
 		dev_warn(card->dev,
@@ -551,27 +552,22 @@ static int ams_delta_cx20442_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link ams_delta_dai_link = {
 	.name = "CX20442",
 	.stream_name = "CX20442",
-	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &cx20442_dai,
+	.cpu_dai_name ="omap-mcbsp-dai.0",
+	.codec_dai_name = "cx20442-hifi",
 	.init = ams_delta_cx20442_init,
+	.platform_name = "omap-pcm-audio",
+	.codec_name = "cx20442-codec",
 	.ops = &ams_delta_ops,
 };
 
 /* Audio card driver */
 static struct snd_soc_card ams_delta_audio_card = {
 	.name = "AMS_DELTA",
-	.platform = &omap_soc_platform,
 	.dai_link = &ams_delta_dai_link,
 	.num_links = 1,
 	.set_bias_level = ams_delta_set_bias_level,
 };
 
-/* Audio subsystem */
-static struct snd_soc_device ams_delta_snd_soc_device = {
-	.card = &ams_delta_audio_card,
-	.codec_dev = &cx20442_codec_dev,
-};
-
 /* Module init/exit */
 static struct platform_device *ams_delta_audio_platform_device;
 static struct platform_device *cx20442_platform_device;
@@ -589,9 +585,7 @@ static int __init ams_delta_module_init(void)
 		return -ENOMEM;
 
 	platform_set_drvdata(ams_delta_audio_platform_device,
-				&ams_delta_snd_soc_device);
-	ams_delta_snd_soc_device.dev = &ams_delta_audio_platform_device->dev;
-	*(unsigned int *)ams_delta_dai_link.cpu_dai->private_data = OMAP_MCBSP1;
+				&ams_delta_audio_card);
 
 	ret = platform_device_add(ams_delta_audio_platform_device);
 	if (ret)
@@ -612,19 +606,6 @@ module_init(ams_delta_module_init);
 
 static void __exit ams_delta_module_exit(void)
 {
-	struct snd_soc_codec *codec;
-	struct tty_struct *tty;
-
-	if (ams_delta_audio_card.codec) {
-		codec = ams_delta_audio_card.codec;
-
-		if (codec->control_data) {
-			tty = codec->control_data;
-
-			tty_hangup(tty);
-		}
-	}
-
 	if (tty_unregister_ldisc(N_V253) != 0)
 		dev_warn(&ams_delta_audio_platform_device->dev,
 			"failed to unregister V253 line discipline\n");
diff --git a/sound/soc/omap/igep0020.c b/sound/soc/omap/igep0020.c
index 3583c42..d296cfc 100644
--- a/sound/soc/omap/igep0020.c
+++ b/sound/soc/omap/igep0020.c
@@ -33,14 +33,13 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 static int igep2_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
 	/* Set codec DAI configuration */
@@ -82,25 +81,20 @@ static struct snd_soc_ops igep2_ops = {
 static struct snd_soc_dai_link igep2_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
-	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+	.cpu_dai_name = "omap-mcbsp-dai.1",
+	.codec_dai_name = "twl4030-hifi",
+	.platform_name = "omap-pcm-audio",
+	.codec_name = "twl4030-codec",
 	.ops = &igep2_ops,
 };
 
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_card_igep2 = {
 	.name = "igep2",
-	.platform = &omap_soc_platform,
 	.dai_link = &igep2_dai,
 	.num_links = 1,
 };
 
-/* Audio subsystem */
-static struct snd_soc_device igep2_snd_devdata = {
-	.card = &snd_soc_card_igep2,
-	.codec_dev = &soc_codec_dev_twl4030,
-};
-
 static struct platform_device *igep2_snd_device;
 
 static int __init igep2_soc_init(void)
@@ -119,9 +113,7 @@ static int __init igep2_soc_init(void)
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(igep2_snd_device, &igep2_snd_devdata);
-	igep2_snd_devdata.dev = &igep2_snd_device->dev;
-	*(unsigned int *)igep2_dai.cpu_dai->private_data = 1; /* McBSP2 */
+	platform_set_drvdata(igep2_snd_device, &snd_soc_card_igep2);
 
 	ret = platform_device_add(igep2_snd_device);
 	if (ret)
diff --git a/sound/soc/omap/mcpdm.c b/sound/soc/omap/mcpdm.c
index 90b8bf7..928f037 100644
--- a/sound/soc/omap/mcpdm.c
+++ b/sound/soc/omap/mcpdm.c
@@ -402,7 +402,7 @@ int omap_mcpdm_set_offset(int offset1, int offset2)
 	return 0;
 }
 
-static int __devinit omap_mcpdm_probe(struct platform_device *pdev)
+int __devinit omap_mcpdm_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret = 0;
@@ -449,7 +449,7 @@ exit:
 	return ret;
 }
 
-static int __devexit omap_mcpdm_remove(struct platform_device *pdev)
+int __devexit omap_mcpdm_remove(struct platform_device *pdev)
 {
 	struct omap_mcpdm *mcpdm_ptr = platform_get_drvdata(pdev);
 
@@ -468,18 +468,3 @@ static int __devexit omap_mcpdm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver omap_mcpdm_driver = {
-	.probe = omap_mcpdm_probe,
-	.remove = __devexit_p(omap_mcpdm_remove),
-	.driver = {
-		.name = "omap-mcpdm",
-	},
-};
-
-static struct platform_device *omap_mcpdm_device;
-
-static int __init omap_mcpdm_init(void)
-{
-	return platform_driver_register(&omap_mcpdm_driver);
-}
-arch_initcall(omap_mcpdm_init);
diff --git a/sound/soc/omap/mcpdm.h b/sound/soc/omap/mcpdm.h
index 7bb326e..df3e16f 100644
--- a/sound/soc/omap/mcpdm.h
+++ b/sound/soc/omap/mcpdm.h
@@ -149,3 +149,5 @@ extern int omap_mcpdm_playback_close(struct omap_mcpdm_link *downlink);
 extern int omap_mcpdm_request(void);
 extern void omap_mcpdm_free(void);
 extern int omap_mcpdm_set_offset(int offset1, int offset2);
+int __devinit omap_mcpdm_probe(struct platform_device *pdev);
+int __devexit omap_mcpdm_remove(struct platform_device *pdev);
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 08e09d7..a3b6d89 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -97,7 +97,7 @@ static int n810_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 
 	snd_pcm_hw_constraint_minmax(runtime,
 				     SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
@@ -115,8 +115,8 @@ static int n810_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int err;
 
 	/* Set codec DAI configuration */
@@ -271,8 +271,9 @@ static const struct snd_kcontrol_new aic33_n810_controls[] = {
 		     n810_get_input, n810_set_input),
 };
 
-static int n810_aic33_init(struct snd_soc_codec *codec)
+static int n810_aic33_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	int err;
 
 	/* Not connected */
@@ -307,8 +308,10 @@ static int n810_aic33_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link n810_dai = {
 	.name = "TLV320AIC33",
 	.stream_name = "AIC33",
-	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &aic3x_dai,
+	.cpu_dai_name = "omap-mcbsp-dai.1",
+	.platform_name = "omap-pcm-audio",
+	.codec_name = "tlv320aic3x-codec.2-0018",
+	.codec_dai_name = "tlv320aic3x-hifi",
 	.init = n810_aic33_init,
 	.ops = &n810_ops,
 };
@@ -316,33 +319,12 @@ static struct snd_soc_dai_link n810_dai = {
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_n810 = {
 	.name = "N810",
-	.platform = &omap_soc_platform,
 	.dai_link = &n810_dai,
 	.num_links = 1,
 };
 
-/* Audio private data */
-static struct aic3x_setup_data n810_aic33_setup = {
-	.gpio_func[0] = AIC3X_GPIO1_FUNC_DISABLED,
-	.gpio_func[1] = AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT,
-};
-
-/* Audio subsystem */
-static struct snd_soc_device n810_snd_devdata = {
-	.card = &snd_soc_n810,
-	.codec_dev = &soc_codec_dev_aic3x,
-	.codec_data = &n810_aic33_setup,
-};
-
 static struct platform_device *n810_snd_device;
 
-/* temporary i2c device creation until this can be moved into the machine
- * support file.
-*/
-static struct i2c_board_info i2c_device[] = {
-	{ I2C_BOARD_INFO("tlv320aic3x", 0x1b), }
-};
-
 static int __init n810_soc_init(void)
 {
 	int err;
@@ -351,15 +333,11 @@ static int __init n810_soc_init(void)
 	if (!(machine_is_nokia_n810() || machine_is_nokia_n810_wimax()))
 		return -ENODEV;
 
-	i2c_register_board_info(1, i2c_device, ARRAY_SIZE(i2c_device));
-
 	n810_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!n810_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(n810_snd_device, &n810_snd_devdata);
-	n810_snd_devdata.dev = &n810_snd_device->dev;
-	*(unsigned int *)n810_dai.cpu_dai->private_data = 1; /* McBSP2 */
+	platform_set_drvdata(n810_snd_device, &snd_soc_n810);
 	err = platform_device_add(n810_snd_device);
 	if (err)
 		goto err1;
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 86f2139..7ba5690 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -62,8 +62,6 @@ struct omap_mcbsp_data {
 	int				wlen;
 };
 
-#define to_mcbsp(priv)	container_of((priv), struct omap_mcbsp_data, bus_id)
-
 static struct omap_mcbsp_data mcbsp_data[NUM_LINKS];
 
 /*
@@ -153,13 +151,13 @@ static const unsigned long omap34xx_mcbsp_port[][2] = {};
 static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
 	struct omap_pcm_dma_data *dma_data;
 	int dma_op_mode = omap_mcbsp_get_dma_op_mode(mcbsp_data->bus_id);
 	int words;
 
-	dma_data = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
 	if (dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
@@ -203,11 +201,9 @@ static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params *params,
 }
 
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
-				  struct snd_soc_dai *dai)
+				  struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
 	int bus_id = mcbsp_data->bus_id;
 	int err = 0;
 
@@ -249,11 +245,9 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 }
 
 static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream,
-				    struct snd_soc_dai *dai)
+				    struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
 
 	if (!cpu_dai->active) {
 		omap_mcbsp_free(mcbsp_data->bus_id);
@@ -262,11 +256,9 @@ static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream,
 }
 
 static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
-				  struct snd_soc_dai *dai)
+				  struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
 	int err = 0, play = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
 	switch (cmd) {
@@ -295,8 +287,8 @@ static snd_pcm_sframes_t omap_mcbsp_dai_delay(
 			struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
 	u16 fifo_use;
 	snd_pcm_sframes_t delay;
 
@@ -317,11 +309,9 @@ static snd_pcm_sframes_t omap_mcbsp_dai_delay(
 
 static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params,
-				    struct snd_soc_dai *dai)
+				    struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	struct omap_pcm_dma_data *dma_data;
 	int dma, bus_id = mcbsp_data->bus_id;
@@ -496,7 +486,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				      unsigned int fmt)
 {
-	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	unsigned int temp_fmt = fmt;
 
@@ -596,7 +586,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
 				     int div_id, int div)
 {
-	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 
 	if (div_id != OMAP_MCBSP_CLKGDV)
@@ -699,7 +689,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 					 int clk_id, unsigned int freq,
 					 int dir)
 {
-	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	int err = 0;
 
@@ -733,7 +723,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	return err;
 }
 
-static struct snd_soc_dai_ops omap_mcbsp_dai_ops = {
+static struct snd_soc_dai_ops mcbsp_dai_ops = {
 	.startup	= omap_mcbsp_dai_startup,
 	.shutdown	= omap_mcbsp_dai_shutdown,
 	.trigger	= omap_mcbsp_dai_trigger,
@@ -744,42 +734,31 @@ static struct snd_soc_dai_ops omap_mcbsp_dai_ops = {
 	.set_sysclk	= omap_mcbsp_dai_set_dai_sysclk,
 };
 
-#define OMAP_MCBSP_DAI_BUILDER(link_id)				\
-{								\
-	.name = "omap-mcbsp-dai-"#link_id,			\
-	.id = (link_id),					\
-	.playback = {						\
-		.channels_min = 1,				\
-		.channels_max = 16,				\
-		.rates = OMAP_MCBSP_RATES,			\
-		.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
-			   SNDRV_PCM_FMTBIT_S32_LE,		\
-	},							\
-	.capture = {						\
-		.channels_min = 1,				\
-		.channels_max = 16,				\
-		.rates = OMAP_MCBSP_RATES,			\
-		.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
-			   SNDRV_PCM_FMTBIT_S32_LE,		\
-	},							\
-	.ops = &omap_mcbsp_dai_ops,				\
-	.private_data = &mcbsp_data[(link_id)].bus_id,		\
+static int mcbsp_dai_probe(struct snd_soc_dai *dai)
+{
+	mcbsp_data[dai->id].bus_id = dai->id;
+	snd_soc_dai_set_drvdata(dai, &mcbsp_data[dai->id].bus_id);
+	return 0;
 }
 
-struct snd_soc_dai omap_mcbsp_dai[] = {
-	OMAP_MCBSP_DAI_BUILDER(0),
-	OMAP_MCBSP_DAI_BUILDER(1),
-#if NUM_LINKS >= 3
-	OMAP_MCBSP_DAI_BUILDER(2),
-#endif
-#if NUM_LINKS == 5
-	OMAP_MCBSP_DAI_BUILDER(3),
-	OMAP_MCBSP_DAI_BUILDER(4),
-#endif
+static struct snd_soc_dai_driver omap_mcbsp_dai =
+{
+	.probe = mcbsp_dai_probe,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 16,
+		.rates = OMAP_MCBSP_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 16,
+		.rates = OMAP_MCBSP_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.ops = &mcbsp_dai_ops,
 };
 
-EXPORT_SYMBOL_GPL(omap_mcbsp_dai);
-
 int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_info *uinfo)
 {
@@ -910,16 +889,36 @@ int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, int mcbsp_id)
 }
 EXPORT_SYMBOL_GPL(omap_mcbsp_st_add_controls);
 
+static __devinit int asoc_mcbsp_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_dai(&pdev->dev, &omap_mcbsp_dai);
+}
+
+static int __devexit asoc_mcbsp_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver asoc_mcbsp_driver = {
+	.driver = {
+			.name = "omap-mcbsp-dai",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = asoc_mcbsp_probe,
+	.remove = __devexit_p(asoc_mcbsp_remove),
+};
+
 static int __init snd_omap_mcbsp_init(void)
 {
-	return snd_soc_register_dais(omap_mcbsp_dai,
-				     ARRAY_SIZE(omap_mcbsp_dai));
+	return platform_driver_register(&asoc_mcbsp_driver);
 }
 module_init(snd_omap_mcbsp_init);
 
 static void __exit snd_omap_mcbsp_exit(void)
 {
-	snd_soc_unregister_dais(omap_mcbsp_dai, ARRAY_SIZE(omap_mcbsp_dai));
+	platform_driver_unregister(&asoc_mcbsp_driver);
 }
 module_exit(snd_omap_mcbsp_exit);
 
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index 6c363e5..ffdcc5a 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -55,8 +55,6 @@ enum omap_mcbsp_div {
 #define NUM_LINKS	5
 #endif
 
-extern struct snd_soc_dai omap_mcbsp_dai[NUM_LINKS];
-
 int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, int mcbsp_id);
 
 #endif
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index b7f4f7e..f161c2f 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -36,7 +36,6 @@
 #include <plat/dma.h>
 #include <plat/mcbsp.h>
 #include "mcpdm.h"
-#include "omap-mcpdm.h"
 #include "omap-pcm.h"
 
 struct omap_mcpdm_data {
@@ -89,11 +88,9 @@ static struct omap_pcm_dma_data omap_mcpdm_dai_dma_params[] = {
 static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int err = 0;
 
-	if (!cpu_dai->active)
+	if (!dai->active)
 		err = omap_mcpdm_request();
 
 	return err;
@@ -102,19 +99,14 @@ static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
 static void omap_mcpdm_dai_shutdown(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-
-	if (!cpu_dai->active)
+	if (!dai->active)
 		omap_mcpdm_free();
 }
 
 static int omap_mcpdm_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 				  struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct omap_mcpdm_data *mcpdm_priv = cpu_dai->private_data;
+	struct omap_mcpdm_data *mcpdm_priv = snd_soc_dai_get_drvdata(dai);
 	int stream = substream->stream;
 	int err = 0;
 
@@ -143,14 +135,12 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params,
 				    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct omap_mcpdm_data *mcpdm_priv = cpu_dai->private_data;
+	struct omap_mcpdm_data *mcpdm_priv = snd_soc_dai_get_drvdata(dai);
 	struct omap_mcpdm_link *mcpdm_links = mcpdm_priv->links;
 	int stream = substream->stream;
 	int channels, err, link_mask = 0;
 
-	snd_soc_dai_set_dma_data(cpu_dai, substream,
+	snd_soc_dai_set_dma_data(dai, substream,
 				 &omap_mcpdm_dai_dma_params[stream]);
 
 	channels = params_channels(params);
@@ -189,9 +179,7 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 static int omap_mcpdm_dai_hw_free(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct omap_mcpdm_data *mcpdm_priv = cpu_dai->private_data;
+	struct omap_mcpdm_data *mcpdm_priv = snd_soc_dai_get_drvdata(dai);
 	struct omap_mcpdm_link *mcpdm_links = mcpdm_priv->links;
 	int stream = substream->stream;
 	int err;
@@ -215,9 +203,14 @@ static struct snd_soc_dai_ops omap_mcpdm_dai_ops = {
 #define OMAP_MCPDM_RATES	(SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 #define OMAP_MCPDM_FORMATS	(SNDRV_PCM_FMTBIT_S32_LE)
 
-struct snd_soc_dai omap_mcpdm_dai = {
-	.name = "omap-mcpdm",
-	.id = -1,
+static int omap_mcpdm_dai_probe(struct snd_soc_dai *dai)
+{
+	snd_soc_dai_set_drvdata(dai, &mcpdm_data);
+	return 0;
+}
+
+static struct snd_soc_dai_driver omap_mcpdm_dai = {
+	.probe = omap_mcpdm_dai_probe,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 4,
@@ -231,19 +224,47 @@ struct snd_soc_dai omap_mcpdm_dai = {
 		.formats = OMAP_MCPDM_FORMATS,
 	},
 	.ops = &omap_mcpdm_dai_ops,
-	.private_data = &mcpdm_data,
 };
-EXPORT_SYMBOL_GPL(omap_mcpdm_dai);
+
+static __devinit int asoc_mcpdm_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = omap_mcpdm_probe(pdev);
+	if (ret < 0)
+		return ret;
+	ret = snd_soc_register_dai(&pdev->dev, &omap_mcpdm_dai);
+	if (ret < 0)
+		omap_mcpdm_remove(pdev);
+	return ret;
+}
+
+static int __devexit asoc_mcpdm_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&pdev->dev);
+	omap_mcpdm_remove(pdev);
+	return 0;
+}
+
+static struct platform_driver asoc_mcpdm_driver = {
+	.driver = {
+			.name = "omap-mcpdm-dai",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = asoc_mcpdm_probe,
+	.remove = __devexit_p(asoc_mcpdm_remove),
+};
 
 static int __init snd_omap_mcpdm_init(void)
 {
-	return snd_soc_register_dai(&omap_mcpdm_dai);
+	return platform_driver_register(&asoc_mcpdm_driver);
 }
 module_init(snd_omap_mcpdm_init);
 
 static void __exit snd_omap_mcpdm_exit(void)
 {
-	snd_soc_unregister_dai(&omap_mcpdm_dai);
+	platform_driver_unregister(&asoc_mcpdm_driver);
 }
 module_exit(snd_omap_mcpdm_exit);
 
diff --git a/sound/soc/omap/omap-mcpdm.h b/sound/soc/omap/omap-mcpdm.h
deleted file mode 100644
index 73b80d5..0000000
--- a/sound/soc/omap/omap-mcpdm.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * omap-mcpdm.h
- *
- * Copyright (C) 2009 Texas Instruments
- *
- * Contact: Misael Lopez Cruz <x0052729@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef __OMAP_MCPDM_H__
-#define __OMAP_MCPDM_H__
-
-extern struct snd_soc_dai omap_mcpdm_dai;
-
-#endif	/* End of __OMAP_MCPDM_H__ */
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 1e52190..8caeb8d 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -101,9 +101,10 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct omap_runtime_data *prtd = runtime->private_data;
 	struct omap_pcm_dma_data *dma_data;
+
 	int err = 0;
 
-	dma_data = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	/* return if this is a bufferless transfer e.g.
 	 * codec <--> BT codec or GSM modem -- lg FIXME */
@@ -374,14 +375,14 @@ static int omap_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = DMA_BIT_MASK(64);
 
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		ret = omap_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			goto out;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		ret = omap_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
@@ -392,25 +393,45 @@ out:
 	return ret;
 }
 
-struct snd_soc_platform omap_soc_platform = {
-	.name		= "omap-pcm-audio",
-	.pcm_ops 	= &omap_pcm_ops,
+static struct snd_soc_platform_driver omap_soc_platform = {
+	.ops		= &omap_pcm_ops,
 	.pcm_new	= omap_pcm_new,
 	.pcm_free	= omap_pcm_free_dma_buffers,
 };
-EXPORT_SYMBOL_GPL(omap_soc_platform);
 
-static int __init omap_soc_platform_init(void)
+static __devinit int omap_pcm_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_platform(&pdev->dev,
+			&omap_soc_platform);
+}
+
+static int __devexit omap_pcm_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver omap_pcm_driver = {
+	.driver = {
+			.name = "omap-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = omap_pcm_probe,
+	.remove = __devexit_p(omap_pcm_remove),
+};
+
+static int __init snd_omap_pcm_init(void)
 {
-	return snd_soc_register_platform(&omap_soc_platform);
+	return platform_driver_register(&omap_pcm_driver);
 }
-module_init(omap_soc_platform_init);
+module_init(snd_omap_pcm_init);
 
-static void __exit omap_soc_platform_exit(void)
+static void __exit snd_omap_pcm_exit(void)
 {
-	snd_soc_unregister_platform(&omap_soc_platform);
+	platform_driver_unregister(&omap_pcm_driver);
 }
-module_exit(omap_soc_platform_exit);
+module_exit(snd_omap_pcm_exit);
 
 MODULE_AUTHOR("Jarkko Nikula <jhnikula@gmail.com>");
 MODULE_DESCRIPTION("OMAP PCM DMA module");
diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
index b19975d..fea0515 100644
--- a/sound/soc/omap/omap-pcm.h
+++ b/sound/soc/omap/omap-pcm.h
@@ -35,6 +35,4 @@ struct omap_pcm_dma_data {
 	int		packet_size;	/* packet size only in PACKET mode */
 };
 
-extern struct snd_soc_platform omap_soc_platform;
-
 #endif
diff --git a/sound/soc/omap/omap2evm.c b/sound/soc/omap/omap2evm.c
index c7adea3..38cd189 100644
--- a/sound/soc/omap/omap2evm.c
+++ b/sound/soc/omap/omap2evm.c
@@ -35,15 +35,13 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 static int omap2evm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params,
-	struct snd_soc_dai *dai)
+	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
 	/* Set codec DAI configuration */
@@ -85,25 +83,20 @@ static struct snd_soc_ops omap2evm_ops = {
 static struct snd_soc_dai_link omap2evm_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
-	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+	.cpu_dai_name = "omap-mcbsp-dai.1",
+	.codec_dai_name = "twl4030-hifi",
+	.platform_name = "omap-pcm-audio",
+	.codec_name = "twl4030-codec",
 	.ops = &omap2evm_ops,
 };
 
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_omap2evm = {
 	.name = "omap2evm",
-	.platform = &omap_soc_platform,
 	.dai_link = &omap2evm_dai,
 	.num_links = 1,
 };
 
-/* Audio subsystem */
-static struct snd_soc_device omap2evm_snd_devdata = {
-	.card = &snd_soc_omap2evm,
-	.codec_dev = &soc_codec_dev_twl4030,
-};
-
 static struct platform_device *omap2evm_snd_device;
 
 static int __init omap2evm_soc_init(void)
@@ -122,9 +115,7 @@ static int __init omap2evm_soc_init(void)
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(omap2evm_snd_device, &omap2evm_snd_devdata);
-	omap2evm_snd_devdata.dev = &omap2evm_snd_device->dev;
-	*(unsigned int *)omap2evm_dai.cpu_dai->private_data = 1; /* McBSP2 */
+	platform_set_drvdata(omap2evm_snd_device, &snd_soc_omap2evm);
 
 	ret = platform_device_add(omap2evm_snd_device);
 	if (ret)
diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index 240e097..7c11e1a 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -33,14 +33,13 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 static int omap3beagle_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	unsigned int fmt;
 	int ret;
 
@@ -92,25 +91,21 @@ static struct snd_soc_ops omap3beagle_ops = {
 static struct snd_soc_dai_link omap3beagle_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
-	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+	.cpu_dai_name = "omap-mcbsp-dai.1",
+	.platform_name = "omap-pcm-audio",
+	.codec_dai_name = "twl4030-hifi",
+	.codec_name = "twl4030-codec",
 	.ops = &omap3beagle_ops,
 };
 
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_omap3beagle = {
 	.name = "omap3beagle",
-	.platform = &omap_soc_platform,
+	.owner = THIS_MODULE,
 	.dai_link = &omap3beagle_dai,
 	.num_links = 1,
 };
 
-/* Audio subsystem */
-static struct snd_soc_device omap3beagle_snd_devdata = {
-	.card = &snd_soc_omap3beagle,
-	.codec_dev = &soc_codec_dev_twl4030,
-};
-
 static struct platform_device *omap3beagle_snd_device;
 
 static int __init omap3beagle_soc_init(void)
@@ -129,9 +124,7 @@ static int __init omap3beagle_soc_init(void)
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(omap3beagle_snd_device, &omap3beagle_snd_devdata);
-	omap3beagle_snd_devdata.dev = &omap3beagle_snd_device->dev;
-	*(unsigned int *)omap3beagle_dai.cpu_dai->private_data = 1; /* McBSP2 */
+	platform_set_drvdata(omap3beagle_snd_device, &snd_soc_omap3beagle);
 
 	ret = platform_device_add(omap3beagle_snd_device);
 	if (ret)
diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
index dfcb344..1ac5bab 100644
--- a/sound/soc/omap/omap3evm.c
+++ b/sound/soc/omap/omap3evm.c
@@ -31,14 +31,13 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 static int omap3evm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
 	/* Set codec DAI configuration */
@@ -80,32 +79,20 @@ static struct snd_soc_ops omap3evm_ops = {
 static struct snd_soc_dai_link omap3evm_dai = {
 	.name 		= "TWL4030",
 	.stream_name 	= "TWL4030",
-	.cpu_dai 	= &omap_mcbsp_dai[0],
-	.codec_dai 	= &twl4030_dai[TWL4030_DAI_HIFI],
+	.cpu_dai_name = "omap-mcbsp-dai.1",
+	.codec_dai_name = "twl4030-hifi",
+	.platform_name = "omap-pcm-audio",
+	.codec_name = "twl4030-codec",
 	.ops 		= &omap3evm_ops,
 };
 
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_omap3evm = {
 	.name = "omap3evm",
-	.platform = &omap_soc_platform,
 	.dai_link = &omap3evm_dai,
 	.num_links = 1,
 };
 
-/* twl4030 setup */
-static struct twl4030_setup_data twl4030_setup = {
-	.ramp_delay_value = 4,
-	.sysclk = 26000,
-};
-
-/* Audio subsystem */
-static struct snd_soc_device omap3evm_snd_devdata = {
-	.card = &snd_soc_omap3evm,
-	.codec_dev = &soc_codec_dev_twl4030,
-	.codec_data = &twl4030_setup,
-};
-
 static struct platform_device *omap3evm_snd_device;
 
 static int __init omap3evm_soc_init(void)
@@ -124,10 +111,7 @@ static int __init omap3evm_soc_init(void)
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(omap3evm_snd_device, &omap3evm_snd_devdata);
-	omap3evm_snd_devdata.dev = &omap3evm_snd_device->dev;
-	*(unsigned int *)omap3evm_dai.cpu_dai->private_data = 1;
-
+	platform_set_drvdata(omap3evm_snd_device, &snd_soc_omap3evm);
 	ret = platform_device_add(omap3evm_snd_device);
 	if (ret)
 		goto err1;
diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 9eecac1..dbd9d96 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -31,10 +31,10 @@
 #include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
+#include <plat/mcbsp.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 #define OMAP3_PANDORA_DAC_POWER_GPIO	118
 #define OMAP3_PANDORA_AMP_POWER_GPIO	14
@@ -47,8 +47,8 @@ static int omap3pandora_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		  SND_SOC_DAIFMT_CBS_CFS;
 	int ret;
@@ -167,8 +167,9 @@ static const struct snd_soc_dapm_route omap3pandora_in_map[] = {
 	{"Mic Bias 2", NULL, "Mic (external)"},
 };
 
-static int omap3pandora_out_init(struct snd_soc_codec *codec)
+static int omap3pandora_out_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	int ret;
 
 	/* All TWL4030 output pins are floating */
@@ -194,8 +195,9 @@ static int omap3pandora_out_init(struct snd_soc_codec *codec)
 	return snd_soc_dapm_sync(codec);
 }
 
-static int omap3pandora_in_init(struct snd_soc_codec *codec)
+static int omap3pandora_in_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	int ret;
 
 	/* Not comnnected */
@@ -224,15 +226,19 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
 	{
 		.name = "PCM1773",
 		.stream_name = "HiFi Out",
-		.cpu_dai = &omap_mcbsp_dai[0],
-		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+		.cpu_dai_name = "omap-mcbsp-dai.1",
+		.codec_dai_name = "twl4030-hifi",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "twl4030-codec",
 		.ops = &omap3pandora_ops,
 		.init = omap3pandora_out_init,
 	}, {
 		.name = "TWL4030",
 		.stream_name = "Line/Mic In",
-		.cpu_dai = &omap_mcbsp_dai[1],
-		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+		.cpu_dai_name = "omap-mcbsp-dai.3",
+		.codec_dai_name = "twl4030-hifi",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "twl4030-codec",
 		.ops = &omap3pandora_ops,
 		.init = omap3pandora_in_init,
 	}
@@ -241,17 +247,10 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
 /* SoC card */
 static struct snd_soc_card snd_soc_card_omap3pandora = {
 	.name = "omap3pandora",
-	.platform = &omap_soc_platform,
 	.dai_link = omap3pandora_dai,
 	.num_links = ARRAY_SIZE(omap3pandora_dai),
 };
 
-/* Audio subsystem */
-static struct snd_soc_device omap3pandora_snd_data = {
-	.card = &snd_soc_card_omap3pandora,
-	.codec_dev = &soc_codec_dev_twl4030,
-};
-
 static struct platform_device *omap3pandora_snd_device;
 
 static int __init omap3pandora_soc_init(void)
@@ -294,10 +293,7 @@ static int __init omap3pandora_soc_init(void)
 		goto fail1;
 	}
 
-	platform_set_drvdata(omap3pandora_snd_device, &omap3pandora_snd_data);
-	omap3pandora_snd_data.dev = &omap3pandora_snd_device->dev;
-	*(unsigned int *)omap_mcbsp_dai[0].private_data = 1; /* McBSP2 */
-	*(unsigned int *)omap_mcbsp_dai[1].private_data = 3; /* McBSP4 */
+	platform_set_drvdata(omap3pandora_snd_device, &snd_soc_card_omap3pandora);
 
 	ret = platform_device_add(omap3pandora_snd_device);
 	if (ret) {
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index 498ca2e..f0e6625 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -55,8 +55,8 @@ static int osk_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int err;
 
 	/* Set codec DAI configuration */
@@ -113,8 +113,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"MICIN", NULL, "Mic Jack"},
 };
 
-static int osk_tlv320aic23_init(struct snd_soc_codec *codec)
+static int osk_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 
 	/* Add osk5912 specific widgets */
 	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
@@ -136,8 +137,10 @@ static int osk_tlv320aic23_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link osk_dai = {
 	.name = "TLV320AIC23",
 	.stream_name = "AIC23",
-	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &tlv320aic23_dai,
+	.cpu_dai_name = "omap-mcbsp-dai.0",
+	.codec_dai_name = "tlv320aic23-hifi",
+	.platform_name = "omap-pcm-audio",
+	.codec_name = "tlv320aic23-codec",
 	.init = osk_tlv320aic23_init,
 	.ops = &osk_ops,
 };
@@ -145,17 +148,10 @@ static struct snd_soc_dai_link osk_dai = {
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_card_osk = {
 	.name = "OSK5912",
-	.platform = &omap_soc_platform,
 	.dai_link = &osk_dai,
 	.num_links = 1,
 };
 
-/* Audio subsystem */
-static struct snd_soc_device osk_snd_devdata = {
-	.card = &snd_soc_card_osk,
-	.codec_dev = &soc_codec_dev_tlv320aic23,
-};
-
 static struct platform_device *osk_snd_device;
 
 static int __init osk_soc_init(void)
@@ -171,9 +167,7 @@ static int __init osk_soc_init(void)
 	if (!osk_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(osk_snd_device, &osk_snd_devdata);
-	osk_snd_devdata.dev = &osk_snd_device->dev;
-	*(unsigned int *)osk_dai.cpu_dai->private_data = 0;	/* McBSP1 */
+	platform_set_drvdata(osk_snd_device, &snd_soc_card_osk);
 	err = platform_device_add(osk_snd_device);
 	if (err)
 		goto err1;
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
index c25f527..e95a607 100644
--- a/sound/soc/omap/overo.c
+++ b/sound/soc/omap/overo.c
@@ -33,14 +33,13 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 static int overo_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
 	/* Set codec DAI configuration */
@@ -82,25 +81,20 @@ static struct snd_soc_ops overo_ops = {
 static struct snd_soc_dai_link overo_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
-	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+	.cpu_dai_name = "omap-mcbsp-dai.1",
+	.codec_dai_name = "twl4030-hifi",
+	.platform_name = "omap-pcm-audio",
+	.codec_name = "twl4030-codec",
 	.ops = &overo_ops,
 };
 
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_card_overo = {
 	.name = "overo",
-	.platform = &omap_soc_platform,
 	.dai_link = &overo_dai,
 	.num_links = 1,
 };
 
-/* Audio subsystem */
-static struct snd_soc_device overo_snd_devdata = {
-	.card = &snd_soc_card_overo,
-	.codec_dev = &soc_codec_dev_twl4030,
-};
-
 static struct platform_device *overo_snd_device;
 
 static int __init overo_soc_init(void)
@@ -119,9 +113,7 @@ static int __init overo_soc_init(void)
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(overo_snd_device, &overo_snd_devdata);
-	overo_snd_devdata.dev = &overo_snd_device->dev;
-	*(unsigned int *)overo_dai.cpu_dai->private_data = 1; /* McBSP2 */
+	platform_set_drvdata(overo_snd_device, &snd_soc_card_overo);
 
 	ret = platform_device_add(overo_snd_device);
 	if (ret)
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 88052d2..d1d8098 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -31,6 +31,7 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <plat/mcbsp.h>
 
 #include <asm/mach-types.h>
 
@@ -76,7 +77,7 @@ static int rx51_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 
 	snd_pcm_hw_constraint_minmax(runtime,
 				     SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
@@ -89,8 +90,8 @@ static int rx51_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int err;
 
 	/* Set codec DAI configuration */
@@ -240,9 +241,9 @@ static const struct snd_kcontrol_new aic34_rx51_controls[] = {
 		     rx51_get_jack, rx51_set_jack),
 };
 
-static int rx51_aic34_init(struct snd_soc_codec *codec)
+static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_card *card = codec->socdev->card;
+	struct snd_soc_codec *codec = rtd->codec;
 	int err;
 
 	/* Set up NC codec pins */
@@ -266,7 +267,7 @@ static int rx51_aic34_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_sync(codec);
 
 	/* AV jack detection */
-	err = snd_soc_jack_new(card, "AV Jack",
+	err = snd_soc_jack_new(codec, "AV Jack",
 			       SND_JACK_VIDEOOUT, &rx51_av_jack);
 	if (err)
 		return err;
@@ -282,32 +283,20 @@ static struct snd_soc_dai_link rx51_dai[] = {
 	{
 		.name = "TLV320AIC34",
 		.stream_name = "AIC34",
-		.cpu_dai = &omap_mcbsp_dai[0],
-		.codec_dai = &aic3x_dai,
+		.cpu_dai_name = "omap-mcbsp-dai.1",
+		.codec_dai_name = "tlv320aic3x-hifi",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "tlv320aic3x-codec.2-0018",
 		.init = rx51_aic34_init,
 		.ops = &rx51_ops,
 	},
 };
 
-/* Audio private data */
-static struct aic3x_setup_data rx51_aic34_setup = {
-	.gpio_func[0] = AIC3X_GPIO1_FUNC_DISABLED,
-	.gpio_func[1] = AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT,
-};
-
 /* Audio card */
 static struct snd_soc_card rx51_sound_card = {
 	.name = "RX-51",
 	.dai_link = rx51_dai,
 	.num_links = ARRAY_SIZE(rx51_dai),
-	.platform = &omap_soc_platform,
-};
-
-/* Audio subsystem */
-static struct snd_soc_device rx51_snd_devdata = {
-	.card = &rx51_sound_card,
-	.codec_dev = &soc_codec_dev_aic3x,
-	.codec_data = &rx51_aic34_setup,
 };
 
 static struct platform_device *rx51_snd_device;
@@ -330,9 +319,7 @@ static int __init rx51_soc_init(void)
 		goto err1;
 	}
 
-	platform_set_drvdata(rx51_snd_device, &rx51_snd_devdata);
-	rx51_snd_devdata.dev = &rx51_snd_device->dev;
-	*(unsigned int *)rx51_dai[0].cpu_dai->private_data = 1; /* McBSP2 */
+	platform_set_drvdata(rx51_snd_device, &rx51_sound_card);
 
 	err = platform_device_add(rx51_snd_device);
 	if (err)
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 3c85c0f..76ce77b 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -36,9 +36,11 @@
 #include <mach/gpio.h>
 #include <plat/mcbsp.h>
 
+/* Register descriptions for twl4030 codec part */
+#include <linux/mfd/twl4030-codec.h>
+
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 /* TWL4030 PMBR1 Register */
 #define TWL4030_INTBR_PMBR1		0x0D
@@ -51,8 +53,8 @@ static int sdp3430_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
 	/* Set codec DAI configuration */
@@ -94,8 +96,8 @@ static int sdp3430_hw_voice_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
 	/* Set codec DAI configuration */
@@ -186,8 +188,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Headset Stereophone", NULL, "HSOR"},
 };
 
-static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
+static int sdp3430_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	int ret;
 
 	/* Add SDP3430 specific widgets */
@@ -225,7 +228,7 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 		return ret;
 
 	/* Headset jack detection */
-	ret = snd_soc_jack_new(&snd_soc_sdp3430, "Headset Jack",
+	ret = snd_soc_jack_new(codec, "Headset Jack",
 				SND_JACK_HEADSET, &hs_jack);
 	if (ret)
 		return ret;
@@ -241,14 +244,15 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static int sdp3430_twl4030_voice_init(struct snd_soc_codec *codec)
+static int sdp3430_twl4030_voice_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	unsigned short reg;
 
 	/* Enable voice interface */
-	reg = codec->read(codec, TWL4030_REG_VOICE_IF);
+	reg = codec->driver->read(codec, TWL4030_REG_VOICE_IF);
 	reg |= TWL4030_VIF_DIN_EN | TWL4030_VIF_DOUT_EN | TWL4030_VIF_EN;
-	codec->write(codec, TWL4030_REG_VOICE_IF, reg);
+	codec->driver->write(codec, TWL4030_REG_VOICE_IF, reg);
 
 	return 0;
 }
@@ -259,16 +263,20 @@ static struct snd_soc_dai_link sdp3430_dai[] = {
 	{
 		.name = "TWL4030 I2S",
 		.stream_name = "TWL4030 Audio",
-		.cpu_dai = &omap_mcbsp_dai[0],
-		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+		.cpu_dai_name = "omap-mcbsp-dai.1",
+		.codec_dai_name = "twl4030-hifi",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "twl4030-codec",
 		.init = sdp3430_twl4030_init,
 		.ops = &sdp3430_ops,
 	},
 	{
 		.name = "TWL4030 PCM",
 		.stream_name = "TWL4030 Voice",
-		.cpu_dai = &omap_mcbsp_dai[1],
-		.codec_dai = &twl4030_dai[TWL4030_DAI_VOICE],
+		.cpu_dai_name = "omap-mcbsp-dai.2",
+		.codec_dai_name = "twl4030-voice",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "twl4030-codec",
 		.init = sdp3430_twl4030_voice_init,
 		.ops = &sdp3430_voice_ops,
 	},
@@ -277,25 +285,10 @@ static struct snd_soc_dai_link sdp3430_dai[] = {
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_sdp3430 = {
 	.name = "SDP3430",
-	.platform = &omap_soc_platform,
 	.dai_link = sdp3430_dai,
 	.num_links = ARRAY_SIZE(sdp3430_dai),
 };
 
-/* twl4030 setup */
-static struct twl4030_setup_data twl4030_setup = {
-	.ramp_delay_value = 3,
-	.sysclk = 26000,
-	.hs_extmute = 1,
-};
-
-/* Audio subsystem */
-static struct snd_soc_device sdp3430_snd_devdata = {
-	.card = &snd_soc_sdp3430,
-	.codec_dev = &soc_codec_dev_twl4030,
-	.codec_data = &twl4030_setup,
-};
-
 static struct platform_device *sdp3430_snd_device;
 
 static int __init sdp3430_soc_init(void)
@@ -315,10 +308,7 @@ static int __init sdp3430_soc_init(void)
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(sdp3430_snd_device, &sdp3430_snd_devdata);
-	sdp3430_snd_devdata.dev = &sdp3430_snd_device->dev;
-	*(unsigned int *)sdp3430_dai[0].cpu_dai->private_data = 1; /* McBSP2 */
-	*(unsigned int *)sdp3430_dai[1].cpu_dai->private_data = 2; /* McBSP3 */
+	platform_set_drvdata(sdp3430_snd_device, &snd_soc_sdp3430);
 
 	/* Set TWL4030 GPIO6 as EXTMUTE signal */
 	twl_i2c_read_u8(TWL4030_MODULE_INTBR, &pin_mux,
diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 4ebbde6..62f6a62 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -31,7 +31,6 @@
 #include <plat/mux.h>
 
 #include "mcpdm.h"
-#include "omap-mcpdm.h"
 #include "omap-pcm.h"
 #include "../codecs/twl6040.h"
 
@@ -41,7 +40,7 @@ static int sdp4430_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int clk_id, freq;
 	int ret;
 
@@ -60,6 +59,7 @@ static int sdp4430_hw_params(struct snd_pcm_substream *substream,
 		printk(KERN_ERR "can't set codec system clock\n");
 		return ret;
 	}
+	return ret;
 }
 
 static struct snd_soc_ops sdp4430_ops = {
@@ -126,8 +126,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Earphone Spk", NULL, "EP"},
 };
 
-static int sdp4430_twl6040_init(struct snd_soc_codec *codec)
+static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	int ret;
 
 	/* Add SDP4430 specific controls */
@@ -164,8 +165,10 @@ static int sdp4430_twl6040_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link sdp4430_dai = {
 	.name = "TWL6040",
 	.stream_name = "TWL6040",
-	.cpu_dai = &omap_mcpdm_dai,
-	.codec_dai = &twl6040_dai,
+	.cpu_dai_name ="omap-mcpdm-dai",
+	.codec_dai_name = "twl6040-hifi",
+	.platform_name = "omap-pcm-audio",
+	.codec_name = "twl6040-codec",
 	.init = sdp4430_twl6040_init,
 	.ops = &sdp4430_ops,
 };
@@ -173,17 +176,10 @@ static struct snd_soc_dai_link sdp4430_dai = {
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_sdp4430 = {
 	.name = "SDP4430",
-	.platform = &omap_soc_platform,
 	.dai_link = &sdp4430_dai,
 	.num_links = 1,
 };
 
-/* Audio subsystem */
-static struct snd_soc_device sdp4430_snd_devdata = {
-	.card = &snd_soc_sdp4430,
-	.codec_dev = &soc_codec_dev_twl6040,
-};
-
 static struct platform_device *sdp4430_snd_device;
 
 static int __init sdp4430_soc_init(void)
@@ -202,8 +198,7 @@ static int __init sdp4430_soc_init(void)
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(sdp4430_snd_device, &sdp4430_snd_devdata);
-	sdp4430_snd_devdata.dev = &sdp4430_snd_device->dev;
+	platform_set_drvdata(sdp4430_snd_device, &snd_soc_sdp4430);
 
 	ret = platform_device_add(sdp4430_snd_device);
 	if (ret)
diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index 50a94ee..338dc95 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -29,21 +29,23 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/gpio.h>
+#include <mach/board-zoom.h>
 #include <plat/mcbsp.h>
 
+/* Register descriptions for twl4030 codec part */
+#include <linux/mfd/twl4030-codec.h>
+
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 #define ZOOM2_HEADSET_MUX_GPIO		(OMAP_MAX_GPIO_LINES + 15)
-#define ZOOM2_HEADSET_EXTMUTE_GPIO	153
 
 static int zoom2_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
 	/* Set codec DAI configuration */
@@ -85,8 +87,8 @@ static int zoom2_hw_voice_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
 	/* Set codec DAI configuration */
@@ -157,8 +159,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Aux In", NULL, "AUXR"},
 };
 
-static int zoom2_twl4030_init(struct snd_soc_codec *codec)
+static int zoom2_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	int ret;
 
 	/* Add Zoom2 specific widgets */
@@ -192,14 +195,15 @@ static int zoom2_twl4030_init(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static int zoom2_twl4030_voice_init(struct snd_soc_codec *codec)
+static int zoom2_twl4030_voice_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	unsigned short reg;
 
 	/* Enable voice interface */
-	reg = codec->read(codec, TWL4030_REG_VOICE_IF);
+	reg = codec->driver->read(codec, TWL4030_REG_VOICE_IF);
 	reg |= TWL4030_VIF_DIN_EN | TWL4030_VIF_DOUT_EN | TWL4030_VIF_EN;
-	codec->write(codec, TWL4030_REG_VOICE_IF, reg);
+	codec->driver->write(codec, TWL4030_REG_VOICE_IF, reg);
 
 	return 0;
 }
@@ -209,16 +213,20 @@ static struct snd_soc_dai_link zoom2_dai[] = {
 	{
 		.name = "TWL4030 I2S",
 		.stream_name = "TWL4030 Audio",
-		.cpu_dai = &omap_mcbsp_dai[0],
-		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+		.cpu_dai_name = "omap-mcbsp-dai.1",
+		.codec_dai_name = "twl4030-hifi",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "twl4030-codec",
 		.init = zoom2_twl4030_init,
 		.ops = &zoom2_ops,
 	},
 	{
 		.name = "TWL4030 PCM",
 		.stream_name = "TWL4030 Voice",
-		.cpu_dai = &omap_mcbsp_dai[1],
-		.codec_dai = &twl4030_dai[TWL4030_DAI_VOICE],
+		.cpu_dai_name = "omap-mcbsp-dai.2",
+		.codec_dai_name = "twl4030-voice",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "twl4030-codec",
 		.init = zoom2_twl4030_voice_init,
 		.ops = &zoom2_voice_ops,
 	},
@@ -227,32 +235,10 @@ static struct snd_soc_dai_link zoom2_dai[] = {
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_zoom2 = {
 	.name = "Zoom2",
-	.platform = &omap_soc_platform,
 	.dai_link = zoom2_dai,
 	.num_links = ARRAY_SIZE(zoom2_dai),
 };
 
-/* EXTMUTE callback function */
-void zoom2_set_hs_extmute(int mute)
-{
-	gpio_set_value(ZOOM2_HEADSET_EXTMUTE_GPIO, mute);
-}
-
-/* twl4030 setup */
-static struct twl4030_setup_data twl4030_setup = {
-	.ramp_delay_value = 3,	/* 161 ms */
-	.sysclk = 26000,
-	.hs_extmute = 1,
-	.set_hs_extmute = zoom2_set_hs_extmute,
-};
-
-/* Audio subsystem */
-static struct snd_soc_device zoom2_snd_devdata = {
-	.card = &snd_soc_zoom2,
-	.codec_dev = &soc_codec_dev_twl4030,
-	.codec_data = &twl4030_setup,
-};
-
 static struct platform_device *zoom2_snd_device;
 
 static int __init zoom2_soc_init(void)
@@ -271,11 +257,7 @@ static int __init zoom2_soc_init(void)
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(zoom2_snd_device, &zoom2_snd_devdata);
-	zoom2_snd_devdata.dev = &zoom2_snd_device->dev;
-	*(unsigned int *)zoom2_dai[0].cpu_dai->private_data = 1; /* McBSP2 */
-	*(unsigned int *)zoom2_dai[1].cpu_dai->private_data = 2; /* McBSP3 */
-
+	platform_set_drvdata(zoom2_snd_device, &snd_soc_zoom2);
 	ret = platform_device_add(zoom2_snd_device);
 	if (ret)
 		goto err1;
-- 
1.7.0.4
