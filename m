From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [PATCH] Modem support for ALI5451
Date: Mon, 30 May 2005 01:14:19 +0300
Message-ID: <20050529221419.GD24435@tecr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz, tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

This patch adds modem support for ali5451. Since it is same pci device
all is done in ali5451.c.

Thanks,
Sasha.


Modem support for ali5451.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-kernel/pci/ali5451/ali5451.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ali5451/ali5451.c,v
retrieving revision 1.63
diff -u -b -B -r1.63 ali5451.c
--- alsa-kernel/pci/ali5451/ali5451.c	11 Apr 2005 15:58:27 -0000	1.63
+++ alsa-kernel/pci/ali5451/ali5451.c	28 May 2005 22:45:23 -0000
@@ -98,6 +98,8 @@
 #define ALI_LEF_CHANNEL		23
 #define ALI_SURR_LEFT_CHANNEL	26
 #define ALI_SURR_RIGHT_CHANNEL	25
+#define ALI_MODEM_IN_CHANNEL    21
+#define ALI_MODEM_OUT_CHANNEL   20
 
 #define	SNDRV_ALI_VOICE_TYPE_PCM	01
 #define SNDRV_ALI_VOICE_TYPE_OTH	02
@@ -122,7 +124,15 @@
 
 #define ALI_SCTRL		0x48
 #define   ALI_SPDIF_OUT_ENABLE		0x20
+#define   ALI_SCTRL_LINE_IN2		(1 << 9)
+#define   ALI_SCTRL_GPIO_IN2		(1 << 13)
+#define   ALI_SCTRL_LINE_OUT_EN 	(1 << 20)
+#define   ALI_SCTRL_GPIO_OUT_EN 	(1 << 23)
+#define   ALI_SCTRL_CODEC1_READY	(1 << 24)
+#define   ALI_SCTRL_CODEC2_READY	(1 << 25)
 #define ALI_AC97_GPIO		0x4c
+#define   ALI_AC97_GPIO_ENABLE		0x8000
+#define   ALI_AC97_GPIO_DATA_SHIFT	16
 #define ALI_SPDIF_CS		0x70
 #define ALI_SPDIF_CTRL		0x74
 #define   ALI_SPDIF_IN_FUNC_ENABLE	0x02
@@ -143,6 +153,7 @@
 	#define TARGET_REACHED		0x00008000
 	#define MIXER_OVERFLOW		0x00000800
 	#define MIXER_UNDERFLOW		0x00000400
+	#define GPIO_IRQ		0x01000000
 #define ALI_SBBL_SBCL           0xc0
 #define ALI_SBCTRL_SBE2R_SBDD   0xc4
 #define ALI_STIMER		0xc8
@@ -162,6 +173,9 @@
 
 #define ALI_REG(codec, x) ((codec)->port + x)
 
+#define MAX_CODECS 2
+
+
 typedef struct snd_stru_ali ali_t;
 typedef struct snd_ali_stru_voice snd_ali_voice_t;
 
@@ -245,7 +259,7 @@
 	struct pci_dev	*pci_m7101;
 
 	snd_card_t	*card;
-	snd_pcm_t	*pcm;
+	snd_pcm_t	*pcm[MAX_CODECS];
 	alidev_t	synth;
 	snd_ali_channel_control_t chregs;
 
@@ -255,8 +269,10 @@
 	unsigned int spurious_irq_count;
 	unsigned int spurious_irq_max_delta;
 
+	unsigned int num_of_codecs;
+
 	ac97_bus_t *ac97_bus;
-	ac97_t *ac97;
+	ac97_t *ac97[MAX_CODECS];
 	unsigned short	ac97_ext_id;
 	unsigned short	ac97_ext_status;
 
@@ -489,7 +506,12 @@
 	ali_t *codec = ac97->private_data;
 
 	snd_ali_printk("codec_write: reg=%xh data=%xh.\n", reg, val);
-	snd_ali_codec_poke(codec, 0, reg, val);
+	if(reg == AC97_GPIO_STATUS) {
+		outl((val << ALI_AC97_GPIO_DATA_SHIFT)|ALI_AC97_GPIO_ENABLE,
+			ALI_REG(codec, ALI_AC97_GPIO));
+		return;
+	}
+	snd_ali_codec_poke(codec, ac97->num, reg, val);
 	return ;
 }
 
@@ -499,7 +521,7 @@
 	ali_t *codec = ac97->private_data;
 
 	snd_ali_printk("codec_read reg=%xh.\n", reg);
