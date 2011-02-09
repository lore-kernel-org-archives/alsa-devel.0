From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: mfld_machine: Add support for jack
	detection
Date: Wed,  9 Feb 2011 14:42:26 +0530
Message-ID: <1297242747-18632-3-git-send-email-vinod.koul@intel.com>
References: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 46B27103877
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 10:05:11 +0100 (CET)
In-Reply-To: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch adds support for registering jack interupt
and registering jack with core

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/mid-x86/mfld_machine.c |  211 +++++++++++++++++++++++++++++++++-----
 1 files changed, 184 insertions(+), 27 deletions(-)

diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 7925851..a8d5ad8 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -27,18 +27,53 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/jack.h>
 #include "../codecs/sn95031.h"
 
 #define MID_MONO 1
 #define MID_STEREO 2
 #define MID_MAX_CAP 5
+#define MFLD_JACK_INSERT 0x04
+
+enum soc_mic_bias_zones {
+	MFLD_MV_START = 0,
+	/* mic bias volutage range for Headphones*/
+	MFLD_MV_HP = 400,
+	/* mic bias volutage range for American Headset*/
+	MFLD_MV_AM_HS = 650,
+	/* mic bias volutage range for Headset*/
+	MFLD_MV_HS = 2000,
+	MFLD_MV_UNDEFINED,
+};
 
 static unsigned int	hs_switch;
 static unsigned int	lo_dac;
 
+struct mfld_mc_private {
+	struct platform_device *socdev;
+	void __iomem *int_base;
+	struct snd_soc_codec *codec;
+	u8 interrupt_status;
+};
+
+struct snd_soc_jack mfld_jack;
+
+/*Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin mfld_jack_pins[] = {
+	{
+		.pin = "Headphones",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "AMIC1",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
 /* sound card controls */
 static const char *headset_switch_text[] = {"Earpiece", "Headset"};
 
@@ -67,13 +102,11 @@ static int headset_set_switch(struct snd_kcontrol *kcontrol,
 
 	if (ucontrol->value.integer.value[0]) {
 		pr_debug("hs_set HS path\n");
-		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTL");
-		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_enable_pin(&codec->dapm, "Headphones");
 		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
 	} else {
 		pr_debug("hs_set EP path\n");
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "Headphones");
 		snd_soc_dapm_enable_pin(&codec->dapm, "EPOUT");
 	}
 	snd_soc_dapm_sync(&codec->dapm);
@@ -91,12 +124,10 @@ static void lo_enable_out_pins(struct snd_soc_codec *codec)
 	snd_soc_dapm_enable_pin(&codec->dapm, "VIB1OUT");
 	snd_soc_dapm_enable_pin(&codec->dapm, "VIB2OUT");
 	if (hs_switch) {
-		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTL");
-		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_enable_pin(&codec->dapm, "Headphones");
 		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
 	} else {
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "Headphones");
 		snd_soc_dapm_enable_pin(&codec->dapm, "EPOUT");
 	}
 }
@@ -130,8 +161,7 @@ static int lo_set_switch(struct snd_kcontrol *kcontrol,
 
 	case 1:
 		pr_debug("set hs  path\n");
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "Headphones");
 		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
 		snd_soc_update_bits(codec, SN95031_LOCTL, 0x66, 0x22);
 		break;
@@ -162,12 +192,52 @@ static const struct snd_kcontrol_new mfld_snd_controls[] = {
 			lo_get_switch, lo_set_switch),
 };
 
