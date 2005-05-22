From: Sasha Khapyorsky <sashak@smlink.com>
Subject: ali5451.c: M5451 info needed
Date: Sun, 22 May 2005 03:19:53 +0300
Message-ID: <20050522001953.GG27978@tecr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8GpibOaaTibBMecb"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm trying now to add MC97 modem support for ALi M5451 (ali5451.c driver).
There is preliminary patch attached (not for inclusion yet: at least
big clean up is needed). I don't have device data sheets and patch was
based on existed audio code.

Basically it works in both directions playback and capture. But dma is
configured so that interrupt is generated at middle of buffer regardless to
period_size value. Same story with audio capture.

Anybody know how to config M5451 dma so that it will be able to work
with multiple blocks and generate interrupts at period_size (if possible)?
And/or may point me to data sheet or at least M5451 dma related info?

Sasha.

--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ali5451_modem.patch"

Index: alsa-kernel/pci/ali5451/ali5451.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ali5451/ali5451.c,v
retrieving revision 1.63
diff -u -b -B -r1.63 ali5451.c
--- alsa-kernel/pci/ali5451/ali5451.c	11 Apr 2005 15:58:27 -0000	1.63
+++ alsa-kernel/pci/ali5451/ali5451.c	18 May 2005 23:20:20 -0000
@@ -62,6 +62,8 @@
 module_param_array(spdif, bool, NULL, 0444);
 MODULE_PARM_DESC(spdif, "Support SPDIF I/O");
 
+#define CREATE_MODEM_PCM 1
+
 /*
  *  Debug part definitions
  */
@@ -98,6 +100,8 @@
 #define ALI_LEF_CHANNEL		23
 #define ALI_SURR_LEFT_CHANNEL	26
 #define ALI_SURR_RIGHT_CHANNEL	25
+#define ALI_MODEM_IN_CHANNEL    21
+#define ALI_MODEM_OUT_CHANNEL   20
 
 #define	SNDRV_ALI_VOICE_TYPE_PCM	01
 #define SNDRV_ALI_VOICE_TYPE_OTH	02
@@ -122,7 +126,15 @@
 
 #define ALI_SCTRL		0x48
 #define   ALI_SPDIF_OUT_ENABLE		0x20
+#define   ALI_SCTRL_LINE_IN2		(1 << 9)
+#define   ALI_SCTRL_GPIO_IN2		(1 << 13)
+#define   ALI_SCTRL_LINE_OUT_EN		(1 << 20)
+#define   ALI_SCTRL_GPIO_OUT_EN		(1 << 23)
+#define   ALI_SCTRL_CODEC1_READY	(1 << 24)
+#define   ALI_SCTRL_CODEC2_READY	(1 << 25)
 #define ALI_AC97_GPIO		0x4c
+#define   ALI_AC97_GPIO_ENABLE		0x8000
+#define   ALI_AC97_GPIO_DATA_SHIFT	16
 #define ALI_SPDIF_CS		0x70
 #define ALI_SPDIF_CTRL		0x74
 #define   ALI_SPDIF_IN_FUNC_ENABLE	0x02
@@ -143,6 +155,7 @@
 	#define TARGET_REACHED		0x00008000
 	#define MIXER_OVERFLOW		0x00000800
 	#define MIXER_UNDERFLOW		0x00000400
+	#define GPIO_IRQ		0x01000000
 #define ALI_SBBL_SBCL           0xc0
 #define ALI_SBCTRL_SBE2R_SBDD   0xc4
 #define ALI_STIMER		0xc8
@@ -152,6 +165,8 @@
 #define   ALI_SPDIF_OUT_CH_ENABLE	0x00008000 /* bit 15 */
 #define   ALI_SPDIF_IN_CH_ENABLE	0x00080000 /* bit 19 */
 #define   ALI_PCM_IN_ENABLE		0x80000000 /* bit 31 */
+//#define   ALI_MODEM_OUT_ENABLE	0x00100000 /* bit 20 */
+//#define   ALI_MODEM_IN_ENABLE		0x00200000 /* bit 21 */
 
 #define ALI_CSO_ALPHA_FMS	0xe0
 #define ALI_LBA			0xe4
@@ -162,6 +177,9 @@
 
 #define ALI_REG(codec, x) ((codec)->port + x)
 
+#define MAX_CODECS 2
+
+
 typedef struct snd_stru_ali ali_t;
 typedef struct snd_ali_stru_voice snd_ali_voice_t;
 