-	return (snd_ali_codec_peek(codec, 0, reg));
+	return (snd_ali_codec_peek(codec, ac97->num, reg));
 }
 
 /*
@@ -1051,7 +1073,7 @@
 }
 
 
-static snd_ali_voice_t *snd_ali_alloc_voice(ali_t * codec, int type, int rec)
+static snd_ali_voice_t *snd_ali_alloc_voice(ali_t * codec, int type, int rec, int channel)
 {
 	snd_ali_voice_t *pvoice = NULL;
 	unsigned long flags;
@@ -1061,7 +1083,8 @@
 
 	spin_lock_irqsave(&codec->voice_alloc, flags);
 	if (type == SNDRV_ALI_VOICE_TYPE_PCM) {
-		idx = snd_ali_find_free_channel(codec,rec);
+		idx = channel > 0 ? snd_ali_alloc_pcm_channel(codec, channel) :
+			snd_ali_find_free_channel(codec,rec);
 		if(idx < 0) {
 			snd_printk("ali_alloc_voice: err.\n");
 			spin_unlock_irqrestore(&codec->voice_alloc, flags);
@@ -1297,7 +1320,7 @@
 
 	if (params_buffer_size(hw_params)/2 != params_period_size(hw_params)) {
 		if (evoice == NULL) {
-			evoice = snd_ali_alloc_voice(codec, SNDRV_ALI_VOICE_TYPE_PCM, 0);
+			evoice = snd_ali_alloc_voice(codec, SNDRV_ALI_VOICE_TYPE_PCM, 0, -1);
 			if (evoice == NULL)
 				return -ENOMEM;
 			pvoice->extra = evoice;
@@ -1328,13 +1351,13 @@
 	return 0;
 }
 
-static int snd_ali_capture_hw_params(snd_pcm_substream_t * substream,
+static int snd_ali_hw_params(snd_pcm_substream_t * substream,
 				 snd_pcm_hw_params_t * hw_params)
 {
 	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
 }
 
-static int snd_ali_capture_hw_free(snd_pcm_substream_t * substream)
+static int snd_ali_hw_free(snd_pcm_substream_t * substream)
 {
 	return snd_pcm_lib_free_pages(substream);
 }
@@ -1428,7 +1451,7 @@
 }
 
 
-static int snd_ali_capture_prepare(snd_pcm_substream_t * substream)
+static int snd_ali_prepare(snd_pcm_substream_t * substream)
 {
 	ali_t *codec = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
@@ -1446,11 +1469,13 @@
 
 	spin_lock_irqsave(&codec->reg_lock, flags);
 
-	snd_ali_printk("capture_prepare...\n");
+	snd_ali_printk("ali_prepare...\n");
 
 	snd_ali_enable_special_channel(codec,pvoice->number);
 
-	Delta = snd_ali_convert_rate(runtime->rate, 1);
+	Delta = (pvoice->number == ALI_MODEM_IN_CHANNEL ||
+		 pvoice->number == ALI_MODEM_OUT_CHANNEL) ? 
+		0x1000 : snd_ali_convert_rate(runtime->rate, pvoice->mode);
 
 	// Prepare capture intr channel
 	if (pvoice->number == ALI_SPDIF_IN_CHANNEL) {
@@ -1534,7 +1559,7 @@
 }
 
 
-static snd_pcm_uframes_t snd_ali_capture_pointer(snd_pcm_substream_t *substream)
+static snd_pcm_uframes_t snd_ali_pointer(snd_pcm_substream_t *substream)
 {
 	ali_t *codec = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
@@ -1616,7 +1641,8 @@
 	}
 }
 
-static int snd_ali_playback_open(snd_pcm_substream_t * substream)
+static int snd_ali_open(snd_pcm_substream_t * substream, int rec, int channel,
+		snd_pcm_hardware_t *phw)
 {
 	ali_t *codec = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
@@ -1624,7 +1650,7 @@
 	unsigned long flags = 0;
 
 	spin_lock_irqsave(&codec->reg_lock, flags);
-	pvoice = snd_ali_alloc_voice(codec, SNDRV_ALI_VOICE_TYPE_PCM, 0);
+	pvoice = snd_ali_alloc_voice(codec, SNDRV_ALI_VOICE_TYPE_PCM, rec, channel);
 	if (pvoice == NULL) {
 		spin_unlock_irqrestore(&codec->reg_lock, flags);
 		return -EAGAIN;
@@ -1636,39 +1662,22 @@
 	runtime->private_data = pvoice;
 	runtime->private_free = snd_ali_pcm_free_substream;
 
-	runtime->hw = snd_ali_playback;
+	runtime->hw = *phw;
 	snd_pcm_set_sync(substream);
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 0, 64*1024);
 	return 0;
 }
 
+static int snd_ali_playback_open(snd_pcm_substream_t * substream)
+{
+	return snd_ali_open(substream, 0, -1, &snd_ali_playback);
+}
 
 static int snd_ali_capture_open(snd_pcm_substream_t * substream)
 {
-	ali_t *codec = snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	snd_ali_voice_t *pvoice;
-	unsigned long flags;
-
-	spin_lock_irqsave(&codec->reg_lock, flags);
-	pvoice = snd_ali_alloc_voice(codec, SNDRV_ALI_VOICE_TYPE_PCM, 1);
-	if (pvoice == NULL) {
-		spin_unlock_irqrestore(&codec->reg_lock, flags);
-		return -EAGAIN;
-	}
-	pvoice->codec = codec;
-	spin_unlock_irqrestore(&codec->reg_lock, flags);
-
-	pvoice->substream = substream;
-	runtime->private_data = pvoice;
-	runtime->private_free = snd_ali_pcm_free_substream;
-	runtime->hw = snd_ali_capture;
-	snd_pcm_set_sync(substream);
-	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 0, 64*1024);
-	return 0;
+	return snd_ali_open(substream, 1, -1, &snd_ali_capture);
 }
 
-
 static int snd_ali_playback_close(snd_pcm_substream_t * substream)
 {
 	return 0;
@@ -1674,11 +1683,10 @@
 	return 0;
 }
 
-static int snd_ali_capture_close(snd_pcm_substream_t * substream)
+static int snd_ali_close(snd_pcm_substream_t * substream)
 {
 	ali_t *codec = snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	snd_ali_voice_t *pvoice = (snd_ali_voice_t *) runtime->private_data;
+	snd_ali_voice_t *pvoice = (snd_ali_voice_t *) substream->runtime->private_data;
 
 	snd_ali_disable_special_channel(codec,pvoice->number);
 
@@ -1698,29 +1706,121 @@
 
 static snd_pcm_ops_t snd_ali_capture_ops = {
 	.open =		snd_ali_capture_open,
-	.close =	snd_ali_capture_close,
+	.close =	snd_ali_close,
 	.ioctl =	snd_ali_ioctl,
-	.hw_params =	snd_ali_capture_hw_params,
-	.hw_free =	snd_ali_capture_hw_free,
-	.prepare =	snd_ali_capture_prepare,
+	.hw_params =	snd_ali_hw_params,
+	.hw_free =	snd_ali_hw_free,
+	.prepare =	snd_ali_prepare,
 	.trigger =	snd_ali_trigger,
-	.pointer =	snd_ali_capture_pointer,
+	.pointer =	snd_ali_pointer,
+};
+
+/*
+ * Modem PCM
+ */
+
+static int snd_ali_modem_hw_params(snd_pcm_substream_t * substream,
+				 snd_pcm_hw_params_t * hw_params)
+{
+	ali_t *chip = snd_pcm_substream_chip(substream);
+	unsigned int modem_num = chip->num_of_codecs - 1;
+	snd_ac97_write(chip->ac97[modem_num], AC97_LINE1_RATE, params_rate(hw_params));
+	snd_ac97_write(chip->ac97[modem_num], AC97_LINE1_LEVEL, 0);
+	return snd_ali_hw_params(substream, hw_params);
+}
+
+static snd_pcm_hardware_t snd_ali_modem =
+{
+	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
+				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				 SNDRV_PCM_INFO_MMAP_VALID |
+				 SNDRV_PCM_INFO_RESUME |
+				 SNDRV_PCM_INFO_SYNC_START),
+	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_KNOT|SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000,
+	.rate_min =		8000,
+	.rate_max =		16000,
+	.channels_min =		1,
+	.channels_max =		1,
+	.buffer_bytes_max =	(256*1024),
+	.period_bytes_min =	64,
+	.period_bytes_max =	(256*1024),
+	.periods_min =		1,
+	.periods_max =		1024,
+	.fifo_size =		0,
+};
+
+static int snd_ali_modem_open(snd_pcm_substream_t * substream, int rec, int channel)
+{
+	static unsigned int rates [] = {8000,9600,12000,16000};
+	static snd_pcm_hw_constraint_list_t hw_constraint_rates = {
+		.count = ARRAY_SIZE(rates),
+		.list = rates,
+		.mask = 0,
+	};
+	int err = snd_ali_open(substream, rec, channel, &snd_ali_modem);
+	if (err)
+		return err;
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &hw_constraint_rates);
+}
+
+static int snd_ali_modem_playback_open(snd_pcm_substream_t * substream)
+{
+	return snd_ali_modem_open(substream, 0, ALI_MODEM_OUT_CHANNEL);
+}
+
+static int snd_ali_modem_capture_open(snd_pcm_substream_t * substream)
+{
+	return snd_ali_modem_open(substream, 1, ALI_MODEM_IN_CHANNEL);
+}
+
+static snd_pcm_ops_t snd_ali_modem_playback_ops = {
+	.open =		snd_ali_modem_playback_open,
+	.close =	snd_ali_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_ali_modem_hw_params,
+	.hw_free =	snd_ali_hw_free,
+	.prepare =	snd_ali_prepare,
+	.trigger =	snd_ali_trigger,
+	.pointer =	snd_ali_pointer,
+};
+
+static snd_pcm_ops_t snd_ali_modem_capture_ops = {
+	.open =		snd_ali_modem_capture_open,
+	.close =	snd_ali_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_ali_modem_hw_params,
+	.hw_free =	snd_ali_hw_free,
+	.prepare =	snd_ali_prepare,
+	.trigger =	snd_ali_trigger,
+	.pointer =	snd_ali_pointer,
+};
+
+
+struct ali_pcm_description {
+	char *name;
+	unsigned int playback_num;
+	unsigned int capture_num;
+	snd_pcm_ops_t *playback_ops;
+	snd_pcm_ops_t *capture_ops;
 };
 
 
 static void snd_ali_pcm_free(snd_pcm_t *pcm)
 {
 	ali_t *codec = pcm->private_data;
-	codec->pcm = NULL;
+	codec->pcm[pcm->device] = NULL;
 }
 
