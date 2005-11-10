From: mchehab@brturbo.com.br
Subject: [Patch 13/20] V4L (951) Make saa7134-oss as a stand-alone module
Date: Thu, 10 Nov 2005 18:50:02 -0200
Message-ID: <1131656168.6478.40.camel@localhost>
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

- saa7134-oss is now a standalone module as well
- remaining DMA sound code has been removed from core the module
- Lots of small cleanups and variable renames to get more consistency
  between the OSS and ALSA drivers
- Fixed saa7134-alsa spinlock bug
- Added missing #include in saa7134-oss

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/saa7134/Makefile       |    7 -
 drivers/media/video/saa7134/saa7134-alsa.c |  130 +++++++++++------------
 drivers/media/video/saa7134/saa7134-core.c |  118 +++++---------------
 drivers/media/video/saa7134/saa7134-oss.c  |  163 ++++++++++++++++++++++++++---
 drivers/media/video/saa7134/saa7134.h      |    1 
 5 files changed, 251 insertions(+), 168 deletions(-)

--- git13.orig/drivers/media/video/saa7134/Makefile
+++ git13/drivers/media/video/saa7134/Makefile
@@ -1,10 +1,11 @@
 
 saa7134-objs :=	saa7134-cards.o saa7134-core.o saa7134-i2c.o	\
-		saa7134-oss.o saa7134-ts.o saa7134-tvaudio.o	\
-		saa7134-vbi.o saa7134-video.o saa7134-input.o
+		saa7134-ts.o saa7134-tvaudio.o saa7134-vbi.o    \
+		saa7134-video.o saa7134-input.o
 
 obj-$(CONFIG_VIDEO_SAA7134) +=  saa7134.o saa7134-empress.o \
-				saa6752hs.o saa7134-alsa.o
+				saa6752hs.o saa7134-alsa.o \
+				saa7134-oss.o
 obj-$(CONFIG_VIDEO_SAA7134_DVB) += saa7134-dvb.o
 
 EXTRA_CFLAGS += -I$(src)/..