@@ -245,7 +263,7 @@
 	struct pci_dev	*pci_m7101;
 
 	snd_card_t	*card;
-	snd_pcm_t	*pcm;
+	snd_pcm_t	*pcm[MAX_CODECS];
 	alidev_t	synth;
 	snd_ali_channel_control_t chregs;
 
@@ -255,8 +273,10 @@
 	unsigned int spurious_irq_count;
 	unsigned int spurious_irq_max_delta;
 
+	unsigned int num_of_codecs;
+
 	ac97_bus_t *ac97_bus;
-	ac97_t *ac97;
+	ac97_t *ac97[MAX_CODECS];
 	unsigned short	ac97_ext_id;
 	unsigned short	ac97_ext_status;
 
@@ -489,7 +509,7 @@
 	ali_t *codec = ac97->private_data;
 
 	snd_ali_printk("codec_write: reg=%xh data=%xh.\n", reg, val);
-	snd_ali_codec_poke(codec, 0, reg, val);
+	snd_ali_codec_poke(codec, ac97->num, reg, val);
 	return ;
 }
 
@@ -499,7 +519,7 @@
 	ali_t *codec = ac97->private_data;
 
 	snd_ali_printk("codec_read reg=%xh.\n", reg);
-	return (snd_ali_codec_peek(codec, 0, reg));
+	return (snd_ali_codec_peek(codec, ac97->num, reg));
 }
 
 /*
@@ -1051,7 +1071,7 @@
 }
 
 
-static snd_ali_voice_t *snd_ali_alloc_voice(ali_t * codec, int type, int rec)
+static snd_ali_voice_t *snd_ali_alloc_voice(ali_t * codec, int type, int rec, int channel)
 {
 	snd_ali_voice_t *pvoice = NULL;
 	unsigned long flags;
@@ -1061,7 +1081,8 @@
 
 	spin_lock_irqsave(&codec->voice_alloc, flags);
 	if (type == SNDRV_ALI_VOICE_TYPE_PCM) {
-		idx = snd_ali_find_free_channel(codec,rec);
+		idx = channel > 0 ? snd_ali_alloc_pcm_channel(codec, channel) :
+			snd_ali_find_free_channel(codec,rec);
 		if(idx < 0) {
 			snd_printk("ali_alloc_voice: err.\n");
 			spin_unlock_irqrestore(&codec->voice_alloc, flags);
@@ -1297,7 +1318,7 @@
 
 	if (params_buffer_size(hw_params)/2 != params_period_size(hw_params)) {
 		if (evoice == NULL) {
-			evoice = snd_ali_alloc_voice(codec, SNDRV_ALI_VOICE_TYPE_PCM, 0);
+			evoice = snd_ali_alloc_voice(codec, SNDRV_ALI_VOICE_TYPE_PCM, 0, -1);
 			if (evoice == NULL)
 				return -ENOMEM;
 			pvoice->extra = evoice;
@@ -1624,7 +1645,7 @@
 	unsigned long flags = 0;
 
 	spin_lock_irqsave(&codec->reg_lock, flags);
-	pvoice = snd_ali_alloc_voice(codec, SNDRV_ALI_VOICE_TYPE_PCM, 0);
+	pvoice = snd_ali_alloc_voice(codec, SNDRV_ALI_VOICE_TYPE_PCM, 0, -1);
 	if (pvoice == NULL) {
 		spin_unlock_irqrestore(&codec->reg_lock, flags);
 		return -EAGAIN;
@@ -1651,7 +1672,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&codec->reg_lock, flags);
-	pvoice = snd_ali_alloc_voice(codec, SNDRV_ALI_VOICE_TYPE_PCM, 1);
+	pvoice = snd_ali_alloc_voice(codec, SNDRV_ALI_VOICE_TYPE_PCM, 1, -1);
 	if (pvoice == NULL) {
 		spin_unlock_irqrestore(&codec->reg_lock, flags);
 		return -EAGAIN;
@@ -1707,13 +1728,283 @@
 	.pointer =	snd_ali_capture_pointer,
 };
 
+/*
+ * Modem PCM
+ */
+#ifdef CREATE_MODEM_PCM
+
+static snd_pcm_uframes_t snd_ali_modem_pointer(snd_pcm_substream_t *substream)
+{
+	ali_t *codec = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	snd_ali_voice_t *pvoice = (snd_ali_voice_t *) runtime->private_data;
+	unsigned int cso;
+	unsigned long flags;
+
+	spin_lock_irqsave(&codec->reg_lock, flags);
+	if (!pvoice->running) {
+		spin_unlock_irqrestore(&codec->reg_lock, flags);
+		return 0;
+	}
+	outb(pvoice->number, ALI_REG(codec, ALI_GC_CIR));
+	cso = inw(ALI_REG(codec, ALI_CSO_ALPHA_FMS + 2));
+	spin_unlock_irqrestore(&codec->reg_lock, flags);
+
+	return cso;
+}
+
+#define HOOK_OFF_VIA_GPIO 1
+static int snd_ali_modem_trigger(snd_pcm_substream_t *substream, int cmd)
+{
+	ali_t *chip = snd_pcm_substream_chip(substream);
+	/* FIXME: ac97 number is hardcoded */
+#ifdef HOOK_OFF_VIA_GPIO
+	if (cmd == SNDRV_PCM_TRIGGER_START || cmd == SNDRV_PCM_TRIGGER_STOP) {
+		unsigned long flags;
+		u32 val = snd_ac97_read(chip->ac97[1], AC97_GPIO_STATUS);
+		if (cmd == SNDRV_PCM_TRIGGER_START)
+			val |= AC97_GPIO_LINE1_OH;
+		else
+			val &= ~AC97_GPIO_LINE1_OH;
+		val <<= ALI_AC97_GPIO_DATA_SHIFT;
+		val |= ALI_AC97_GPIO_ENABLE;
+		spin_lock_irqsave(&chip->reg_lock, flags);
+		outl(val, ALI_REG(chip, ALI_AC97_GPIO));
+		spin_unlock_irqrestore(&chip->reg_lock, flags);
+	}
+#else
+	switch(cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		snd_ac97_update_bits(chip->ac97[1], AC97_GPIO_STATUS,
+				     AC97_GPIO_LINE1_OH, AC97_GPIO_LINE1_OH);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		snd_ac97_update_bits(chip->ac97[1], AC97_GPIO_STATUS,
+				     AC97_GPIO_LINE1_OH, ~AC97_GPIO_LINE1_OH);
+		break;
+	}
+#endif
+	return snd_ali_trigger(substream, cmd);
+}
+
+static int snd_ali_modem_prepare(snd_pcm_substream_t * substream)
+{
+	ali_t *codec = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	snd_ali_voice_t *pvoice = (snd_ali_voice_t *) runtime->private_data;
+	unsigned long flags;
+	unsigned int LBA;
+	unsigned int Delta;
+	unsigned int ESO;
+	unsigned int CTRL;
+	unsigned int GVSEL;
+	unsigned int PAN;
+	unsigned int VOL;
+	unsigned int EC;
+
+	spin_lock_irqsave(&codec->reg_lock, flags);
+
+	snd_ali_printk("modem_prepare...\n");
+
+	snd_ali_enable_special_channel(codec,pvoice->number);
+
+	//Delta = snd_ali_convert_rate(runtime->rate, (pvoice->number == ALI_MODEM_IN_CHANNEL));
+	Delta = 0x1000;
+
+	// set target ESO for channel 
+	pvoice->eso = runtime->buffer_size; 
+
+	// set interrupt count size 
+	pvoice->count = runtime->period_size;
+
+	// set Loop Back Address 
+	LBA = runtime->dma_addr;
+
+	// set ESO to capture first MIDLP interrupt 
+	ESO = pvoice->eso - 1;
+	CTRL = snd_ali_control_mode(substream);
+	GVSEL = 0;
+	PAN = 0x00;
+	VOL = 0x00;
+	EC = 0;
+
+	snd_ali_write_voice_regs(    codec,
+				     pvoice->number,
+				     LBA,
+				     0,	/* cso */
+				     ESO,
+				     Delta,
+				     0,	/* alpha */
+				     GVSEL,
+				     PAN,
+				     VOL,
+				     CTRL,
+				     EC);
+
+
+	spin_unlock_irqrestore(&codec->reg_lock, flags);
+
+	return 0;
+}
+
+static int snd_ali_modem_hw_params(snd_pcm_substream_t * substream,
+				 snd_pcm_hw_params_t * hw_params)
+{
+	ali_t *codec = snd_pcm_substream_chip(substream);
+	unsigned int modem_num = 1; /* FIXME: reference ac97 */
+	snd_ac97_write(codec->ac97[modem_num], AC97_LINE1_RATE, params_rate(hw_params));
+	snd_ac97_write(codec->ac97[modem_num], AC97_LINE1_LEVEL, 0);
+	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+}
+
+static int snd_ali_modem_hw_free(snd_pcm_substream_t * substream)
+{
+
+	return snd_pcm_lib_free_pages(substream);
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
+static int snd_ali_modem_open(snd_pcm_substream_t * substream, int channel)
+{
+	static unsigned int rates [] = {8000,9600,12000,16000};
+	static snd_pcm_hw_constraint_list_t hw_constraint_rates = {
+		.count = ARRAY_SIZE(rates),
+		.list = rates,
+		.mask = 0,
+	};
+	ali_t *codec = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	snd_ali_voice_t *pvoice;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&codec->reg_lock, flags);
+	pvoice = snd_ali_alloc_voice(codec, SNDRV_ALI_VOICE_TYPE_PCM, channel == ALI_MODEM_IN_CHANNEL, channel);
+	if (pvoice == NULL) {
+		spin_unlock_irqrestore(&codec->reg_lock, flags);
+		return -EAGAIN;
+	}
+	pvoice->codec = codec;
+	spin_unlock_irqrestore(&codec->reg_lock, flags);
+
+	pvoice->substream = substream;
+	runtime->private_data = pvoice;
+	runtime->private_free = snd_ali_pcm_free_substream;
+
+	runtime->hw = snd_ali_modem;
+	return snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraint_rates);
+	
+	//snd_pcm_set_sync(substream);
+	//snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 0, 64*1024);
+	//return 0;
+}
+
+static int snd_ali_modem_playback_open(snd_pcm_substream_t * substream)
+{
+	return snd_ali_modem_open(substream, ALI_MODEM_OUT_CHANNEL);
+}
+
+static int snd_ali_modem_capture_open(snd_pcm_substream_t * substream)
+{
+	return snd_ali_modem_open(substream, ALI_MODEM_IN_CHANNEL);
+}
+
+static int snd_ali_modem_close(snd_pcm_substream_t * substream)
+{
+	ali_t *codec = snd_pcm_substream_chip(substream);
+	snd_ali_voice_t *pvoice = (snd_ali_voice_t *) substream->runtime->private_data;
+	snd_ali_disable_special_channel(codec,pvoice->number);
+	return 0;
+}
+
+static snd_pcm_ops_t snd_ali_modem_playback_ops = {
+	.open =		snd_ali_modem_playback_open,
+	.close =	snd_ali_modem_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_ali_modem_hw_params,
+	.hw_free =	snd_ali_modem_hw_free,
+	.prepare =	snd_ali_modem_prepare,
+	.trigger =	snd_ali_modem_trigger,
+	.pointer =	snd_ali_modem_pointer,
+};
+
+static snd_pcm_ops_t snd_ali_modem_capture_ops = {
+	.open =		snd_ali_modem_capture_open,
+	.close =	snd_ali_modem_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_ali_modem_hw_params,
+	.hw_free =	snd_ali_modem_hw_free,
+	.prepare =	snd_ali_modem_prepare,
+	.trigger =	snd_ali_modem_trigger,
+	.pointer =	snd_ali_modem_pointer,
+};
+#endif
 
 static void snd_ali_pcm_free(snd_pcm_t *pcm)
 {
 	ali_t *codec = pcm->private_data;
-	codec->pcm = NULL;
+	int i;
+	for(i = 0 ; i < codec->num_of_codecs ; i++)
+		if (codec->pcm[i] == pcm)
+			codec->pcm[i] = NULL;
 }
 
