From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH v2 07/10] ASoC: upd9976: add jack detection
	function
Date: Fri, 06 May 2011 13:46:34 +0800
Message-ID: <20110506054634.26312.80750.stgit@localhost>
References: <20110506053852.26312.79083.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id C5D32103A23
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 07:45:07 +0200 (CEST)
In-Reply-To: <20110506053852.26312.79083.stgit@localhost>
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

All the interrupt handling is done here in codec driver.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/codecs/upd9976.c |  182 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/upd9976.h |    4 +
 2 files changed, 184 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/upd9976.c b/sound/soc/codecs/upd9976.c
index 4a790c5..c1b08f9 100644
--- a/sound/soc/codecs/upd9976.c
+++ b/sound/soc/codecs/upd9976.c
@@ -27,6 +27,8 @@
  */
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/list.h>
 #include <asm/intel_scu_ipc.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -37,6 +39,97 @@
 #include <sound/jack.h>
 #include "upd9976.h"
 
+struct upd9976_priv {
+	int irq;
+	struct resource *irq_mem;
+	void __iomem *int_base;
+	struct snd_soc_jack *jack;
+	int jack_init;
+	struct list_head pending_status;
+	spinlock_t lock;
+};
+
+struct upd9976_jack_node {
+	struct list_head list;
+	u8 interrupt_status;
+};
+
+static irqreturn_t upd9976_jack_intr_handler(int irq, void *dev)
+{
+	struct upd9976_priv *upd9976 = dev;
+	u8 interrupt_status;
+	struct upd9976_jack_node *node;
+	unsigned long flags;
+
+	memcpy_fromio(&interrupt_status,
+		      upd9976->int_base,
+		      sizeof(u8));
+
+	/* check if it's valid */
+	if (!(interrupt_status & 0xf))
+		return IRQ_NONE;
+
+	node = kzalloc(sizeof(*node), GFP_ATOMIC);
+	if (!node)
+		return IRQ_NONE;
+
+	INIT_LIST_HEAD(&node->list);
+	node->interrupt_status = interrupt_status;
+
+	spin_lock_irqsave(&upd9976->lock, flags);
+	list_add_tail(&node->list, &upd9976->pending_status);
+	spin_unlock_irqrestore(&upd9976->lock, flags);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t upd9976_jack_thread_handler(int irq, void *data)
+{
+	struct upd9976_priv *upd9976 = data;
+	struct snd_soc_jack *jack = upd9976->jack;
+	struct snd_soc_codec *codec = jack->codec;
+	struct upd9976_jack_node *node;
+	u8 interrupt_status;
+	unsigned long flags;
+	int status = 0;
+	unsigned int value = 0;
+	int mask = SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_HEADSET;
+
+	spin_lock_irqsave(&upd9976->lock, flags);
+	if (list_empty(&upd9976->pending_status)) {
+		spin_unlock_irqrestore(&upd9976->lock, flags);
+		return IRQ_HANDLED;
+	}
+	node = list_first_entry(&upd9976->pending_status,
+				struct upd9976_jack_node,
+				list);
+	interrupt_status = node->interrupt_status;
+	list_del(&node->list);
+	kfree(node);
+	spin_unlock_irqrestore(&upd9976->lock, flags);
+
+	if (interrupt_status & 0x3)
+		value = snd_soc_read(codec, UPD9976_SAUXINT);
+
+	if (interrupt_status & 0x1 && value == 0x1)
+		status |= SND_JACK_HEADSET;
+
+	if (interrupt_status & 0x2 && value == 0x2)
+		status |= SND_JACK_HEADPHONE;
+
+	if (interrupt_status & 0x4)
+		status |= SND_JACK_HEADSET | SND_JACK_BTN_0;
+
+	if (interrupt_status & 0x8)
+		status |= SND_JACK_HEADSET | SND_JACK_BTN_1;
+
+	snd_soc_jack_report(jack, status, mask);
+	if (status & (SND_JACK_BTN_0 | SND_JACK_BTN_1))
+		snd_soc_jack_report(jack, SND_JACK_HEADSET, mask);
+
+	return IRQ_HANDLED;
+}
+
 static inline unsigned int upd9976_read(struct snd_soc_codec *codec,
 					unsigned int reg)
 {
@@ -62,6 +155,24 @@ static inline int upd9976_write(struct snd_soc_codec *codec,
 	return ret;
 }
 
+int upd9976_jack_detect(struct snd_soc_codec *codec,
+			struct snd_soc_jack *jack,
+			unsigned int debounce)
+{
+	struct upd9976_priv *upd9976 = snd_soc_codec_get_drvdata(codec);
+
+	if (!upd9976->jack_init)
+		return -ENODEV;
+
+	upd9976->jack = jack;
+
+	/* set debounce time */
+	snd_soc_write(codec, UPD9976_AUXDBNC, debounce);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(upd9976_jack_detect);
+
 /*
  * Mixing Volume: from -25 dB to 6 dB in 1 dB steps.
  */
@@ -452,13 +563,50 @@ static int upd9976_set_bias_level(struct snd_soc_codec *codec,
 
 static int upd9976_codec_probe(struct snd_soc_codec *codec)
 {
+	struct upd9976_priv *upd9976 = snd_soc_codec_get_drvdata(codec);
+
 	upd9976_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
+	/* disable jack detection first, will be enabled later */
+	snd_soc_update_bits(codec, UPD9976_MICCTRL, BIT(4), 0);
+
+	spin_lock_init(&upd9976->lock);
+	INIT_LIST_HEAD(&upd9976->pending_status);
+
+	upd9976->jack_init = 0;
+
+	if (upd9976->irq < 0 || !upd9976->irq_mem)
+		return 0;
+
+	upd9976->int_base = ioremap_nocache(upd9976->irq_mem->start,
+					    resource_size(upd9976->irq_mem));
+	if (!upd9976->int_base)
+		return 0;
+
+	if (request_threaded_irq(upd9976->irq,
+				 upd9976_jack_intr_handler,
+				 upd9976_jack_thread_handler,
+				 IRQF_SHARED,
+				 "jack detection",
+				 upd9976)) {
+		iounmap(upd9976->int_base);
+		return 0;
+	}
+
+	upd9976->jack_init = 1;
+
 	return 0;
 }
 
 static int upd9976_codec_remove(struct snd_soc_codec *codec)
 {
+	struct upd9976_priv *upd9976 = snd_soc_codec_get_drvdata(codec);
+
+	if (upd9976->jack_init) {
+		free_irq(upd9976->irq, upd9976);
+		iounmap(upd9976->int_base);
+	}
+
 	upd9976_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
@@ -481,13 +629,43 @@ static struct snd_soc_codec_driver upd9976_codec = {
 
 static int __devinit upd9976_device_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev, &upd9976_codec,
-				      upd9976_dais, ARRAY_SIZE(upd9976_dais));
+	struct upd9976_priv *upd9976;
+	int err;
+
+	upd9976 = kzalloc(sizeof(*upd9976), GFP_KERNEL);
+	if (!upd9976) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	upd9976->irq = platform_get_irq(pdev, 0);
+	upd9976->irq_mem = platform_get_resource_byname(pdev,
+							IORESOURCE_MEM,
+							"IRQ_BASE");
+	platform_set_drvdata(pdev, upd9976);
+
+	err = snd_soc_register_codec(&pdev->dev, &upd9976_codec,
+				     upd9976_dais, ARRAY_SIZE(upd9976_dais));
+	if (err)
+		goto fail_register_codec;
+
+	return 0;
+
+fail_register_codec:
+	platform_set_drvdata(pdev, NULL);
+	kfree(upd9976);
+fail:
+	return err;
 }
 
 static int __devexit upd9976_device_remove(struct platform_device *pdev)
 {
+	struct upd9976_priv *upd9976 = platform_get_drvdata(pdev);
+
 	snd_soc_unregister_codec(&pdev->dev);
+	platform_set_drvdata(pdev, NULL);
+	kfree(upd9976);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/upd9976.h b/sound/soc/codecs/upd9976.h
index ab2ea15..b1bb8d0 100644
--- a/sound/soc/codecs/upd9976.h
+++ b/sound/soc/codecs/upd9976.h
@@ -80,4 +80,8 @@
 
 #define UPD9976_SAUXINT		0x132
 
+int upd9976_jack_detect(struct snd_soc_codec *codec,
+			struct snd_soc_jack *jack,
+			unsigned int debounce);
+
 #endif