-static int __devinit snd_ali_pcm(ali_t * codec, int device, snd_pcm_t ** rpcm)
+
+static int __devinit snd_ali_pcm(ali_t * codec, int device, struct ali_pcm_description *desc)
 {
 	snd_pcm_t *pcm;
 	int err;
 
-	if (rpcm) *rpcm = NULL;
-	err = snd_pcm_new(codec->card, "ALI 5451", device, ALI_CHANNELS, 1, &pcm);
+	err = snd_pcm_new(codec->card, desc->name, device,
+			  desc->playback_num, desc->capture_num, &pcm);
 	if (err < 0) {
 		snd_printk("snd_ali_pcm: err called snd_pcm_new.\n");
 		return err;
@@ -1728,20 +1828,36 @@
 	pcm->private_data = codec;
 	pcm->private_free = snd_ali_pcm_free;
 	pcm->info_flags = 0;
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_ali_playback_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ali_capture_ops);
+	if (desc->playback_ops)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, desc->playback_ops);
+	if (desc->capture_ops)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, desc->capture_ops);
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(codec->pci), 64*1024, 128*1024);
 
 	pcm->info_flags = 0;
 	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
-	strcpy(pcm->name, "ALI 5451");
-	codec->pcm = pcm;
-	if (rpcm) *rpcm = pcm;
+	strcpy(pcm->name, desc->name);
+	codec->pcm[0] = pcm;
 	return 0;
 }
 