+#ifdef CREATE_MODEM_PCM
+static int __devinit snd_ali_modem_pcm(ali_t *codec, int pcm_dev)
+{
+	snd_pcm_t *pcm;
+	int err = snd_pcm_new(codec->card, "ALI 5451 modem", pcm_dev, 1, 1, &pcm);
+	if (err < 0) {
+		snd_printk("snd_ali_pcm: err called snd_pcm_new.\n");
+		return err;
+	}
+	pcm->private_data = codec;
+	pcm->private_free = snd_ali_pcm_free;
+	pcm->info_flags = 0;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_ali_modem_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ali_modem_capture_ops);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(codec->pci), 64*1024, 128*1024);
+	//pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
+	strcpy(pcm->name, "ALI 5451 modem");
+	codec->pcm[pcm_dev] = pcm;
+#if 1 // FIXME: find better place
+	{ unsigned long flags;
+	u32 val;
+	spin_lock_irqsave(&codec->reg_lock, flags);
+	val = inl(ALI_REG(codec, ALI_SCTRL));
+	if (pcm_dev == 0)
+		val &= ~(ALI_SCTRL_LINE_IN2 | ALI_SCTRL_GPIO_IN2);
+	else
+		val |= (ALI_SCTRL_LINE_IN2 | ALI_SCTRL_GPIO_IN2);
+	val |= ALI_SCTRL_LINE_OUT_EN;
+	outl(val, ALI_REG(codec, ALI_SCTRL));
+	spin_unlock_irqrestore(&codec->reg_lock, flags);
+	}
+#endif
+	return 0;
+}
+#endif
+
 static int __devinit snd_ali_pcm(ali_t * codec, int device, snd_pcm_t ** rpcm)
 {
 	snd_pcm_t *pcm;
@@ -1737,11 +2028,36 @@
 	pcm->info_flags = 0;
 	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
 	strcpy(pcm->name, "ALI 5451");
-	codec->pcm = pcm;
+	codec->pcm[0] = pcm;
 	if (rpcm) *rpcm = pcm;
+#ifdef CREATE_MODEM_PCM
+	if (codec->num_of_codecs > 1)
+		snd_ali_modem_pcm(codec, device + 1);
+#endif
 	return 0;
 }
 
