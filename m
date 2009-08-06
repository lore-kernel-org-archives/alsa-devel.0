From: Ben Dooks <ben@simtec.co.uk>
Subject: Audio support for Simtec Hermes
Date: Fri, 07 Aug 2009 00:02:00 +0100
Message-ID: <20090806230200.627626438@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kira.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 057C810380E
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 01:02:01 +0200 (CEST)
Content-Disposition: inline; filename=audio-hermes.patch
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
List-Id: alsa-devel@alsa-project.org

Add support for the TLV320AIC33 codec on the Simtec Hermes board, using
the core work done for the TLV320AIC23 codecs.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 sound/soc/s3c24xx/Kconfig                 |    7 +
 sound/soc/s3c24xx/Makefile                |    3 
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c |  151 ++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)

Index: b/sound/soc/s3c24xx/Kconfig
===================================================================
--- a/sound/soc/s3c24xx/Kconfig	2009-08-04 12:27:06.000000000 +0100
+++ b/sound/soc/s3c24xx/Kconfig	2009-08-04 12:29:22.000000000 +0100
@@ -127,3 +127,10 @@ config SND_S3C24XX_SOC_SIMTEC_TLV320AIC2
 	select SND_S3C24XX_SOC_I2S
 	select SND_SOC_TLV320AIC23
 	select SND_S3C24XX_SOC_SIMTEC
+
+config SND_S3C24XX_SOC_SIMTEC_HERMES
+	tristate "SoC I2S Audio support for Simtec Hermes board"
+	depends on SND_S3C24XX_SOC
+	select SND_S3C24XX_SOC_I2S
+	select SND_SOC_TLV320AIC3X
+	select SND_S3C24XX_SOC_SIMTEC
Index: b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c	2009-08-04 12:42:00.000000000 +0100
@@ -0,0 +1,151 @@
+/* sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+ *
+ * Copyright 2009 Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <plat/audio-simtec.h>
+
+#include "s3c24xx-pcm.h"
+#include "s3c24xx-i2s.h"
+#include "s3c24xx_simtec.h"
+
+#include "../codecs/tlv320aic3x.h"
+
+static const struct snd_soc_dapm_widget dapm_widgets[] = {
+	SND_SOC_DAPM_LINE("GSM Out", NULL),
+	SND_SOC_DAPM_LINE("GSM In", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_LINE("ZV", NULL),
+	SND_SOC_DAPM_MIC("Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route base_map[] = {
+	/* Headphone connected to HP{L,R}OUT and HP{L,R}COM */
+
+	{ "Headphone Jack", NULL, "HPLOUT" },
+	{ "Headphone Jack", NULL, "HPLCOM" },
+	{ "Headphone Jack", NULL, "HPROUT" },
+	{ "Headphone Jack", NULL, "HPRCOM" },
+
+	/* ZV connected to Line1 */
+
+	{ "LINE1L", NULL, "ZV" },
+	{ "LINE1R", NULL, "ZV" },
+
+	/* Line In connected to Line2 */
+
+	{ "LINE2L", NULL, "Line In" },
+	{ "LINE2R", NULL, "Line In" },
+
+	/* Microphone connected to MIC3R and MIC_BIAS */
+
+	{ "MIC3L", NULL, "Mic" },
+
+	/* GSM connected to MONO_LOUT and MIC3L (in) */
+
+	{ "GSM Out", NULL, "MONO_LOUT" },
+	{ "MIC3L", NULL, "GSM In" },
+
+	/* Speaker is connected to LINEOUT{LN,LP,RN,RP} */
+};
+
+/**
+ * simtec_hermes_init - initialise and add controls
+ * @codec; The codec instance to attach to.
+ *
+ * Attach our controls and configure the necessary codec
+ * mappings for our sound card instance.
+*/
+static int simtec_hermes_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, dapm_widgets,
+				  ARRAY_SIZE(dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, base_map, ARRAY_SIZE(base_map));
+
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Line In");
+	snd_soc_dapm_enable_pin(codec, "Line Out");
+	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+
+	simtec_audio_init(codec);
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct aic3x_setup_data codec_setup = {
+	.i2c_bus	= 0,
+	.i2c_already	= 1,
+};
+
+static struct snd_soc_dai_link simtec_dai_aic33 = {
+	.name		= "tlv320aic33",
+	.stream_name	= "TLV320AIC33",
+	.cpu_dai	= &s3c24xx_i2s_dai,
+	.codec_dai	= &aic3x_dai,
+	.init		= simtec_hermes_init,
+};
+
+/* simtec audio machine driver */
+static struct snd_soc_card snd_soc_machine_simtec_aic33 = {
+	.name		= "Simtec-Hermes",
+	.platform	= &s3c24xx_soc_platform,
+	.dai_link	= &simtec_dai_aic33,
+	.num_links	= 1,
+};
+
+/* simtec audio subsystem */
+static struct snd_soc_device simtec_snd_devdata_aic33 = {
+	.card		= &snd_soc_machine_simtec_aic33,
+	.codec_dev	= &soc_codec_dev_aic3x,
+	.codec_data	= &codec_setup,
+};
+
+static int __devinit simtec_audio_hermes_probe(struct platform_device *pd)
+{
+	dev_info(&pd->dev, "probing....\n");
+	return simtec_audio_core_probe(pd, &simtec_snd_devdata_aic33);
+}
+
+static struct platform_driver simtec_audio_hermes_platdrv = {
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= "s3c24xx-simtec-hermes-snd",
+		.pm	= simtec_audio_pm,
+	},
+	.probe	= simtec_audio_hermes_probe,
+	.remove	= __devexit_p(simtec_audio_remove),
+};
+
+MODULE_ALIAS("platform:s3c24xx-simtec-hermes-snd");
+
+static int __init simtec_hermes_modinit(void)
+{
+	return platform_driver_register(&simtec_audio_hermes_platdrv);
+}
+
+static void __exit simtec_hermes_modexit(void)
+{
+	platform_driver_unregister(&simtec_audio_hermes_platdrv);
+}
+
+module_init(simtec_hermes_modinit);
+module_exit(simtec_hermes_modexit);
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("ALSA SoC Simtec Audio support");
+MODULE_LICENSE("GPL");
Index: b/sound/soc/s3c24xx/Makefile
===================================================================
--- a/sound/soc/s3c24xx/Makefile	2009-08-04 12:27:06.000000000 +0100
+++ b/sound/soc/s3c24xx/Makefile	2009-08-04 12:29:22.000000000 +0100
@@ -24,6 +24,7 @@ snd-soc-ln2440sbc-alc650-objs := ln2440s
 snd-soc-neo1973-gta02-wm8753-objs := neo1973_gta02_wm8753.o
 snd-soc-s3c24xx-uda134x-objs := s3c24xx_uda134x.o
 snd-soc-s3c24xx-simtec-objs := s3c24xx_simtec.o
+snd-soc-s3c24xx-simtec-hermes-objs := s3c24xx_simtec_hermes.o
 snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC_JIVE_WM8750) += snd-soc-jive-wm8750.o
@@ -36,4 +37,6 @@ obj-$(CONFIG_SND_S3C24XX_SOC_LN2440SBC_A
 obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_GTA02_WM8753) += snd-soc-neo1973-gta02-wm8753.o
 obj-$(CONFIG_SND_S3C24XX_SOC_S3C24XX_UDA134X) += snd-soc-s3c24xx-uda134x.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC) += snd-soc-s3c24xx-simtec.o
+obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
+

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