+static const struct snd_soc_dapm_widget mfld_widgets[] = {
+	SND_SOC_DAPM_HP("Headphones", NULL),
+	SND_SOC_DAPM_MIC("Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route mfld_map[] = {
+	{"Headphones", NULL, "HPOUTR"},
+	{"Headphones", NULL, "HPOUTL"},
+	{"Mic", NULL, "AMIC1"},
+};
+
+static void mfld_jack_check(unsigned int intr_status)
+{
+	struct mfld_jack_data jack_data;
+
+	jack_data.mfld_jack = &mfld_jack;
+	jack_data.intr_id = intr_status;
+
+	sn95031_jack_detection(&jack_data);
+	/* If american headest, program the gpio control registers */
+	if (jack_data.micbias_vol >=  MFLD_MV_HP &&
+		jack_data.micbias_vol <  MFLD_MV_HS)
+		snd_soc_update_bits(mfld_jack.codec, SN95031_AUDIO_GPIO_CTRL,
+				BIT(1), BIT(1));
+	else
+		snd_soc_update_bits(mfld_jack.codec, SN95031_AUDIO_GPIO_CTRL,
+				BIT(1), BIT(0));
+}
+
 static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret_val;
 
+	/* Add jack sense widgets */
+	snd_soc_dapm_new_controls(dapm, mfld_widgets, ARRAY_SIZE(mfld_widgets));
+
+	/* Set up the map */
+	snd_soc_dapm_add_routes(dapm, mfld_map, ARRAY_SIZE(mfld_map));
+
+	/* always connected */
+	snd_soc_dapm_enable_pin(dapm, "Headphones");
+	snd_soc_dapm_enable_pin(dapm, "Mic");
+	snd_soc_dapm_sync(dapm);
+
 	ret_val = snd_soc_add_controls(codec, mfld_snd_controls,
 				ARRAY_SIZE(mfld_snd_controls));
 	if (ret_val) {
@@ -175,8 +245,7 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 		return ret_val;
 	}
 	/* default is earpiece pin, userspace sets it explcitly */
-	snd_soc_dapm_disable_pin(dapm, "HPOUTL");
-	snd_soc_dapm_disable_pin(dapm, "HPOUTR");
+	snd_soc_dapm_disable_pin(dapm, "Headphones");
 	/* default is lineout NC, userspace sets it explcitly */
 	snd_soc_dapm_disable_pin(dapm, "LINEOUTL");
 	snd_soc_dapm_disable_pin(dapm, "LINEOUTR");
@@ -185,7 +254,30 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 	/* we dont use linein in this so set to NC */
 	snd_soc_dapm_disable_pin(dapm, "LINEINL");
 	snd_soc_dapm_disable_pin(dapm, "LINEINR");
-	return snd_soc_dapm_sync(dapm);
+	snd_soc_dapm_sync(dapm);
+
+	/* Headset and button jack detection */
+	ret_val = snd_soc_jack_new(codec, "Intel(R) MID Audio Jack",
+			SND_JACK_HEADSET | SND_JACK_BTN_0 |
+			SND_JACK_BTN_1, &mfld_jack);
+	if (ret_val) {
+		pr_err("jack creation failed\n");
+		return ret_val;
+	}
+
+	ret_val = snd_soc_jack_add_pins(&mfld_jack,
+			ARRAY_SIZE(mfld_jack_pins), mfld_jack_pins);
+	if (ret_val) {
+		pr_err("adding jack pins failed\n");
+		return ret_val;
+	}
+	disable_jack_btn(codec);
+
+	/* we want to check if anything is inserted at boot,
+	 * so send a fake event to codec and it will read adc
+	 * to find if anything is there or not */
+	mfld_jack_check(MFLD_JACK_INSERT);
+	return ret_val;
 }
 
 struct snd_soc_dai_link mfld_msic_dailink[] = {
@@ -234,37 +326,102 @@ static struct snd_soc_card snd_soc_card_mfld = {
 	.num_links = ARRAY_SIZE(mfld_msic_dailink),
 };
 
+static irqreturn_t snd_mfld_jack_intr_handler(int irq, void *dev)
+{
+	struct mfld_mc_private *mc_private = (struct mfld_mc_private *) dev;
+
+	memcpy_fromio(&mc_private->interrupt_status,
+			((void *)(mc_private->int_base)),
+			sizeof(u8));
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t snd_mfld_jack_detection(int irq, void *data)
+{
+	struct mfld_mc_private *mc_drv_ctx = (struct mfld_mc_private *) data;
+
+	if (mfld_jack.codec == NULL)
+		return IRQ_HANDLED;
+	mfld_jack_check(mc_drv_ctx->interrupt_status);
+
+	return IRQ_HANDLED;
+}
+
 static int __devinit snd_mfld_mc_probe(struct platform_device *pdev)
 {
-	struct platform_device *socdev;
-	int ret_val = 0;
+	int ret_val = 0, irq;
+	struct mfld_mc_private *mc_drv_ctx;
+	struct resource *irq_mem;
 
 	pr_debug("snd_mfld_mc_probe called\n");
 
-	socdev =  platform_device_alloc("soc-audio", -1);
-	if (!socdev) {
-		pr_err("soc-audio device allocation failed\n");
+	/* retrive the irq number */
+	irq = platform_get_irq(pdev, 0);
+
+	/* audio interrupt base of SRAM location where
+	 * interrupts are stored by System FW */
+	mc_drv_ctx = kzalloc(sizeof(*mc_drv_ctx), GFP_ATOMIC);
+	if (!mc_drv_ctx) {
+		pr_err("allocation failed\n");
 		return -ENOMEM;
 	}
-	platform_set_drvdata(socdev, &snd_soc_card_mfld);
-	ret_val = platform_device_add(socdev);
+
+	irq_mem = platform_get_resource_byname(
+				pdev, IORESOURCE_MEM, "IRQ_BASE");
+	if (!irq_mem) {
+		pr_err("no mem resource given\n");
+		ret_val = -ENODEV;
+		goto unalloc;
+	}
+	mc_drv_ctx->int_base = ioremap_nocache(irq_mem->start,
+					resource_size(irq_mem));
+	if (!mc_drv_ctx->int_base) {
+		pr_err("Mapping of cache failed\n");
+		ret_val = -ENOMEM;
+		goto unalloc;
+	}
+	/* register for interrupt */
+	ret_val = request_threaded_irq(irq, snd_mfld_jack_intr_handler,
+			snd_mfld_jack_detection,
+			IRQF_SHARED, pdev->dev.driver->name, mc_drv_ctx);
+	if (ret_val) {
+		pr_err("cannot register IRQ\n");
+		goto unalloc;
+	}
+	/* create soc device */
+	mc_drv_ctx->socdev = platform_device_alloc("soc-audio", -1);
+	if (!mc_drv_ctx->socdev) {
+		pr_err("soc-audio device allocation failed\n");
+		ret_val = -ENOMEM;
+		goto freeirq;
+	}
+	platform_set_drvdata(mc_drv_ctx->socdev, &snd_soc_card_mfld);
+	ret_val = platform_device_add(mc_drv_ctx->socdev);
 	if (ret_val) {
 		pr_err("Unable to add soc-audio device, err %d\n", ret_val);
-		platform_device_put(socdev);
+		goto unregister;
 	}
-
-	platform_set_drvdata(pdev, socdev);
-
+	platform_set_drvdata(pdev, mc_drv_ctx);
 	pr_debug("successfully exited probe\n");
 	return ret_val;
+
+unregister:
+	platform_device_put(mc_drv_ctx->socdev);
+freeirq:
+	free_irq(irq, mc_drv_ctx);
+unalloc:
+	kfree(mc_drv_ctx);
+	return ret_val;
 }
 
 static int __devexit snd_mfld_mc_remove(struct platform_device *pdev)
 {
-	struct platform_device *socdev =  platform_get_drvdata(pdev);
-	pr_debug("snd_mfld_mc_remove called\n");
+	struct mfld_mc_private *mc_drv_ctx = platform_get_drvdata(pdev);
 
-	platform_device_unregister(socdev);
+	pr_debug("snd_mfld_mc_remove called\n");
+	free_irq(platform_get_irq(pdev, 0), mc_drv_ctx);
+	platform_device_unregister(mc_drv_ctx->socdev);
+	kfree(mc_drv_ctx);
 	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
-- 
1.7.2.3
