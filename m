From: mchehab@brturbo.com.br
Subject: [Patch 02/20] V4L (930) Alsa fixes and improvements
Date: Thu, 10 Nov 2005 18:50:01 -0200
Message-ID: <1131656168.6478.39.camel@localhost>
Reply-To: Linux and Kernel Video <video4linux-list@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <video4linux-list-bounces@redhat.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com, Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

From: Ricardo Cerqueira <v4l@cerqueira.org>

- Fix nasty IRQ hook bug.
- Fix multiple board support in saa7134-alsa
- Minor comment updates
- SAA7134/ALSA IRQ management improvements
- Removed superfluous stop_dma() from saa7134-alsa IRQ handler

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/saa7134/saa7134-alsa.c |   90 ++++++++++++++---------------
 drivers/media/video/saa7134/saa7134-core.c |    1 
 2 files changed, 46 insertions(+), 45 deletions(-)

--- git13.orig/drivers/media/video/saa7134/saa7134-alsa.c
+++ git13/drivers/media/video/saa7134/saa7134-alsa.c
@@ -56,6 +56,8 @@ static int enable[SNDRV_CARDS] = {1, [1 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for SAA7134 capture interface(s).");
 
+int position;
+
 #define dprintk(fmt, arg...)    if (debug) \
         printk(KERN_DEBUG "%s/alsa: " fmt, dev->name , ## arg)
 
@@ -100,13 +102,11 @@ static snd_card_t *snd_saa7134_cards[SND
  *
  *   Called when the capture device is released or the buffer overflows
  *
- *   - Copied verbatim from saa7134-oss's dsp_dma_stop. Can be dropped
- *     if we just share dsp_dma_stop and use it here
+ *   - Copied verbatim from saa7134-oss's dsp_dma_stop.
  *
  */
 
 static void saa7134_dma_stop(struct saa7134_dev *dev)
-
 {
 	dev->dmasound.dma_blk     = -1;
 	dev->dmasound.dma_running = 0;
@@ -118,8 +118,7 @@ static void saa7134_dma_stop(struct saa7
  *
  *   Called when preparing the capture device for use
  *
- *   - Copied verbatim from saa7134-oss's dsp_dma_start. Can be dropped
- *     if we just share dsp_dma_start and use it here
+ *   - Copied verbatim from saa7134-oss's dsp_dma_start.
  *
  */
 
@@ -171,7 +170,6 @@ void saa7134_irq_alsa_done(struct saa713
 		dprintk("irq: overrun [full=%d/%d] - Blocks in %d\n",dev->dmasound.read_count,
 			dev->dmasound.bufsize, dev->dmasound.blocks);
 		snd_pcm_stop(dev->dmasound.substream,SNDRV_PCM_STATE_XRUN);
-		saa7134_dma_stop(dev);
 		goto done;
 	}
 
@@ -209,7 +207,8 @@ void saa7134_irq_alsa_done(struct saa713
 
 static irqreturn_t saa7134_alsa_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
-	struct saa7134_dev *dev = (struct saa7134_dev*) dev_id;
+	snd_card_saa7134_t *saa7134 = dev_id;
+	struct saa7134_dev *dev = saa7134->saadev;
 	unsigned long report, status;
 	int loop, handled = 0;
 
@@ -253,18 +252,18 @@ static int snd_card_saa7134_capture_trig
 	int err = 0;
 
 	spin_lock_irq(&dev->slock);
-        if (cmd == SNDRV_PCM_TRIGGER_START) {
+	if (cmd == SNDRV_PCM_TRIGGER_START) {
 		/* start dma */
 		saa7134_dma_start(dev);
-        } else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
+	} else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
 		/* stop dma */
 		saa7134_dma_stop(dev);
-        } else {
-                err = -EINVAL;
-        }
+	} else {
+		err = -EINVAL;
+	}
 	spin_unlock_irq(&dev->slock);
 
-        return err;
+	return err;
 }
 
 /*
@@ -275,8 +274,8 @@ static int snd_card_saa7134_capture_trig
  *   Must be called during the preparation stage, before memory is
  *  allocated
  *
- *   - Copied verbatim from saa7134-oss. Can be dropped
- *     if we just share dsp_buffer_conf from OSS.
+ *   - Copied verbatim from saa7134-oss.
+ *
  */
 
 static int dsp_buffer_conf(struct saa7134_dev *dev, int blksize, int blocks)
@@ -307,8 +306,8 @@ static int dsp_buffer_conf(struct saa713
  *  ALSA, but I was unable to use ALSA's own DMA, and had to force the
  *  usage of V4L's
  *
- *   - Copied verbatim from saa7134-oss. Can be dropped
- *     if we just share dsp_buffer_init from OSS.
+ *   - Copied verbatim from saa7134-oss.
+ *
  */
 
 static int dsp_buffer_init(struct saa7134_dev *dev)
@@ -369,7 +368,7 @@ static int snd_card_saa7134_capture_prep
 
 	err = dsp_buffer_init(dev);
 	if (0 != err)
-		goto fail2;
+		return err;
 
 	/* prepare buffer */
 	if (0 != (err = videobuf_dma_pci_map(dev->pci,&dev->dmasound.dma)))
@@ -560,10 +559,8 @@ static void snd_card_saa7134_runtime_fre
 static int snd_card_saa7134_hw_params(snd_pcm_substream_t * substream,
 				    snd_pcm_hw_params_t * hw_params)
 {
-
 	return 0;
 
-
 }
 
 /*
@@ -790,7 +787,6 @@ static int snd_saa7134_capsrc_get(snd_kc
 static int snd_saa7134_capsrc_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	snd_card_saa7134_t *chip = snd_kcontrol_chip(kcontrol);
-	unsigned long flags;
 	int change, addr = kcontrol->private_value;
 	int left, right;
 	u32 anabar, xbarin;
@@ -801,14 +797,14 @@ static int snd_saa7134_capsrc_put(snd_kc
 
 	left = ucontrol->value.integer.value[0] & 1;
 	right = ucontrol->value.integer.value[1] & 1;
-	spin_lock_irqsave(&chip->mixer_lock, flags);
+	spin_lock_irq(&chip->mixer_lock);
 
 	change = chip->capture_source[addr][0] != left ||
 		 chip->capture_source[addr][1] != right;
 	chip->capture_source[addr][0] = left;
 	chip->capture_source[addr][1] = right;
 	dev->dmasound.input=addr;
-	spin_unlock_irqrestore(&chip->mixer_lock, flags);
+	spin_unlock_irq(&chip->mixer_lock);
 
 
 	if (change) {
@@ -898,28 +894,33 @@ static int snd_card_saa7134_new_mixer(sn
 	return 0;
 }
 
-static int snd_saa7134_free(snd_card_saa7134_t *chip)
+static void snd_saa7134_free(snd_card_t * card)
 {
-	return 0;
+	return;
 }
 
 static int snd_saa7134_dev_free(snd_device_t *device)
 {
 	snd_card_saa7134_t *chip = device->device_data;
-	return snd_saa7134_free(chip);
+
+	if (chip->irq >= 0) {
+		synchronize_irq(chip->irq);
+		free_irq(chip->irq, (void *) chip);
+	}
+
+	return 0;
 }
 
 /*
  * ALSA initialization
  *
- *   Called by saa7134-core, it creates the basic structures and registers
- *  the ALSA devices
+ *   Called by the init routine, once for each saa7134 device present,
+ *  it creates the basic structures and registers the ALSA devices
  *
  */
 
-int alsa_card_saa7134_create (struct saa7134_dev *saadev)
+int alsa_card_saa7134_create(struct saa7134_dev *saadev, int dev)
 {
-	static int dev;
 
 	snd_card_t *card;
 	snd_card_saa7134_t *chip;
@@ -934,7 +935,7 @@ int alsa_card_saa7134_create (struct saa
 	if (!enable[dev])
 		return -ENODEV;
 
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE, sizeof(snd_card_saa7134_t));
 
 	if (card == NULL)
 		return -ENOMEM;
@@ -943,10 +944,8 @@ int alsa_card_saa7134_create (struct saa
 
 	/* Card "creation" */
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL) {
-		return -ENOMEM;
-	}
+	card->private_free = snd_saa7134_free;
+	chip = (snd_card_saa7134_t *) card->private_data;
 
 	spin_lock_init(&chip->lock);
 	spin_lock_init(&chip->mixer_lock);
@@ -960,7 +959,7 @@ int alsa_card_saa7134_create (struct saa
 	chip->iobase = pci_resource_start(saadev->pci, 0);
 
 	err = request_irq(saadev->pci->irq, saa7134_alsa_irq,
-				SA_SHIRQ | SA_INTERRUPT, saadev->name, saadev);
+				SA_SHIRQ | SA_INTERRUPT, saadev->name, (void *)chip);
 
 	if (err < 0) {
 		printk(KERN_ERR "%s: can't get IRQ %d for ALSA\n",
@@ -993,7 +992,6 @@ int alsa_card_saa7134_create (struct saa
 
 __nodev:
 	snd_card_free(card);
-	kfree(chip);
 	return err;
 }
 
@@ -1007,21 +1005,23 @@ __nodev:
 
 static int saa7134_alsa_init(void)
 {
-        struct saa7134_dev *saadev = NULL;
-        struct list_head *list;
+	struct saa7134_dev *saadev = NULL;
+	struct list_head *list;
 
-	printk(KERN_INFO "saa7134 ALSA driver for DMA sound loaded\n");
+	position = 0;
 
-        list_for_each(list,&saa7134_devlist) {
-                saadev = list_entry(list, struct saa7134_dev, devlist);
-		alsa_card_saa7134_create(saadev);
-        }
+        printk(KERN_INFO "saa7134 ALSA driver for DMA sound loaded\n");
+
+	list_for_each(list,&saa7134_devlist) {
+		saadev = list_entry(list, struct saa7134_dev, devlist);
+		alsa_card_saa7134_create(saadev,position);
+		position++;
+	}
 
 	if (saadev == NULL)
 		printk(KERN_INFO "saa7134 ALSA: no saa7134 cards found\n");
 
 	return 0;
-
 }
 
 /*
--- git13.orig/drivers/media/video/saa7134/saa7134-core.c
+++ git13/drivers/media/video/saa7134/saa7134-core.c
@@ -1064,6 +1064,7 @@ static int __devinit saa7134_initdev(str
 
 	/* check for signal */
 	saa7134_irq_video_intl(dev);
+
 	return 0;
 
  fail5:


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