+struct ali_pcm_description ali_pcms[] = {
+	{ "ALI 5451", ALI_CHANNELS, 1, &snd_ali_playback_ops, &snd_ali_capture_ops },
+	{ "ALI 5451 modem", 1, 1, &snd_ali_modem_playback_ops, &snd_ali_modem_capture_ops }
+};
+
+static int __devinit snd_ali_build_pcms(ali_t *codec)
+{
+	int i, err;
+	for(i = 0 ; i < codec->num_of_codecs && i < ARRAY_SIZE(ali_pcms) ; i++)
+		if((err = snd_ali_pcm(codec, i, &ali_pcms[i])) < 0)
+			return err;
+	return 0;
+}
+
+
 #define ALI5451_SPDIF(xname, xindex, value) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex,\
 .info = snd_ali5451_spdif_info, .get = snd_ali5451_spdif_get, \
@@ -1860,14 +1976,14 @@
 static void snd_ali_mixer_free_ac97(ac97_t *ac97)
 {
 	ali_t *codec = ac97->private_data;
-	codec->ac97 = NULL;
+	codec->ac97[ac97->num] = NULL;
 }
 
 static int __devinit snd_ali_mixer(ali_t * codec)
 {
 	ac97_template_t ac97;
 	unsigned int idx;
-	int err;
+	int i, err;
 	static ac97_bus_ops_t ops = {
 		.write = snd_ali_codec_write,
 		.read = snd_ali_codec_read,
@@ -1880,10 +1996,16 @@
 	memset(&ac97, 0, sizeof(ac97));
 	ac97.private_data = codec;
 	ac97.private_free = snd_ali_mixer_free_ac97;
-	if ((err = snd_ac97_mixer(codec->ac97_bus, &ac97, &codec->ac97)) < 0) {
-		snd_printk("ali mixer creating error.\n");
+
+	for ( i = 0 ; i < codec->num_of_codecs ; i++) {
+		ac97.num = i;
+		if ((err = snd_ac97_mixer(codec->ac97_bus, &ac97, &codec->ac97[i])) < 0) {
+			snd_printk("ali mixer %d creating error.\n", i);
+			if(i == 0)
 		return err;
 	}
+	}
+
 	if (codec->spdif_support) {
 		for(idx = 0; idx < ARRAY_SIZE(snd_ali5451_mixer_spdif); idx++) {
 			err=snd_ctl_add(codec->card, snd_ctl_new1(&snd_ali5451_mixer_spdif[idx], codec));
@@ -1904,8 +2026,12 @@
 	if (! im)
 		return 0;
 
-	snd_pcm_suspend_all(chip->pcm);
-	snd_ac97_suspend(chip->ac97);
+	for(i = 0 ; i < chip->num_of_codecs ; i++) {
+		if (chip->pcm[i])
+			snd_pcm_suspend_all(chip->pcm[i]);
+		if(chip->ac97[i])
+			snd_ac97_suspend(chip->ac97[i]);
+	}
 
 	spin_lock_irq(&chip->reg_lock);
 	
@@ -1969,7 +2095,9 @@
 	
 	spin_unlock_irq(&chip->reg_lock);
 
-	snd_ac97_resume(chip->ac97);
+	for(i = 0 ; i < chip->num_of_codecs ; i++)
+		if(chip->ac97[i])
+			snd_ac97_resume(chip->ac97[i]);
 	
 	return 0;
 }
@@ -2036,11 +2164,37 @@
 		codec->spdif_mask = 0x00000002;
 	}
 
+	codec->num_of_codecs = 1;
+
+	/* secondary codec - modem */
+	if (inl(ALI_REG(codec, ALI_SCTRL)) & ALI_SCTRL_CODEC2_READY) {
+		codec->num_of_codecs++;
+		outl(inl(ALI_REG(codec, ALI_SCTRL)) |
+			(ALI_SCTRL_LINE_IN2|ALI_SCTRL_GPIO_IN2|ALI_SCTRL_LINE_OUT_EN),
+			ALI_REG(codec, ALI_SCTRL));
+	}
+
 	snd_ali_printk("chip initialize succeed.\n");
 	return 0;
 
 }
 
+/* proc for register dump */
+static void snd_ali_proc_read(snd_info_entry_t *entry, snd_info_buffer_t *buf)
+{
+	ali_t *codec = entry->private_data;
+	int i;
+	for(i = 0 ; i < 256 ; i+= 4)
+		snd_iprintf(buf, "%02x: %08x\n", i, inl(ALI_REG(codec, i)));
+}
+
+static void __devinit snd_ali_proc_init(ali_t *codec)
+{
+	snd_info_entry_t *entry;
+	if(!snd_card_proc_new(codec->card, "ali5451", &entry))
+		snd_info_set_text_ops(entry, codec, 1024, snd_ali_proc_read);
+}
+
 static int __devinit snd_ali_resources(ali_t *codec)
 {
 	int err;
@@ -2233,11 +2387,13 @@
 	}
 	
 	snd_ali_printk("pcm building ...\n");
-	if ((err = snd_ali_pcm(codec, 0, NULL)) < 0) {
+	if ((err = snd_ali_build_pcms(codec)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
+	snd_ali_proc_init(codec);
+
 	strcpy(card->driver, "ALI5451");
 	strcpy(card->shortname, "ALI 5451");
 	


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
