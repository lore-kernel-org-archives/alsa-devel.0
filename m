From: Harsha Priya <priya.harsha@intel.com>
Subject: [PATCH 2/3] ASoC: mid-x86 machine driver - add jack
	detect support
Date: Fri, 28 Jan 2011 22:40:04 +0530
Message-ID: <1296234604-6653-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 84DAE24337
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 17:55:12 +0100 (CET)
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
Cc: Harsha Priya <priya.harsha@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch adds the jack detection in mid-86 machine driver

Signed-off-by: Harsha Priya <priya.harsha@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/mid-x86/mfld_machine.c |  175 ++++++++++++++++++++++++++++++++------
 1 files changed, 148 insertions(+), 27 deletions(-)

diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 1a330be..d708da8 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -35,10 +36,33 @@
 #define MID_MONO 1
 #define MID_STEREO 2
 #define MID_MAX_CAP 5
+#define IRQ_BASE 0xFFFF7FCD
+#define IRQ_SIZE 1
 
 static unsigned int	hs_switch;
 static unsigned int	lo_dac;
 
+struct mfld_mc_private {
+	struct platform_device *socdev;
+	struct workqueue_struct *mfld_jack_wq;
+	void __iomem *int_base;
+	struct snd_soc_codec *codec;
+} mc_drv_ctx;
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
 