+#if 0
+struct pcm_decsiption {
+	const char *name;
+	ops/ops;
+};
+
+static int __devinit snd_ali_build_pcms(ali_t *codec, int device)
+{
+	int i;
+	for(i = 0 ; i < codec->num_of_codecs ; i++) {
+		if(ac97_is_audio(codec->ac97[i]) &&
+		    (err = snd_ali_pcm(codec, device, i, NULL)) < 0)
+			return err;
+		if(ac97_is_modem(codec->ac97[i]) &&
+		    (err = snd_ali_modem_pcm(codec, device, i, NULL)) < 0)
+			return err;
+	}
+	return 0;
+}
+#endif
+
 #define ALI5451_SPDIF(xname, xindex, value) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex,\
 .info = snd_ali5451_spdif_info, .get = snd_ali5451_spdif_get, \
@@ -1860,14 +2176,14 @@
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
@@ -1877,13 +2193,17 @@
 		return err;
 	codec->ac97_bus->private_free = snd_ali_mixer_free_ac97_bus;
 
+	for ( i = 0 ; i < codec->num_of_codecs ; i++) {
 	memset(&ac97, 0, sizeof(ac97));
+		ac97.num = i;
 	ac97.private_data = codec;
 	ac97.private_free = snd_ali_mixer_free_ac97;
-	if ((err = snd_ac97_mixer(codec->ac97_bus, &ac97, &codec->ac97)) < 0) {
-		snd_printk("ali mixer creating error.\n");
+		if ((err = snd_ac97_mixer(codec->ac97_bus, &ac97, &codec->ac97[i])) < 0) {
+			snd_printk("ali mixer %d creating error.\n", i);
+			if(i == 0)
 		return err;
 	}
+	}
 	if (codec->spdif_support) {
 		for(idx = 0; idx < ARRAY_SIZE(snd_ali5451_mixer_spdif); idx++) {
 			err=snd_ctl_add(codec->card, snd_ctl_new1(&snd_ali5451_mixer_spdif[idx], codec));
@@ -1904,8 +2224,12 @@
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
 	
@@ -1969,7 +2293,9 @@
 	
 	spin_unlock_irq(&chip->reg_lock);
 
-	snd_ac97_resume(chip->ac97);
+	for(i = 0 ; i < chip->num_of_codecs ; i++)
+		if(chip->ac97[i])
+			snd_ac97_resume(chip->ac97[i]);
 	
 	return 0;
 }
@@ -2036,11 +2362,32 @@
 		codec->spdif_mask = 0x00000002;
 	}
 
+	codec->num_of_codecs = 1;
+	
+	if (inl(ALI_REG(codec, ALI_SCTRL)) & ALI_SCTRL_CODEC2_READY)
+		codec->num_of_codecs++;
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
@@ -2238,6 +2585,8 @@
 		return err;
 	}
 
+	snd_ali_proc_init(codec);
+
 	strcpy(card->driver, "ALI5451");
 	strcpy(card->shortname, "ALI 5451");
 	

--8GpibOaaTibBMecb--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