--- git13.orig/drivers/media/video/saa7134/saa7134-alsa.c
+++ git13/drivers/media/video/saa7134/saa7134-alsa.c
@@ -71,7 +71,7 @@ typedef struct snd_card_saa7134 {
 	int mixer_volume[MIXER_ADDR_LAST+1][2];
 	int capture_source[MIXER_ADDR_LAST+1][2];
 	struct pci_dev *pci;
-	struct saa7134_dev *saadev;
+	struct saa7134_dev *dev;
 
 	unsigned long iobase;
 	int irq;
@@ -86,12 +86,10 @@ typedef struct snd_card_saa7134 {
  */
 
 typedef struct snd_card_saa7134_pcm {
-	struct saa7134_dev *saadev;
+	struct saa7134_dev *dev;
 
 	spinlock_t lock;
-	unsigned int pcm_size;		/* buffer size */
-	unsigned int pcm_count;		/* bytes per period */
-	unsigned int pcm_bps;		/* bytes per second */
+
 	snd_pcm_substream_t *substream;
 } snd_card_saa7134_pcm_t;
 
@@ -193,6 +191,7 @@ void saa7134_irq_alsa_done(struct saa713
 		snd_pcm_period_elapsed(dev->dmasound.substream);
 		spin_lock(&dev->slock);
 	}
+
  done:
 	spin_unlock(&dev->slock);
 
@@ -208,8 +207,9 @@ void saa7134_irq_alsa_done(struct saa713
 
 static irqreturn_t saa7134_alsa_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
-	snd_card_saa7134_t *saa7134 = dev_id;
-	struct saa7134_dev *dev = saa7134->saadev;
+        struct saa7134_dmasound *dmasound = dev_id;
+        struct saa7134_dev *dev = dmasound->priv_data;
+
 	unsigned long report, status;
 	int loop, handled = 0;
 
@@ -248,8 +248,8 @@ static int snd_card_saa7134_capture_trig
 					  int cmd)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	snd_card_saa7134_pcm_t *saapcm = runtime->private_data;
-	struct saa7134_dev *dev=saapcm->saadev;
+	snd_card_saa7134_pcm_t *pcm = runtime->private_data;
+	struct saa7134_dev *dev=pcm->dev;
 	int err = 0;
 
 	spin_lock_irq(&dev->slock);
@@ -315,8 +315,8 @@ static int dsp_buffer_init(struct saa713
 {
 	int err;
 
-	if (!dev->dmasound.bufsize)
-		BUG();
+	BUG_ON(!dev->dmasound.bufsize);
+
 	videobuf_dma_init(&dev->dmasound.dma);
 	err = videobuf_dma_init_kernel(&dev->dmasound.dma, PCI_DMA_FROMDEVICE,
 				       (dev->dmasound.bufsize + PAGE_SIZE) >> PAGE_SHIFT);
@@ -344,28 +344,18 @@ static int snd_card_saa7134_capture_prep
 	u32 fmt, control;
 	snd_card_saa7134_t *saa7134 = snd_pcm_substream_chip(substream);
 	struct saa7134_dev *dev;
-	snd_card_saa7134_pcm_t *saapcm = runtime->private_data;
-	unsigned int bps;
+	snd_card_saa7134_pcm_t *pcm = runtime->private_data;
 	unsigned long size;
 	unsigned count;
 
 	size = snd_pcm_lib_buffer_bytes(substream);
 	count = snd_pcm_lib_period_bytes(substream);
 
-	saapcm->saadev->dmasound.substream = substream;
-	bps = runtime->rate * runtime->channels;
-	bps *= snd_pcm_format_width(runtime->format);
-	bps /= 8;
-	if (bps <= 0)
-		return -EINVAL;
-	saapcm->pcm_bps = bps;
-	saapcm->pcm_size = snd_pcm_lib_buffer_bytes(substream);
-	saapcm->pcm_count = snd_pcm_lib_period_bytes(substream);
-
+	pcm->dev->dmasound.substream = substream;
 
-	dev=saa7134->saadev;
+	dev=saa7134->dev;
 
-	dsp_buffer_conf(dev,saapcm->pcm_count,(saapcm->pcm_size/saapcm->pcm_count));
+	dsp_buffer_conf(dev,count,(size/count));
 
 	err = dsp_buffer_init(dev);
 	if (0 != err)
@@ -445,7 +435,6 @@ static int snd_card_saa7134_capture_prep
 			fmt |= 0x04;
 		saa_writel(SAA7133_NUM_SAMPLES, dev->dmasound.blksize -1);
 		saa_writel(SAA7133_AUDIO_CHANNEL, 0x543210 | (fmt << 24));
-		//saa_writel(SAA7133_AUDIO_CHANNEL, 0x543210);
 		break;
 	}
 
@@ -496,10 +485,8 @@ static int snd_card_saa7134_capture_prep
 static snd_pcm_uframes_t snd_card_saa7134_capture_pointer(snd_pcm_substream_t * substream)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	snd_card_saa7134_pcm_t *saapcm = runtime->private_data;
-	struct saa7134_dev *dev=saapcm->saadev;
-
-
+	snd_card_saa7134_pcm_t *pcm = runtime->private_data;
+	struct saa7134_dev *dev=pcm->dev;
 
 	if (dev->dmasound.read_count) {
 		dev->dmasound.read_count  -= snd_pcm_lib_period_bytes(substream);
@@ -540,9 +527,9 @@ static snd_pcm_hardware_t snd_card_saa71
 
 static void snd_card_saa7134_runtime_free(snd_pcm_runtime_t *runtime)
 {
-	snd_card_saa7134_pcm_t *saapcm = runtime->private_data;
+	snd_card_saa7134_pcm_t *pcm = runtime->private_data;
 
-	kfree(saapcm);
+	kfree(pcm);
 }
 
 
@@ -571,7 +558,7 @@ static int snd_card_saa7134_hw_params(sn
  *
  *   Called after closing the device, but before snd_card_saa7134_capture_close
  *   Usually used in ALSA to free the DMA, but since we don't use the
- *  ALSA DMA I'm almost sure this isn't necessary.
+ *  ALSA DMA it does nothing
  *
  */
 
@@ -614,7 +601,7 @@ static int dsp_buffer_free(struct saa713
 static int snd_card_saa7134_capture_close(snd_pcm_substream_t * substream)
 {
 	snd_card_saa7134_t *chip = snd_pcm_substream_chip(substream);
-	struct saa7134_dev *dev = chip->saadev;
+	struct saa7134_dev *dev = chip->dev;
 
 	/* unlock buffer */
 	saa7134_pgtable_free(dev->pci,&dev->dmasound.pt);
@@ -637,29 +624,28 @@ static int snd_card_saa7134_capture_clos
 static int snd_card_saa7134_capture_open(snd_pcm_substream_t * substream)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	snd_card_saa7134_pcm_t *saapcm;
+	snd_card_saa7134_pcm_t *pcm;
 	snd_card_saa7134_t *saa7134 = snd_pcm_substream_chip(substream);
-	struct saa7134_dev *dev = saa7134->saadev;
+	struct saa7134_dev *dev = saa7134->dev;
 	int err;
 
 	down(&dev->dmasound.lock);
 
-	dev->dmasound.afmt        = SNDRV_PCM_FORMAT_U8;
-	dev->dmasound.channels    = 2;
 	dev->dmasound.read_count  = 0;
 	dev->dmasound.read_offset = 0;
 
 	up(&dev->dmasound.lock);
 
-	saapcm = kzalloc(sizeof(*saapcm), GFP_KERNEL);
-	if (saapcm == NULL)
+	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
+	if (pcm == NULL)
 		return -ENOMEM;
-	saapcm->saadev=saa7134->saadev;
 
-	spin_lock_init(&saapcm->lock);
+	pcm->dev=saa7134->dev;
+
+	spin_lock_init(&pcm->lock);
 
-	saapcm->substream = substream;
-	runtime->private_data = saapcm;
+	pcm->substream = substream;
+	runtime->private_data = pcm;
 	runtime->private_free = snd_card_saa7134_runtime_free;
 	runtime->hw = snd_card_saa7134_capture;
 
@@ -782,6 +768,7 @@ static int snd_saa7134_capsrc_get(snd_kc
 	ucontrol->value.integer.value[0] = chip->capture_source[addr][0];
 	ucontrol->value.integer.value[1] = chip->capture_source[addr][1];
 	spin_unlock_irqrestore(&chip->mixer_lock, flags);
+
 	return 0;
 }
 
@@ -794,7 +781,7 @@ static int snd_saa7134_capsrc_put(snd_kc
 	int analog_io, rate;
 	struct saa7134_dev *dev;
 
-	dev = chip->saadev;
+	dev = chip->dev;
 
 	left = ucontrol->value.integer.value[0] & 1;
 	right = ucontrol->value.integer.value[1] & 1;
@@ -904,11 +891,16 @@ static int snd_saa7134_dev_free(snd_devi
 {
 	snd_card_saa7134_t *chip = device->device_data;
 
+	if (chip->dev->dmasound.priv_data == NULL)
+		return 0;
+
 	if (chip->irq >= 0) {
 		synchronize_irq(chip->irq);
-		free_irq(chip->irq, (void *) chip);
+		free_irq(chip->irq, &chip->dev->dmasound);
 	}
 
+	chip->dev->dmasound.priv_data = NULL;
+
 	return 0;
 }
 
@@ -920,7 +912,7 @@ static int snd_saa7134_dev_free(snd_devi
  *
  */
 
-int alsa_card_saa7134_create(struct saa7134_dev *saadev, int dev)
+int alsa_card_saa7134_create(struct saa7134_dev *dev, int devnum)
 {
 
 	snd_card_t *card;
@@ -931,12 +923,12 @@ int alsa_card_saa7134_create(struct saa7
 	};
 
 
-	if (dev >= SNDRV_CARDS)
+	if (devnum >= SNDRV_CARDS)
 		return -ENODEV;
-	if (!enable[dev])
+	if (!enable[devnum])
 		return -ENODEV;
 
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, sizeof(snd_card_saa7134_t));
+	card = snd_card_new(index[devnum], id[devnum], THIS_MODULE, sizeof(snd_card_saa7134_t));
 
 	if (card == NULL)
 		return -ENOMEM;
@@ -951,23 +943,27 @@ int alsa_card_saa7134_create(struct saa7
 	spin_lock_init(&chip->lock);
 	spin_lock_init(&chip->mixer_lock);
 
-	chip->saadev = saadev;
+	chip->dev = dev;
 
 	chip->card = card;
 
-	chip->pci = saadev->pci;
-	chip->irq = saadev->pci->irq;
-	chip->iobase = pci_resource_start(saadev->pci, 0);
+	chip->pci = dev->pci;
+	chip->irq = dev->pci->irq;
+	chip->iobase = pci_resource_start(dev->pci, 0);
+
 
-	err = request_irq(saadev->pci->irq, saa7134_alsa_irq,
-				SA_SHIRQ | SA_INTERRUPT, saadev->name, (void *)chip);
+	err = request_irq(dev->pci->irq, saa7134_alsa_irq,
+				SA_SHIRQ | SA_INTERRUPT, dev->name,
+				(void*) &dev->dmasound);
 
 	if (err < 0) {
 		printk(KERN_ERR "%s: can't get IRQ %d for ALSA\n",
-			saadev->name, saadev->pci->irq);
+			dev->name, dev->pci->irq);
 		goto __nodev;
 	}
 
+	init_MUTEX(&dev->dmasound.lock);
+
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
 		goto __nodev;
 	}
@@ -984,10 +980,10 @@ int alsa_card_saa7134_create(struct saa7
 
 	strcpy(card->shortname, "SAA7134");
 	sprintf(card->longname, "%s at 0x%lx irq %d",
-		chip->saadev->name, chip->iobase, chip->irq);
+		chip->dev->name, chip->iobase, chip->irq);
 
 	if ((err = snd_card_register(card)) == 0) {
-		snd_saa7134_cards[dev] = card;
+		snd_saa7134_cards[devnum] = card;
 		return 0;
 	}
 
@@ -1006,7 +1002,7 @@ __nodev:
 
 static int saa7134_alsa_init(void)
 {
-	struct saa7134_dev *saadev = NULL;
+	struct saa7134_dev *dev = NULL;
 	struct list_head *list;
 
 	position = 0;
@@ -1014,12 +1010,18 @@ static int saa7134_alsa_init(void)
         printk(KERN_INFO "saa7134 ALSA driver for DMA sound loaded\n");
 
 	list_for_each(list,&saa7134_devlist) {
-		saadev = list_entry(list, struct saa7134_dev, devlist);
-		alsa_card_saa7134_create(saadev,position);
-		position++;
+		dev = list_entry(list, struct saa7134_dev, devlist);
+		if (dev->dmasound.priv_data == NULL) {
+			dev->dmasound.priv_data = dev;
+			alsa_card_saa7134_create(dev,position);
+			position++;
+		} else {
+			printk(KERN_ERR "saa7134 ALSA: DMA sound is being handled by OSS. ignoring %s\n",dev->name);
+			return -EBUSY;
+		}
 	}
 
-	if (saadev == NULL)
+	if (dev == NULL)
 		printk(KERN_INFO "saa7134 ALSA: no saa7134 cards found\n");
 
 	return 0;
--- git13.orig/drivers/media/video/saa7134/saa7134-core.c
+++ git13/drivers/media/video/saa7134/saa7134-core.c
@@ -53,13 +53,13 @@ static unsigned int gpio_tracking = 0;
 module_param(gpio_tracking, int, 0644);
 MODULE_PARM_DESC(gpio_tracking,"enable debug messages [gpio]");
 
-static unsigned int oss = 0;
-module_param(oss, int, 0444);
-MODULE_PARM_DESC(oss,"register oss devices (default: no)");
-
 static unsigned int alsa = 0;
-module_param(alsa, int, 0444);
-MODULE_PARM_DESC(alsa,"register alsa devices (default: no)");
+module_param(alsa, int, 0644);
+MODULE_PARM_DESC(alsa,"enable ALSA DMA sound [dmasound]");
+
+static unsigned int oss = 0;
+module_param(oss, int, 0644);
+MODULE_PARM_DESC(oss,"enable OSS DMA sound [dmasound]");
 
 static unsigned int latency = UNSET;
 module_param(latency, int, 0444);
@@ -68,24 +68,18 @@ MODULE_PARM_DESC(latency,"pci latency ti
 static unsigned int video_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
 static unsigned int vbi_nr[]   = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
 static unsigned int radio_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
-static unsigned int dsp_nr[]   = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
-static unsigned int mixer_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
 static unsigned int tuner[]    = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
 static unsigned int card[]     = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
 
 module_param_array(video_nr, int, NULL, 0444);
 module_param_array(vbi_nr,   int, NULL, 0444);
 module_param_array(radio_nr, int, NULL, 0444);
-module_param_array(dsp_nr,   int, NULL, 0444);
-module_param_array(mixer_nr, int, NULL, 0444);
 module_param_array(tuner,    int, NULL, 0444);
 module_param_array(card,     int, NULL, 0444);
 
 MODULE_PARM_DESC(video_nr, "video device number");
 MODULE_PARM_DESC(vbi_nr,   "vbi device number");
 MODULE_PARM_DESC(radio_nr, "radio device number");
-MODULE_PARM_DESC(dsp_nr,   "oss dsp device number");
-MODULE_PARM_DESC(mixer_nr, "oss mixer device number");
 MODULE_PARM_DESC(tuner,    "tuner type");
 MODULE_PARM_DESC(card,     "card type");
 
@@ -195,6 +189,7 @@ void saa7134_track_gpio(struct saa7134_d
 static int need_empress;
 static int need_dvb;
 static int need_alsa;
+static int need_oss;
 
 static int pending_call(struct notifier_block *self, unsigned long state,
 			void *module)
@@ -208,6 +203,8 @@ static int pending_call(struct notifier_
 		request_module("saa7134-dvb");
 	if (need_alsa)
 		request_module("saa7134-alsa");
+	if (need_oss)
+		request_module("saa7134-oss");
 	return NOTIFY_DONE;
 }
 
@@ -218,10 +215,11 @@ static struct notifier_block pending_not
 
 static void request_module_depend(char *name, int *flag)
 {
+	int err;
 	switch (THIS_MODULE->state) {
 	case MODULE_STATE_COMING:
 		if (!pending_registered) {
-			register_module_notifier(&pending_notifier);
+			err = register_module_notifier(&pending_notifier);
 			pending_registered = 1;
 		}
 		*flag = 1;
@@ -578,12 +576,14 @@ static irqreturn_t saa7134_irq(int irq, 
 			goto out;
 		}
 
-		/* If alsa support is active and we get a sound report, exit
-		   and let the saa7134-alsa module deal with it */
+		/* If dmasound support is active and we get a sound report, exit
+		   and let the saa7134-alsa/oss module deal with it */
 
-		if ((report & SAA7134_IRQ_REPORT_DONE_RA3) && alsa)  {
+		if ((report & SAA7134_IRQ_REPORT_DONE_RA3) &&
+			(dev->dmasound.priv_data != NULL) )
+		{
 			if (irq_debug > 1)
-				printk(KERN_DEBUG "%s/irq: ignoring interrupt for ALSA\n",
+				printk(KERN_DEBUG "%s/irq: ignoring interrupt for DMA sound\n",
 				       dev->name);
 			goto out;
 		}
@@ -609,12 +609,6 @@ static irqreturn_t saa7134_irq(int irq, 
 		    card_has_mpeg(dev))
 			saa7134_irq_ts_done(dev,status);
 
-		if ((report & SAA7134_IRQ_REPORT_DONE_RA3))  {
-			if (oss) {
-				saa7134_irq_oss_done(dev,status);
-			}
-		}
-
 		if ((report & (SAA7134_IRQ_REPORT_GPIO16 |
 			       SAA7134_IRQ_REPORT_GPIO18)) &&
 		    dev->remote)
@@ -689,14 +683,6 @@ static int saa7134_hwinit1(struct saa713
 	 * audio will not work.
 	 */
 
-	switch (dev->pci->device) {
-	case PCI_DEVICE_ID_PHILIPS_SAA7134:
-	case PCI_DEVICE_ID_PHILIPS_SAA7133:
-	case PCI_DEVICE_ID_PHILIPS_SAA7135:
-		saa7134_oss_init1(dev);
-		break;
-	}
-
 	/* enable peripheral devices */
 	saa_writeb(SAA7134_SPECIAL_MODE, 0x01);
 
@@ -740,13 +726,6 @@ static int saa7134_hwfini(struct saa7134
 {
 	dprintk("hwfini\n");
 
-	switch (dev->pci->device) {
-	case PCI_DEVICE_ID_PHILIPS_SAA7134:
-	case PCI_DEVICE_ID_PHILIPS_SAA7133:
-	case PCI_DEVICE_ID_PHILIPS_SAA7135:
-		saa7134_oss_fini(dev);
-		break;
-	}
 	if (card_has_mpeg(dev))
 		saa7134_ts_fini(dev);
 	saa7134_input_fini(dev);
@@ -984,11 +963,12 @@ static int __devinit saa7134_initdev(str
 	if (card_is_dvb(dev))
 		request_module_depend("saa7134-dvb",&need_dvb);
 
-	if (!oss && alsa) {
-		dprintk("Requesting ALSA module\n");
+
+	if (alsa)
 		request_module_depend("saa7134-alsa",&need_alsa);
-	}
 
+	if (oss)
+		request_module_depend("saa7134-oss",&need_oss);
 
 	v4l2_prio_init(&dev->prio);
 
@@ -1022,32 +1002,6 @@ static int __devinit saa7134_initdev(str
 		       dev->name,dev->radio_dev->minor & 0x1f);
 	}
 
-	/* register oss devices */
-	switch (dev->pci->device) {
-	case PCI_DEVICE_ID_PHILIPS_SAA7134:
-	case PCI_DEVICE_ID_PHILIPS_SAA7133:
-	case PCI_DEVICE_ID_PHILIPS_SAA7135:
-		if (oss) {
-			err = dev->dmasound.minor_dsp =
-				register_sound_dsp(&saa7134_dsp_fops,
-						   dsp_nr[dev->nr]);
-			if (err < 0) {
-				goto fail4;
-			}
-			printk(KERN_INFO "%s: registered device dsp%d\n",
-			       dev->name,dev->dmasound.minor_dsp >> 4);
-
-			err = dev->dmasound.minor_mixer =
-				register_sound_mixer(&saa7134_mixer_fops,
-						     mixer_nr[dev->nr]);
-			if (err < 0)
-				goto fail5;
-			printk(KERN_INFO "%s: registered device mixer%d\n",
-			       dev->name,dev->dmasound.minor_mixer >> 4);
-		}
-		break;
-	}
-
 	/* everything worked */
 	pci_set_drvdata(pci_dev,dev);
 	saa7134_devcount++;
@@ -1065,15 +1019,6 @@ static int __devinit saa7134_initdev(str
 
 	return 0;
 
- fail5:
-	switch (dev->pci->device) {
-	case PCI_DEVICE_ID_PHILIPS_SAA7134:
-	case PCI_DEVICE_ID_PHILIPS_SAA7133:
-	case PCI_DEVICE_ID_PHILIPS_SAA7135:
-		if (oss)
-			unregister_sound_dsp(dev->dmasound.minor_dsp);
-		break;
-	}
  fail4:
 	saa7134_unregister_video(dev);
 	saa7134_i2c_unregister(dev);
@@ -1124,19 +1069,16 @@ static void __devexit saa7134_finidev(st
 	saa7134_devcount--;
 
 	saa7134_i2c_unregister(dev);
-	switch (dev->pci->device) {
-	case PCI_DEVICE_ID_PHILIPS_SAA7134:
-	case PCI_DEVICE_ID_PHILIPS_SAA7133:
-	case PCI_DEVICE_ID_PHILIPS_SAA7135:
-		if (oss) {
-			unregister_sound_mixer(dev->dmasound.minor_mixer);
-			unregister_sound_dsp(dev->dmasound.minor_dsp);
-		}
-		break;
-	}
 	saa7134_unregister_video(dev);
 
-	/* release ressources */
+	/* the DMA sound modules should be unloaded before reaching
+	   this, but just in case they are still present... */
+	if (dev->dmasound.priv_data != NULL) {
+		free_irq(pci_dev->irq, &dev->dmasound);
+		dev->dmasound.priv_data = NULL;
+	}
+
+	/* release resources */
 	free_irq(pci_dev->irq, dev);
 	iounmap(dev->lmmio);
 	release_mem_region(pci_resource_start(pci_dev,0),
@@ -1224,7 +1166,7 @@ EXPORT_SYMBOL(saa7134_i2c_call_clients);
 EXPORT_SYMBOL(saa7134_devlist);
 EXPORT_SYMBOL(saa7134_boards);
 
-/* ----------------- For ALSA -------------------------------- */
+/* ----------------- for the DMA sound modules --------------- */
 
 EXPORT_SYMBOL(saa7134_pgtable_free);
 EXPORT_SYMBOL(saa7134_pgtable_build);
--- git13.orig/drivers/media/video/saa7134/saa7134.h
+++ git13/drivers/media/video/saa7134/saa7134.h
@@ -383,6 +383,7 @@ struct saa7134_dmasound {
 	unsigned int               dma_blk;
 	unsigned int               read_offset;
 	unsigned int               read_count;
+	void *			   priv_data;
 	snd_pcm_substream_t 	   *substream;
 };
 
--- git13.orig/drivers/media/video/saa7134/saa7134-oss.c
+++ git13/drivers/media/video/saa7134/saa7134-oss.c
@@ -4,6 +4,8 @@
  * oss dsp interface
  *
  * (c) 2001,02 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
+ *     2005 conversion to standalone module:
+ *         Ricardo Cerqueira <v4l@cerqueira.org>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -25,7 +27,9 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/sound.h>
 #include <linux/soundcard.h>
 
 #include "saa7134-reg.h"
@@ -33,15 +37,23 @@
 
 /* ------------------------------------------------------------------ */
 
-static unsigned int oss_debug  = 0;
-module_param(oss_debug, int, 0644);
-MODULE_PARM_DESC(oss_debug,"enable debug messages [oss]");
-
-static unsigned int oss_rate  = 0;
-module_param(oss_rate, int, 0444);
-MODULE_PARM_DESC(oss_rate,"sample rate (valid are: 32000,48000)");
+static unsigned int debug  = 0;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug,"enable debug messages [oss]");
+
+static unsigned int rate  = 0;
+module_param(rate, int, 0444);
+MODULE_PARM_DESC(rate,"sample rate (valid are: 32000,48000)");
+
+static unsigned int dsp_nr[]   = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+MODULE_PARM_DESC(dsp_nr, "device numbers for SAA7134 capture interface(s).");
+module_param_array(dsp_nr,   int, NULL, 0444);
+
+static unsigned int mixer_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+MODULE_PARM_DESC(mixer_nr, "mixer numbers for SAA7134 capture interface(s).");
+module_param_array(mixer_nr, int, NULL, 0444);
 
-#define dprintk(fmt, arg...)	if (oss_debug) \
+#define dprintk(fmt, arg...)	if (debug) \
 	printk(KERN_DEBUG "%s/oss: " fmt, dev->name , ## arg)
 
 
@@ -369,7 +381,7 @@ static int dsp_ioctl(struct inode *inode
 	int __user *p = argp;
 	int val = 0;
 
-	if (oss_debug > 1)
+	if (debug > 1)
 		saa7134_print_ioctl(dev->name,cmd);
 	switch (cmd) {
 	case OSS_GETVERSION:
@@ -665,7 +677,7 @@ static int mixer_ioctl(struct inode *ino
 	void __user *argp = (void __user *) arg;
 	int __user *p = argp;
 
-	if (oss_debug > 1)
+	if (debug > 1)
 		saa7134_print_ioctl(dev->name,cmd);
 	switch (cmd) {
 	case OSS_GETVERSION:
@@ -768,8 +780,41 @@ struct file_operations saa7134_mixer_fop
 
 /* ------------------------------------------------------------------ */
 
+static irqreturn_t saa7134_oss_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+        struct saa7134_dmasound *dmasound = dev_id;
+        struct saa7134_dev *dev = dmasound->priv_data;
+        unsigned long report, status;
+        int loop, handled = 0;
+
+        for (loop = 0; loop < 10; loop++) {
+                report = saa_readl(SAA7134_IRQ_REPORT);
+                status = saa_readl(SAA7134_IRQ_STATUS);
+
+                if (report & SAA7134_IRQ_REPORT_DONE_RA3) {
+                        handled = 1;
+                        saa_writel(SAA7134_IRQ_REPORT,report);
+                        saa7134_irq_oss_done(dev, status);
+                } else {
+                        goto out;
+                }
+        }
+
+        if (loop == 10) {
+                dprintk("error! looping IRQ!");
+        }
+out:
+        return IRQ_RETVAL(handled);
+}
+
 int saa7134_oss_init1(struct saa7134_dev *dev)
 {
+
+        if ((request_irq(dev->pci->irq, saa7134_oss_irq,
+                         SA_SHIRQ | SA_INTERRUPT, dev->name,
+			(void*) &dev->dmasound)) < 0)
+		return -1;
+
 	/* general */
 	init_MUTEX(&dev->dmasound.lock);
 	init_waitqueue_head(&dev->dmasound.wq);
@@ -785,8 +830,8 @@ int saa7134_oss_init1(struct saa7134_dev
 
 	/* dsp */
 	dev->dmasound.rate = 32000;
-	if (oss_rate)
-		dev->dmasound.rate = oss_rate;
+	if (rate)
+		dev->dmasound.rate = rate;
 	dev->dmasound.rate = (dev->dmasound.rate > 40000) ? 48000 : 32000;
 
 	/* mixer */
@@ -840,7 +885,7 @@ void saa7134_irq_oss_done(struct saa7134
 	/* next block addr */
 	next_blk = (dev->dmasound.dma_blk + 2) % dev->dmasound.blocks;
 	saa_writel(reg,next_blk * dev->dmasound.blksize);
-	if (oss_debug > 2)
+	if (debug > 2)
 		dprintk("irq: ok, %s, next_blk=%d, addr=%x\n",
 			(status & 0x10000000) ? "even" : "odd ", next_blk,
 			next_blk * dev->dmasound.blksize);
@@ -854,6 +899,98 @@ void saa7134_irq_oss_done(struct saa7134
 	spin_unlock(&dev->slock);
 }
 
+int saa7134_dsp_create(struct saa7134_dev *dev)
+{
+	int err;
+
+                        err = dev->dmasound.minor_dsp =
+                                register_sound_dsp(&saa7134_dsp_fops,
+                                                   dsp_nr[dev->nr]);
+                        if (err < 0) {
+                                goto fail;
+                        }
+                        printk(KERN_INFO "%s: registered device dsp%d\n",
+                               dev->name,dev->dmasound.minor_dsp >> 4);
+
+                        err = dev->dmasound.minor_mixer =
+                                register_sound_mixer(&saa7134_mixer_fops,
+                                                     mixer_nr[dev->nr]);
+                        if (err < 0)
+                                goto fail;
+                        printk(KERN_INFO "%s: registered device mixer%d\n",
+                               dev->name,dev->dmasound.minor_mixer >> 4);
+
+	return 0;
+
+fail:
+        unregister_sound_dsp(dev->dmasound.minor_dsp);
+	return 0;
+
+
+}
+
+static int saa7134_oss_init(void)
+{
+        struct saa7134_dev *dev = NULL;
+        struct list_head *list;
+
+        printk(KERN_INFO "saa7134 OSS driver for DMA sound loaded\n");
+
+        list_for_each(list,&saa7134_devlist) {
+                dev = list_entry(list, struct saa7134_dev, devlist);
+		if (dev->dmasound.priv_data == NULL) {
+			dev->dmasound.priv_data = dev;
+			saa7134_oss_init1(dev);
+			saa7134_dsp_create(dev);
+		} else {
+                	printk(KERN_ERR "saa7134 OSS: DMA sound is being handled by ALSA, ignoring %s\n",dev->name);
+			return -EBUSY;
+		}
+        }
+
+        if (dev == NULL)
+                printk(KERN_INFO "saa7134 OSS: no saa7134 cards found\n");
+
+        return 0;
+
+}
+
+void saa7134_oss_exit(void)
+{
+        struct saa7134_dev *dev = NULL;
+        struct list_head *list;
+
+        list_for_each(list,&saa7134_devlist) {
+                dev = list_entry(list, struct saa7134_dev, devlist);
+
+		/* Device isn't registered by OSS, probably ALSA's */
+		if (!dev->dmasound.minor_dsp)
+			continue;
+
+                unregister_sound_mixer(dev->dmasound.minor_mixer);
+                unregister_sound_dsp(dev->dmasound.minor_dsp);
+
+		saa7134_oss_fini(dev);
+
+		if (dev->pci->irq > 0) {
+			synchronize_irq(dev->pci->irq);
+			free_irq(dev->pci->irq,&dev->dmasound);
+		}
+
+        	dev->dmasound.priv_data = NULL;
+
+        }
+
+        printk(KERN_INFO "saa7134 OSS driver for DMA sound unloaded\n");
+
+        return;
+}
+
+module_init(saa7134_oss_init);
+module_exit(saa7134_oss_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
+
 /* ----------------------------------------------------------- */
 /*
  * Local variables:


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