@@ -67,13 +91,11 @@ static int headset_set_switch(struct snd_kcontrol *kcontrol,
 
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
@@ -91,12 +113,10 @@ static void lo_enable_out_pins(struct snd_soc_codec *codec)
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
@@ -130,8 +150,7 @@ static int lo_set_switch(struct snd_kcontrol *kcontrol,
 
 	case 1:
 		pr_debug("set hs  path\n");
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "Headphones");
 		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
 		snd_soc_update_bits(codec, SN95031_LOCTL, 0x66, 0x22);
 		break;
@@ -162,12 +181,36 @@ static const struct snd_kcontrol_new mfld_snd_controls[] = {
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
+	mc_drv_ctx.codec = codec;
+
 	ret_val = snd_soc_add_controls(codec, mfld_snd_controls,
 				ARRAY_SIZE(mfld_snd_controls));
 	if (ret_val) {
@@ -175,14 +218,32 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 		return ret_val;
 	}
 	/* default is earpiece pin, userspace sets it explcitly */
-	snd_soc_dapm_disable_pin(dapm, "HPOUTL");
-	snd_soc_dapm_disable_pin(dapm, "HPOUTR");
+	snd_soc_dapm_disable_pin(dapm, "Headphones");
 	/* default is lineout NC, userspace sets it explcitly */
 	snd_soc_dapm_disable_pin(dapm, "LINEOUTL");
 	snd_soc_dapm_disable_pin(dapm, "LINEOUTR");
 	lo_dac = 3;
 	hs_switch = 0;
-	return snd_soc_dapm_sync(dapm);
+	snd_soc_dapm_sync(dapm);
+
+	/* Headset jack detection */
+	ret_val = snd_soc_jack_new(codec, "Intel(R) MID Audio Jack",
+			SND_JACK_HEADSET | SND_JACK_BTN_0 |
+			SND_JACK_BTN_1, &mfld_jack);
+
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
+	return ret_val;
 }
 
 struct snd_soc_dai_link mfld_msic_dailink[] = {
@@ -231,37 +292,97 @@ static struct snd_soc_card snd_soc_card_mfld = {
 	.num_links = ARRAY_SIZE(mfld_msic_dailink),
 };
 
+void snd_mfld_jack_detection(struct work_struct *work)
+{
+	struct mfld_jack_msg_wq *jack_msg =
+			container_of(work, struct mfld_jack_msg_wq, wq);
+
+	sn95031_jack_detection(&mfld_jack, jack_msg);
+	kfree(jack_msg);
+}
+
+static irqreturn_t snd_mfld_jack_intr_handler(int irq, void *dev)
+{
+	struct mfld_jack_msg_wq *jack_msg;
+	struct mfld_mc_private *mc_private = (struct mfld_mc_private *) dev;
+
+	jack_msg = kzalloc(sizeof(*jack_msg), GFP_ATOMIC);
+	memcpy_fromio(&jack_msg->intr_id,
+			((void *)(mc_private->int_base)),
+			sizeof(u8));
+	jack_msg->codec = mc_private->codec;
+	pr_debug("snd_mfld_jack_intr_handler called value %x\n",
+					jack_msg->intr_id);
+	INIT_WORK(&jack_msg->wq, snd_mfld_jack_detection);
+	queue_work(mc_private->mfld_jack_wq, &jack_msg->wq);
+
+	return IRQ_HANDLED;
+}
+
 static int __devinit snd_mfld_mc_probe(struct platform_device *pdev)
 {
-	struct platform_device *socdev;
-	int ret_val = 0;
+	int ret_val = 0, irq;
 
 	pr_debug("snd_mfld_mc_probe called\n");
 
-	socdev =  platform_device_alloc("soc-audio", -1);
-	if (!socdev) {
+	/* retrive the irq number */
+	irq = platform_get_irq(pdev, 0);
+	/*	audio interrupt base of SRAM location where
+	*	interrupts are stored by System FW */
+	mc_drv_ctx.int_base = ioremap_nocache(IRQ_BASE, IRQ_SIZE);
+	if (!mc_drv_ctx.int_base) {
+		pr_err("Mapping of cache failed\n");
+		ret_val = -ENOMEM;
+		goto unalloc;
+	}
+	/* create botoom half handler for interrupt */
+	mc_drv_ctx.mfld_jack_wq = create_workqueue("mfld_jack_wq");
+	if (!mc_drv_ctx.mfld_jack_wq) {
+		pr_err("cannot create jack workqueue\n");
+		ret_val = -ENOMEM;
+		goto unalloc;
+	}
+	/* register for interrupt */
+	ret_val = request_irq(irq, snd_mfld_jack_intr_handler,
+				IRQF_SHARED, pdev->dev.driver->name,
+				&mc_drv_ctx);
+	if (ret_val) {
+		pr_err("cannot register IRQ\n");
+		goto destroy_wq;
+	}
+	/* create soc device */
+	mc_drv_ctx.socdev = platform_device_alloc("soc-audio", -1);
+	if (!mc_drv_ctx.socdev) {
 		pr_err("soc-audio device allocation failed\n");
-		return -ENOMEM;
+		ret_val = -ENOMEM;
+		goto destroy_wq;
 	}
-	platform_set_drvdata(socdev, &snd_soc_card_mfld);
-	ret_val = platform_device_add(socdev);
+	platform_set_drvdata(mc_drv_ctx.socdev, &snd_soc_card_mfld);
+	ret_val = platform_device_add(mc_drv_ctx.socdev);
 	if (ret_val) {
 		pr_err("Unable to add soc-audio device, err %d\n", ret_val);
-		platform_device_put(socdev);
+		goto unregister;
 	}
-
-	platform_set_drvdata(pdev, socdev);
-
+	platform_set_drvdata(pdev, &mc_drv_ctx);
 	pr_debug("successfully exited probe\n");
 	return ret_val;
+
+unregister:
+	platform_device_put(mc_drv_ctx.socdev);
+destroy_wq:
+	destroy_workqueue(mc_drv_ctx.mfld_jack_wq);
+unalloc:
+	return ret_val;
 }
 
 static int __devexit snd_mfld_mc_remove(struct platform_device *pdev)
 {
-	struct platform_device *socdev =  platform_get_drvdata(pdev);
-	pr_debug("snd_mfld_mc_remove called\n");
+	struct mfld_mc_private *mc_private_data = platform_get_drvdata(pdev);
 
-	platform_device_unregister(socdev);
+	pr_debug("snd_mfld_mc_remove called\n");
+	free_irq(platform_get_irq(pdev, 0), mc_private_data);
+	destroy_workqueue(mc_private_data->mfld_jack_wq);
+	platform_device_unregister(mc_private_data->socdev);
 	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
-- 
1.7.3.4
