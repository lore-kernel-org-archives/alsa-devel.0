From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 13/19] ASoC: mrst_machine: add jack detection
	support
Date: Wed, 04 May 2011 21:45:59 +0800
Message-ID: <20110504134559.32443.30963.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 68E12103940
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:44:36 +0200 (CEST)
In-Reply-To: <20110504133756.32443.6282.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/mid-x86/mrst_machine.c |  142 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 142 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/mrst_machine.c b/sound/soc/mid-x86/mrst_machine.c
index d70b26e..96df9a1 100644
--- a/sound/soc/mid-x86/mrst_machine.c
+++ b/sound/soc/mid-x86/mrst_machine.c
@@ -31,10 +31,83 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/gpio.h>
+#include <linux/list.h>
 #include <linux/io.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/jack.h>
+#include <../codecs/upd9976.h>
+
+/* Jack Detection */
+static struct snd_soc_jack mrst_jack;
+struct mrst_jack_context {
+	struct list_head head;
+	spinlock_t lock;
+	void __iomem *interrupt_base;
+};
+
+struct mrst_jack_node {
+	struct list_head list;
+	u8 interrupt_status;
+};
+
+static struct snd_soc_jack_pin mrst_jack_pins = {
+	.pin = "Headphone",
+	.mask = SND_JACK_HEADSET,
+};
+
+static irqreturn_t mrst_jack_intr_handler(int irq, void *dev)
+{
+	struct mrst_jack_context *context = dev;
+	u8 interrupt_status;
+	struct mrst_jack_node *node;
+	unsigned long flags;
+
+	memcpy_fromio(&interrupt_status,
+		      context->interrupt_base,
+		      sizeof(u8));
+
+	/* check if it's valid */
+	if (!(interrupt_status & 0xf))
+		return IRQ_NONE;
+
+	node = kmalloc(sizeof(*node), GFP_ATOMIC);
+	if (!node)
+		return IRQ_NONE;
+
+	INIT_LIST_HEAD(&node->list);
+	node->interrupt_status = interrupt_status;
+
+	spin_lock_irqsave(&context->lock, flags);
+	list_add_tail(&node->list, &context->head);
+	spin_unlock_irqrestore(&context->lock, flags);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t mrst_jack_detection(int irq, void *data)
+{
+	struct mrst_jack_context *context = data;
+	u8 interrupt_status;
+	unsigned long flags;
+	struct mrst_jack_node *node;
+
+	spin_lock_irqsave(&context->lock, flags);
+	if (list_empty(&context->head)) {
+		spin_unlock_irqrestore(&context->lock, flags);
+		return IRQ_HANDLED;
+	}
+	node = list_first_entry(&context->head, struct mrst_jack_node, list);
+	interrupt_status = node->interrupt_status;
+	list_del(&node->list);
+	kfree(node);
+	spin_unlock_irqrestore(&context->lock, flags);
+
+	upd9976_jack_detection(&mrst_jack, interrupt_status);
+
+	return IRQ_HANDLED;
+}
 
 static const struct snd_kcontrol_new mrst_snd_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
@@ -116,8 +189,22 @@ static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_disable_pin(dapm, "Headset MIC");
 	snd_soc_dapm_enable_pin(dapm, "Internal MIC");
 
+	snd_soc_dapm_force_enable_pin(dapm, "MIC2 Bias");
+
 	snd_soc_dapm_sync(dapm);
 
+	ret = snd_soc_jack_new(codec, "Intel(R) MID Audio Jack",
+			       (SND_JACK_HEADSET |
+				SND_JACK_BTN_0 |
+				SND_JACK_BTN_1),
+			       &mrst_jack);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_jack_add_pins(&mrst_jack, 1, &mrst_jack_pins);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -159,6 +246,9 @@ static struct snd_soc_card snd_soc_card_mrst = {
 
 static int __devinit snd_mrst_audio_probe(struct platform_device *pdev)
 {
+	int irq;
+	struct resource *irq_mem;
+	struct mrst_jack_context *jack_context = NULL;
 	int ret;
 
 	if (pdev->dev.platform_data) {
@@ -168,14 +258,59 @@ static int __devinit snd_mrst_audio_probe(struct platform_device *pdev)
 			mrst_gpio_amp = 0;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
+		goto fail_get_irq;
+	}
+
+	jack_context = kzalloc(sizeof(*jack_context), GFP_KERNEL);
+	if (!jack_context) {
+		ret = -ENOMEM;
+		goto fail_get_irq;
+	}
+	spin_lock_init(&jack_context->lock);
+	INIT_LIST_HEAD(&jack_context->head);
+
+	irq_mem = platform_get_resource_byname(pdev,
+					       IORESOURCE_MEM, "IRQ_BASE");
+	if (!irq_mem) {
+		ret = -ENODEV;
+		goto fail_alloc_context;
+	}
+
+	jack_context->interrupt_base = ioremap_nocache(irq_mem->start,
+						       resource_size(irq_mem));
+	if (!jack_context->interrupt_base) {
+		ret = -ENOMEM;
+		goto fail_alloc_context;
+	}
+
+	ret = request_threaded_irq(irq,
+				   mrst_jack_intr_handler,
+				   mrst_jack_detection,
+				   IRQF_SHARED,
+				   pdev->dev.driver->name,
+				   jack_context);
+	if (ret)
+		goto fail_request_irq;
+
 	snd_soc_card_mrst.dev = &pdev->dev;
 	ret = snd_soc_register_card(&snd_soc_card_mrst);
 	if (ret)
 		goto fail_register_card;
 
+	platform_set_drvdata(pdev, jack_context);
+
 	return 0;
 
 fail_register_card:
+	free_irq(irq, jack_context);
+fail_request_irq:
+	iounmap(jack_context->interrupt_base);
+fail_alloc_context:
+	kfree(jack_context);
+fail_get_irq:
 	if (mrst_gpio_amp)
 		gpio_free(mrst_gpio_amp);
 	return ret;
@@ -183,9 +318,16 @@ fail_register_card:
 
 static int __devexit snd_mrst_audio_remove(struct platform_device *pdev)
 {
+	struct mrst_jack_context *jack_context = platform_get_drvdata(pdev);
+	int irq = platform_get_irq(pdev, 0);
+
+	free_irq(irq, jack_context);
+	iounmap(jack_context->interrupt_base);
+	kfree(jack_context);
 	if (mrst_gpio_amp)
 		gpio_free(mrst_gpio_amp);
 	snd_soc_unregister_card(&snd_soc_card_mrst);
+
 	return 0;
 }
 
