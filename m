From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 06/24] sound/pci: coding style fixes:
	sound/pci/c*
Date: Tue, 9 Sep 2008 05:49:45 +0400
Message-ID: <20080909014945.GJ6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C04F2447A
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:49:51 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1535054fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:49:51 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/bt87x.c                      |    4 +-
 sound/pci/cmipci.c                     |   80 +++++++++++++++---------------
 sound/pci/cs4281.c                     |   82 ++++++++++++++++----------------
 sound/pci/cs5530.c                     |    8 ++--
 sound/pci/cs5535audio/cs5535audio.c    |    8 ++--
 sound/pci/cs5535audio/cs5535audio_pm.c |   12 ++--
 6 files changed, 97 insertions(+), 97 deletions(-)

diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index 3aa8d97..e9a4fad 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -27,7 +27,7 @@
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
 #include <linux/bitops.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -603,7 +603,7 @@ static int snd_bt87x_capture_boost_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_bt87x *chip = snd_kcontrol_chip(kcontrol);
 
-	value->value.integer.value[0] = !! (chip->reg_control & CTL_A_G2X);
+	value->value.integer.value[0] = !!(chip->reg_control & CTL_A_G2X);
 	return 0;
 }
 
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 1a74ca6..411ff65 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -16,11 +16,11 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
- 
+
 /* Does not work. Warning may block system in capture mode */
 /* #define USE_VAR48KRATE */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -125,7 +125,7 @@ MODULE_PARM_DESC(joystick_port, "Joystick port address.");
 #define CM_SPD24SEL		0x00020000	/* 24bit spdif: model 037 */
 /* #define CM_SPDIF_INVERSE	0x00010000 */ /* ??? */
 
-#define CM_ADCBITLEN_MASK	0x0000C000	
+#define CM_ADCBITLEN_MASK	0x0000C000
 #define CM_ADCBITLEN_16		0x00000000
 #define CM_ADCBITLEN_15		0x00004000
 #define CM_ADCBITLEN_14		0x00008000
@@ -255,7 +255,7 @@ MODULE_PARM_DESC(joystick_port, "Joystick port address.");
 #define CM_UPDDMA_2048		0x00000000
 #define CM_UPDDMA_1024		0x00000004
 #define CM_UPDDMA_512		0x00000008
-#define CM_UPDDMA_256		0x0000000C		
+#define CM_UPDDMA_256		0x0000000C
 #define CM_TWAIT_MASK		0x00000003	/* model 037 */
 #define CM_TWAIT1		0x00000002	/* FM i/o cycle, 0: 48, 1: 64 PCICLKs */
 #define CM_TWAIT0		0x00000001	/* i/o cycle, 0: 4, 1: 6 PCICLKs */
@@ -450,7 +450,7 @@ static const struct cmipci_mixer_auto_switches cm_saved_mixer[] = {
 	{"PCM Playback Switch", 0},
 	{"IEC958 Output Switch", 1},
 	{"IEC958 Mix Analog", 0},
-	// {"IEC958 Out To DAC", 1}, // no longer used
+	/* {"IEC958 Out To DAC", 1}, // no longer used */
 	{"IEC958 Loop", 0},
 };
 #define CM_SAVED_MIXERS		ARRAY_SIZE(cm_saved_mixer)
@@ -827,7 +827,7 @@ static int snd_cmipci_pcm_prepare(struct cmipci *cm, struct cmipci_pcm *rec,
 	else
 		cm->ctrl |= val;
 	snd_cmipci_write(cm, CM_REG_FUNCTRL0, cm->ctrl);
-	//snd_printd("cmipci: functrl0 = %08x\n", cm->ctrl);
+	/* snd_printd("cmipci: functrl0 = %08x\n", cm->ctrl); */
 
 	/* set sample rate */
 	freq = 0;
@@ -850,7 +850,7 @@ static int snd_cmipci_pcm_prepare(struct cmipci *cm, struct cmipci_pcm *rec,
 		val |= (freq << CM_ASFC_SHIFT) & CM_ASFC_MASK;
 	}
 	snd_cmipci_write(cm, CM_REG_FUNCTRL1, val);
-	//snd_printd("cmipci: functrl1 = %08x\n", val);
+	/* snd_printd("cmipci: functrl1 = %08x\n", val); */
 
 	/* set format */
 	val = snd_cmipci_read(cm, CM_REG_CHFORMAT);
@@ -866,7 +866,7 @@ static int snd_cmipci_pcm_prepare(struct cmipci *cm, struct cmipci_pcm *rec,
 		val |= freq_ext << (rec->ch * 2);
 	}
 	snd_cmipci_write(cm, CM_REG_CHFORMAT, val);
-	//snd_printd("cmipci: chformat = %08x\n", val);
+	/* snd_printd("cmipci: chformat = %08x\n", val); */
 
 	if (!rec->is_dac && cm->chip_version) {
 		if (runtime->rate > 44100)
@@ -904,7 +904,7 @@ static int snd_cmipci_pcm_trigger(struct cmipci *cm, struct cmipci_pcm *rec,
 		cm->ctrl |= chen;
 		/* enable channel */
 		snd_cmipci_write(cm, CM_REG_FUNCTRL0, cm->ctrl);
-		//snd_printd("cmipci: functrl0 = %08x\n", cm->ctrl);
+		/* snd_printd("cmipci: functrl0 = %08x\n", cm->ctrl); */
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		rec->running = 0;
@@ -944,7 +944,7 @@ static snd_pcm_uframes_t snd_cmipci_pcm_pointer(struct cmipci *cm, struct cmipci
 	unsigned int reg;
 	if (!rec->running)
 		return 0;
-#if 1 // this seems better..
+#if 1 /* this seems better.. */
 	reg = rec->ch ? CM_REG_CH1_FRAME2 : CM_REG_CH0_FRAME2;
 	ptr = rec->dma_size - (snd_cmipci_read_w(cm, reg) + 1);
 	ptr >>= rec->shift;
@@ -1127,7 +1127,7 @@ static struct snd_kcontrol_new snd_cmipci_spdif_stream __devinitdata =
 /* save mixer setting and mute for AC3 playback */
 static int save_mixer_state(struct cmipci *cm)
 {
-	if (! cm->mixer_insensitive) {
+	if (!cm->mixer_insensitive) {
 		struct snd_ctl_elem_value *val;
 		unsigned int i;
 
@@ -1199,7 +1199,7 @@ static void setup_ac3(struct cmipci *cm, struct snd_pcm_substream *subs, int do_
 		snd_cmipci_set_bit(cm, CM_REG_CHFORMAT, CM_AC3EN1);
 		/* AC3EN for 039 */
 		snd_cmipci_set_bit(cm, CM_REG_MISC_CTRL, CM_AC3EN2);
-	
+
 		if (cm->can_ac3_hw) {
 			/* SPD24SEL for 037, 0x02 */
 			/* SPD24SEL for 039, 0x20, but cannot be set */
@@ -1294,7 +1294,7 @@ static int snd_cmipci_playback_prepare(struct snd_pcm_substream *substream)
 	do_spdif = (rate >= 44100 && rate <= 96000 &&
 		    substream->runtime->format == SNDRV_PCM_FORMAT_S16_LE &&
 		    substream->runtime->channels == 2);
-	if (do_spdif && cm->can_ac3_hw) 
+	if (do_spdif && cm->can_ac3_hw)
 		do_ac3 = cm->dig_pcm_status & IEC958_AES0_NONAUDIO;
 	if ((err = setup_spdif_playback(cm, substream, do_spdif, do_ac3)) < 0)
 		return err;
@@ -1307,7 +1307,7 @@ static int snd_cmipci_playback_spdif_prepare(struct snd_pcm_substream *substream
 	struct cmipci *cm = snd_pcm_substream_chip(substream);
 	int err, do_ac3;
 
-	if (cm->can_ac3_hw) 
+	if (cm->can_ac3_hw)
 		do_ac3 = cm->dig_pcm_status & IEC958_AES0_NONAUDIO;
 	else
 		do_ac3 = 1; /* doesn't matter */
@@ -1335,7 +1335,7 @@ static void snd_cmipci_silence_hack(struct cmipci *cm, struct cmipci_pcm *rec)
 		reg = rec->ch ? CM_REG_CH1_FRAME2 : CM_REG_CH0_FRAME2;
 		val = ((PAGE_SIZE / 4) - 1) | (((PAGE_SIZE / 4) / 2 - 1) << 16);
 		snd_cmipci_write(cm, reg, val);
-	
+
 		/* configure for 16 bits, 2 channels, 8 kHz */
 		if (runtime->channels > 2)
 			set_dac_channels(cm, rec, 2);
@@ -1350,7 +1350,7 @@ static void snd_cmipci_silence_hack(struct cmipci *cm, struct cmipci_pcm *rec)
 		if (cm->can_96k)
 			val &= ~(CM_CH0_SRATE_MASK << (rec->ch * 2));
 		snd_cmipci_write(cm, CM_REG_CHFORMAT, val);
-	
+
 		/* start stream (we don't need interrupts) */
 		cm->ctrl |= CM_CHEN0 << rec->ch;
 		snd_cmipci_write(cm, CM_REG_FUNCTRL0, cm->ctrl);
@@ -1436,7 +1436,7 @@ static irqreturn_t snd_cmipci_interrupt(int irq, void *dev_id)
 {
 	struct cmipci *cm = dev_id;
 	unsigned int status, mask = 0;
-	
+
 	/* fastpath out, to ease interrupt sharing */
 	status = snd_cmipci_read(cm, CM_REG_INT_STATUS);
 	if (!(status & CM_INTR))
@@ -1616,7 +1616,7 @@ static int open_device_check(struct cmipci *cm, int mode, struct snd_pcm_substre
 	}
 	cm->opened[ch] = mode;
 	cm->channel[ch].substream = subs;
-	if (! (mode & CM_OPEN_DAC)) {
+	if (!(mode & CM_OPEN_DAC)) {
 		/* disable dual DAC mode */
 		cm->channel[ch].is_dac = 0;
 		spin_lock_irq(&cm->reg_lock);
@@ -1639,7 +1639,7 @@ static void close_device_check(struct cmipci *cm, int mode)
 			cm->channel[ch].substream = NULL;
 		}
 		cm->opened[ch] = 0;
-		if (! cm->channel[ch].is_dac) {
+		if (!cm->channel[ch].is_dac) {
 			/* enable dual DAC mode again */
 			cm->channel[ch].is_dac = 1;
 			spin_lock_irq(&cm->reg_lock);
@@ -1688,7 +1688,7 @@ static int snd_cmipci_capture_open(struct snd_pcm_substream *substream)
 	if ((err = open_device_check(cm, CM_OPEN_CAPTURE, substream)) < 0)
 		return err;
 	runtime->hw = snd_cmipci_capture;
-	if (cm->chip_version == 68) {	// 8768 only supports 44k/48k recording
+	if (cm->chip_version == 68) {	/* 8768 only supports 44k/48k recording */
 		runtime->hw.rate_min = 41000;
 		runtime->hw.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000;
 	} else if (cm->chip_version == 55) {
@@ -1713,7 +1713,7 @@ static int snd_cmipci_playback2_open(struct snd_pcm_substream *substream)
 		return err;
 	runtime->hw = snd_cmipci_playback2;
 	mutex_lock(&cm->open_mutex);
-	if (! cm->opened[CM_CH_PLAY]) {
+	if (!cm->opened[CM_CH_PLAY]) {
 		if (cm->can_multi_ch) {
 			runtime->hw.channels_max = cm->max_channels;
 			if (cm->max_channels == 4)
@@ -2030,7 +2030,7 @@ static int snd_cmipci_info_volume(struct snd_kcontrol *kcontrol,
 	uinfo->value.integer.max = reg.mask;
 	return 0;
 }
- 
+
 static int snd_cmipci_get_volume(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
@@ -2112,7 +2112,7 @@ static int snd_cmipci_info_input_sw(struct snd_kcontrol *kcontrol,
 	uinfo->value.integer.max = 1;
 	return 0;
 }
- 
+
 static int snd_cmipci_get_input_sw(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
@@ -2260,7 +2260,7 @@ static int snd_cmipci_put_native_mixer(struct snd_kcontrol *kcontrol,
 static int snd_cmipci_get_native_mixer_sensitive(struct snd_kcontrol *kcontrol,
 						 struct snd_ctl_elem_value *ucontrol)
 {
-	//struct cmipci *cm = snd_kcontrol_chip(kcontrol);
+	/* struct cmipci *cm = snd_kcontrol_chip(kcontrol); */
 	return snd_cmipci_get_native_mixer(kcontrol, ucontrol);
 }
 
@@ -2280,7 +2280,7 @@ static struct snd_kcontrol_new snd_cmipci_mixers[] __devinitdata = {
 	CMIPCI_SB_VOL_STEREO("Master Playback Volume", SB_DSP4_MASTER_DEV, 3, 31),
 	CMIPCI_MIXER_SW_MONO("3D Control - Switch", CM_REG_MIXER1, CM_X3DEN_SHIFT, 0),
 	CMIPCI_SB_VOL_STEREO("PCM Playback Volume", SB_DSP4_PCM_DEV, 3, 31),
-	//CMIPCI_MIXER_SW_MONO("PCM Playback Switch", CM_REG_MIXER1, CM_WSMUTE_SHIFT, 1),
+	/* CMIPCI_MIXER_SW_MONO("PCM Playback Switch", CM_REG_MIXER1, CM_WSMUTE_SHIFT, 1), */
 	{ /* switch with sensitivity */
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "PCM Playback Switch",
@@ -2380,7 +2380,7 @@ static int _snd_cmipci_uswitch_put(struct snd_kcontrol *kcontrol,
 		val = inb(cm->iobase + args->reg);
 	else
 		val = snd_cmipci_read(cm, args->reg);
-	change = (val & args->mask) != (ucontrol->value.integer.value[0] ? 
+	change = (val & args->mask) != (ucontrol->value.integer.value[0] ?
 			args->mask_on : (args->mask & ~args->mask_on));
 	if (change) {
 		val &= ~args->mask;
@@ -2415,7 +2415,7 @@ static struct cmipci_switch_args cmipci_switch_arg_##sname = { \
   .is_byte = xis_byte, \
   .ac3_sensitive = xac3, \
 }
-	
+
 #define DEFINE_BIT_SWITCH_ARG(sname, xreg, xmask, xis_byte, xac3) \
 	DEFINE_SWITCH_ARG(sname, xreg, xmask, xmask, xis_byte, xac3)
 
@@ -2572,7 +2572,7 @@ static int snd_cmipci_mic_in_mode_get(struct snd_kcontrol *kcontrol,
 	struct cmipci *cm = snd_kcontrol_chip(kcontrol);
 	/* same bit as spdi_phase */
 	spin_lock_irq(&cm->reg_lock);
-	ucontrol->value.enumerated.item[0] = 
+	ucontrol->value.enumerated.item[0] =
 		(snd_cmipci_read_b(cm, CM_REG_MISC) & CM_SPDIF_INVERSE) ? 1 : 0;
 	spin_unlock_irq(&cm->reg_lock);
 	return 0;
@@ -2616,7 +2616,7 @@ static struct snd_kcontrol_new snd_cmipci_8738_mixer_switches[] __devinitdata =
 	DEFINE_MIXER_SWITCH("IEC958 Out", spdif_out),
 	DEFINE_MIXER_SWITCH("IEC958 Out To DAC", spdo2dac),
 #endif
-	// DEFINE_MIXER_SWITCH("IEC958 Output Switch", spdif_enable),
+	/* DEFINE_MIXER_SWITCH("IEC958 Output Switch", spdif_enable), */
 	{ .name = "IEC958 Output Switch",
 	  .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	  .info = snd_cmipci_uswitch_info,
@@ -2676,7 +2676,7 @@ static int __devinit snd_cmipci_mixer_new(struct cmipci *cm, int pcm_spdif_devic
 	spin_unlock_irq(&cm->reg_lock);
 
 	for (idx = 0; idx < ARRAY_SIZE(snd_cmipci_mixers); idx++) {
-		if (cm->chip_version == 68) {	// 8768 has no PCM volume
+		if (cm->chip_version == 68) {	/* 8768 has no PCM volume */
 			if (!strcmp(snd_cmipci_mixers[idx].name,
 				"PCM Playback Volume"))
 				continue;
@@ -2692,7 +2692,7 @@ static int __devinit snd_cmipci_mixer_new(struct cmipci *cm, int pcm_spdif_devic
 		if (err < 0)
 			return err;
 	}
-	if (! cm->can_multi_ch) {
+	if (!cm->can_multi_ch) {
 		err = snd_ctl_add(cm->card, snd_ctl_new1(&snd_cmipci_nomulti_switch, cm));
 		if (err < 0)
 			return err;
@@ -2766,12 +2766,12 @@ static int __devinit snd_cmipci_mixer_new(struct cmipci *cm, int pcm_spdif_devic
  */
 
 #ifdef CONFIG_PROC_FS
-static void snd_cmipci_proc_read(struct snd_info_entry *entry, 
+static void snd_cmipci_proc_read(struct snd_info_entry *entry,
 				 struct snd_info_buffer *buffer)
 {
 	struct cmipci *cm = entry->private_data;
 	int i, v;
-	
+
 	snd_iprintf(buffer, "%s\n", cm->card->longname);
 	for (i = 0; i < 0x94; i++) {
 		if (i == 0x28)
@@ -2788,7 +2788,7 @@ static void __devinit snd_cmipci_proc_init(struct cmipci *cm)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(cm->card, "cmipci", &entry))
+	if (!snd_card_proc_new(cm->card, "cmipci", &entry))
 		snd_info_set_text_ops(entry, cm, snd_cmipci_proc_read);
 }
 #else /* !CONFIG_PROC_FS */
@@ -2816,7 +2816,7 @@ static void __devinit query_chip(struct cmipci *cm)
 
 	/* check reg 0Ch, bit 24-31 */
 	detect = snd_cmipci_read(cm, CM_REG_INT_HLDCLR) & CM_CHIP_MASK2;
-	if (! detect) {
+	if (!detect) {
 		/* check reg 08h, bit 24-28 */
 		detect = snd_cmipci_read(cm, CM_REG_CHFORMAT) & CM_CHIP_MASK1;
 		switch (detect) {
@@ -3115,7 +3115,7 @@ static int __devinit snd_cmipci_create(struct snd_card *card, struct pci_dev *pc
 	switch (pci->device) {
 	case PCI_DEVICE_ID_CMEDIA_CM8738:
 	case PCI_DEVICE_ID_CMEDIA_CM8738B:
-		if (!pci_dev_present(intel_82437vx)) 
+		if (!pci_dev_present(intel_82437vx))
 			snd_cmipci_set_bit(cm, CM_REG_MISC_CTRL, CM_TXVX);
 		break;
 	default:
@@ -3267,7 +3267,7 @@ static int __devinit snd_cmipci_probe(struct pci_dev *pci,
 
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
-	if (! enable[dev]) {
+	if (!enable[dev]) {
 		dev++;
 		return -ENOENT;
 	}
@@ -3275,7 +3275,7 @@ static int __devinit snd_cmipci_probe(struct pci_dev *pci,
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
 	if (card == NULL)
 		return -ENOMEM;
-	
+
 	switch (pci->device) {
 	case PCI_DEVICE_ID_CMEDIA_CM8738:
 	case PCI_DEVICE_ID_CMEDIA_CM8738B:
@@ -3343,7 +3343,7 @@ static int snd_cmipci_suspend(struct pci_dev *pci, pm_message_t state)
 	int i;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	
+
 	snd_pcm_suspend_all(cm->pcm);
 	snd_pcm_suspend_all(cm->pcm2);
 	snd_pcm_suspend_all(cm->pcm_spdif);
@@ -3406,7 +3406,7 @@ static struct pci_driver driver = {
 	.resume = snd_cmipci_resume,
 #endif
 };
-	
+
 static int __init alsa_card_cmipci_init(void)
 {
 	return pci_register_driver(&driver);
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index ef9308f..24cc52b 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -19,7 +19,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -573,13 +573,13 @@ static unsigned short snd_cs4281_ac97_read(struct snd_ac97 *ac97,
 	struct cs4281 *chip = ac97->private_data;
 	int count;
 	unsigned short result;
-	// FIXME: volatile is necessary in the following due to a bug of
-	// some gcc versions
+	/* FIXME: volatile is necessary in the following due to a bug of */
+	/* some gcc versions */
 	volatile int ac97_num = ((volatile struct snd_ac97 *)ac97)->num;
 
 	/*
 	 *  1. Write ACCAD = Command Address Register = 46Ch for AC97 register address
-	 *  2. Write ACCDA = Command Data Register = 470h    for data to write to AC97 
+	 *  2. Write ACCDA = Command Data Register = 470h    for data to write to AC97
 	 *  3. Write ACCTL = Control Register = 460h for initiating the write
 	 *  4. Read ACCTL = 460h, DCV should be reset by now and 460h = 17h
 	 *  5. if DCV not cleared, break and return error
@@ -627,7 +627,7 @@ static unsigned short snd_cs4281_ac97_read(struct snd_ac97 *ac97,
 	snd_printk(KERN_ERR "AC'97 read problem (ACCTL_DCV), reg = 0x%x\n", reg);
 	result = 0xffff;
 	goto __end;
-	
+
       __ok1:
 	/*
 	 *  Wait for the valid status bit to go active.
@@ -642,7 +642,7 @@ static unsigned short snd_cs4281_ac97_read(struct snd_ac97 *ac97,
 			goto __ok2;
 		udelay(10);
 	}
-	
+
 	snd_printk(KERN_ERR "AC'97 read problem (ACSTS_VSTS), reg = 0x%x\n", reg);
 	result = 0xffff;
 	goto __end;
@@ -654,7 +654,7 @@ static unsigned short snd_cs4281_ac97_read(struct snd_ac97 *ac97,
 	 */
 	result = snd_cs4281_peekBA0(chip, ac97_num ? BA0_ACSDA2 : BA0_ACSDA);
 
-      __end:
+__end:
 	return result;
 }
 
@@ -707,7 +707,7 @@ static int snd_cs4281_trigger(struct snd_pcm_substream *substream, int cmd)
 static unsigned int snd_cs4281_rate(unsigned int rate, unsigned int *real_rate)
 {
 	unsigned int val = ~0;
-	
+
 	if (real_rate)
 		*real_rate = rate;
 	/* special "hardcoded" rates */
@@ -721,7 +721,7 @@ static unsigned int snd_cs4281_rate(unsigned int rate, unsigned int *real_rate)
 	default:
 		goto __variable;
 	}
-      __variable:
+__variable:
 	val = 1536000 / rate;
 	if (real_rate)
 		*real_rate = 1536000 / val;
@@ -776,7 +776,7 @@ static void snd_cs4281_mode(struct cs4281 *chip, struct cs4281_dma *dma,
 			snd_cs4281_pokeBA0(chip, BA0_ADCSR, val);
 		}
 	}
-      __skip_src:
+__skip_src:
 	/* Deactivate wave playback FIFO before changing slot assignments */
 	if (dma->regFCR == BA0_FCR0)
 		snd_cs4281_pokeBA0(chip, dma->regFCR, snd_cs4281_peekBA0(chip, dma->regFCR) & ~BA0_FCR_FEN);
@@ -834,7 +834,7 @@ static snd_pcm_uframes_t snd_cs4281_pointer(struct snd_pcm_substream *substream)
 	struct cs4281_dma *dma = runtime->private_data;
 	struct cs4281 *chip = snd_pcm_substream_chip(substream);
 
-	// printk("DCC = 0x%x, buffer_size = 0x%x, jiffies = %li\n", snd_cs4281_peekBA0(chip, dma->regDCC), runtime->buffer_size, jiffies);
+	/* printk("DCC = 0x%x, buffer_size = 0x%x, jiffies = %li\n", snd_cs4281_peekBA0(chip, dma->regDCC), runtime->buffer_size, jiffies); */
 	return runtime->buffer_size -
 	       snd_cs4281_peekBA0(chip, dma->regDCC) - 1;
 }
@@ -965,7 +965,7 @@ static struct snd_pcm_ops snd_cs4281_capture_ops = {
 	.pointer =	snd_cs4281_pointer,
 };
 
-static int __devinit snd_cs4281_pcm(struct cs4281 * chip, int device,
+static int __devinit snd_cs4281_pcm(struct cs4281 *chip, int device,
 				    struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
@@ -1008,7 +1008,7 @@ static int snd_cs4281_info_volume(struct snd_kcontrol *kcontrol,
 	uinfo->value.integer.max = CS_VOL_MASK;
 	return 0;
 }
- 
+
 static int snd_cs4281_get_volume(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
@@ -1052,24 +1052,24 @@ static int snd_cs4281_put_volume(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(db_scale_dsp, -4650, 150, 0);
 
-static struct snd_kcontrol_new snd_cs4281_fm_vol = 
+static struct snd_kcontrol_new snd_cs4281_fm_vol =
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Synth Playback Volume",
-	.info = snd_cs4281_info_volume, 
+	.info = snd_cs4281_info_volume,
 	.get = snd_cs4281_get_volume,
-	.put = snd_cs4281_put_volume, 
+	.put = snd_cs4281_put_volume,
 	.private_value = ((BA0_FMLVC << 16) | BA0_FMRVC),
 	.tlv = { .p = db_scale_dsp },
 };
 
-static struct snd_kcontrol_new snd_cs4281_pcm_vol = 
+static struct snd_kcontrol_new snd_cs4281_pcm_vol =
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "PCM Stream Playback Volume",
-	.info = snd_cs4281_info_volume, 
+	.info = snd_cs4281_info_volume,
 	.get = snd_cs4281_get_volume,
-	.put = snd_cs4281_put_volume, 
+	.put = snd_cs4281_put_volume,
 	.private_value = ((BA0_PPLVC << 16) | BA0_PPRVC),
 	.tlv = { .p = db_scale_dsp },
 };
@@ -1089,7 +1089,7 @@ static void snd_cs4281_mixer_free_ac97(struct snd_ac97 *ac97)
 		chip->ac97 = NULL;
 }
 
-static int __devinit snd_cs4281_mixer(struct cs4281 * chip)
+static int __devinit snd_cs4281_mixer(struct cs4281 *chip)
 {
 	struct snd_card *card = chip->card;
 	struct snd_ac97_template ac97;
@@ -1125,7 +1125,7 @@ static int __devinit snd_cs4281_mixer(struct cs4281 * chip)
  * proc interface
  */
 
-static void snd_cs4281_proc_read(struct snd_info_entry *entry, 
+static void snd_cs4281_proc_read(struct snd_info_entry *entry,
 				  struct snd_info_buffer *buffer)
 {
 	struct cs4281 *chip = entry->private_data;
@@ -1142,7 +1142,7 @@ static long snd_cs4281_BA0_read(struct snd_info_entry *entry,
 {
 	long size;
 	struct cs4281 *chip = entry->private_data;
-	
+
 	size = count;
 	if (pos + size > CS4281_BA0_SIZE)
 		size = (long)CS4281_BA0_SIZE - pos;
@@ -1160,7 +1160,7 @@ static long snd_cs4281_BA1_read(struct snd_info_entry *entry,
 {
 	long size;
 	struct cs4281 *chip = entry->private_data;
-	
+
 	size = count;
 	if (pos + size > CS4281_BA1_SIZE)
 		size = (long)CS4281_BA1_SIZE - pos;
@@ -1179,19 +1179,19 @@ static struct snd_info_entry_ops snd_cs4281_proc_ops_BA1 = {
 	.read = snd_cs4281_BA1_read,
 };
 
-static void __devinit snd_cs4281_proc_init(struct cs4281 * chip)
+static void __devinit snd_cs4281_proc_init(struct cs4281 *chip)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(chip->card, "cs4281", &entry))
+	if (!snd_card_proc_new(chip->card, "cs4281", &entry))
 		snd_info_set_text_ops(entry, chip, snd_cs4281_proc_read);
-	if (! snd_card_proc_new(chip->card, "cs4281_BA0", &entry)) {
+	if (!snd_card_proc_new(chip->card, "cs4281_BA0", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = chip;
 		entry->c.ops = &snd_cs4281_proc_ops_BA0;
 		entry->size = CS4281_BA0_SIZE;
 	}
-	if (! snd_card_proc_new(chip->card, "cs4281_BA1", &entry)) {
+	if (!snd_card_proc_new(chip->card, "cs4281_BA1", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = chip;
 		entry->c.ops = &snd_cs4281_proc_ops_BA1;
@@ -1229,16 +1229,16 @@ static int snd_cs4281_gameport_cooked_read(struct gameport *gameport,
 {
 	struct cs4281 *chip = gameport_get_port_data(gameport);
 	unsigned js1, js2, jst;
-	
+
 	if (snd_BUG_ON(!chip))
 		return 0;
 
 	js1 = snd_cs4281_peekBA0(chip, BA0_JSC1);
 	js2 = snd_cs4281_peekBA0(chip, BA0_JSC2);
 	jst = snd_cs4281_peekBA0(chip, BA0_JSPT);
-	
-	*buttons = (~jst >> 4) & 0x0F; 
-	
+
+	*buttons = (~jst >> 4) & 0x0F;
+
 	axes[0] = ((js1 & JSC1_Y1V_MASK) >> JSC1_Y1V_SHIFT) & 0xFFFF;
 	axes[1] = ((js1 & JSC1_X1V_MASK) >> JSC1_X1V_SHIFT) & 0xFFFF;
 	axes[2] = ((js2 & JSC2_Y2V_MASK) >> JSC2_Y2V_SHIFT) & 0xFFFF;
@@ -1286,7 +1286,7 @@ static int __devinit snd_cs4281_create_gameport(struct cs4281 *chip)
 	gp->cooked_read = snd_cs4281_gameport_cooked_read;
 	gameport_set_port_data(gp, chip);
 
-	snd_cs4281_pokeBA0(chip, BA0_JSIO, 0xFF); // ?
+	snd_cs4281_pokeBA0(chip, BA0_JSIO, 0xFF); /* ? */
 	snd_cs4281_pokeBA0(chip, BA0_JSCTL, JSCTL_SP_MEDIUM_SLOW);
 
 	gameport_register_port(gp);
@@ -1388,7 +1388,7 @@ static int __devinit snd_cs4281_create(struct snd_card *card,
 		snd_cs4281_free(chip);
 		return -ENOMEM;
 	}
-	
+
 	if (request_irq(pci->irq, snd_cs4281_interrupt, IRQF_SHARED,
 			"CS4281", chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
@@ -1427,7 +1427,7 @@ static int snd_cs4281_chip_init(struct cs4281 *chip)
 	if (tmp & BA0_EPPMC_FPDN)
 		snd_cs4281_pokeBA0(chip, BA0_EPPMC, tmp & ~BA0_EPPMC_FPDN);
 
-      __retry:
+__retry:
 	tmp = snd_cs4281_peekBA0(chip, BA0_CFLR);
 	if (tmp != BA0_CFLR_DEFAULT) {
 		snd_cs4281_pokeBA0(chip, BA0_CFLR, BA0_CFLR_DEFAULT);
@@ -1440,9 +1440,9 @@ static int snd_cs4281_chip_init(struct cs4281 *chip)
 
 	/* Set the 'Configuration Write Protect' register
 	 * to 4281h.  Allows vendor-defined configuration
-         * space between 0e4h and 0ffh to be written. */	
+         * space between 0e4h and 0ffh to be written. */
 	snd_cs4281_pokeBA0(chip, BA0_CWPR, 0x4281);
-	
+
 	if ((tmp = snd_cs4281_peekBA0(chip, BA0_SERC1)) != (BA0_SERC1_SO1EN | BA0_SERC1_AC97)) {
 		snd_printk(KERN_ERR "SERC1 AC'97 check failed (0x%x)\n", tmp);
 		return -EIO;
@@ -1469,7 +1469,7 @@ static int snd_cs4281_chip_init(struct cs4281 *chip)
          * the Sync pulse on the AC97 link. */
 	snd_cs4281_pokeBA0(chip, BA0_ACCTL, 0);
 	udelay(50);
-                
+
 	/*  Drive the ARST# pin low for a minimum of 1uS (as defined in the AC97
 	 *  spec) and then drive it high.  This is done for non AC97 modes since
 	 *  there might be logic external to the CS4281 that uses the ARST# line
@@ -1549,7 +1549,7 @@ static int snd_cs4281_chip_init(struct cs4281 *chip)
 		} while (time_after_eq(end_time, jiffies));
 		snd_printk(KERN_INFO "secondary codec doesn't respond. disable it...\n");
 		chip->dual_codec = 0;
-	__codec2_ok: ;
+	__codec2_ok:;
 	}
 
 	/*
@@ -1787,7 +1787,7 @@ static struct snd_rawmidi_ops snd_cs4281_midi_input =
 	.trigger =	snd_cs4281_midi_input_trigger,
 };
 
-static int __devinit snd_cs4281_midi(struct cs4281 * chip, int device,
+static int __devinit snd_cs4281_midi(struct cs4281 *chip, int device,
 				     struct snd_rawmidi **rrawmidi)
 {
 	struct snd_rawmidi *rmidi;
@@ -1855,7 +1855,7 @@ static irqreturn_t snd_cs4281_interrupt(int irq, void *dev_id)
 
 	if ((status & BA0_HISR_MIDI) && chip->rmidi) {
 		unsigned char c;
-		
+
 		spin_lock(&chip->reg_lock);
 		while ((snd_cs4281_peekBA0(chip, BA0_MIDSR) & BA0_MIDSR_RBE) == 0) {
 			c = snd_cs4281_peekBA0(chip, BA0_MIDRP);
@@ -2102,7 +2102,7 @@ static struct pci_driver driver = {
 	.resume = cs4281_resume,
 #endif
 };
-	
+
 static int __init alsa_card_cs4281_init(void)
 {
 	return pci_register_driver(&driver);
diff --git a/sound/pci/cs5530.c b/sound/pci/cs5530.c
index 7ff8b68..2e46ac7 100644
--- a/sound/pci/cs5530.c
+++ b/sound/pci/cs5530.c
@@ -10,8 +10,8 @@
  * simultaneously play back audio at 16bit 44100kHz, the device actually plays
  * back in the same format in which it is capturing. By forcing the chip to
  * always play/capture in 16/44100, we can let alsa-lib convert the samples and
- * that way we can hack up some full duplex audio. 
- * 
+ * that way we can hack up some full duplex audio.
+ *
  * XpressAudio(tm) is used on the Cyrix MediaGX (now NatSemi Geode) systems.
  * The older version (VSA1) provides fairly good soundblaster emulation
  * although there are a couple of bugs: large DMA buffers break record,
@@ -126,7 +126,7 @@ static int __devinit snd_cs5530_create(struct snd_card *card,
 
 	err = pci_request_regions(pci, "CS5530");
 	if (err < 0) {
-		kfree(chip); 
+		kfree(chip);
 		pci_disable_device(pci);
 		return err;
 	}
@@ -207,7 +207,7 @@ static int __devinit snd_cs5530_create(struct snd_card *card,
 		return -ENODEV;
 	}
 
-	printk(KERN_INFO "CS5530: IRQ: %d DMA8: %d DMA16: %d\n", irq, dma8, 
+	printk(KERN_INFO "CS5530: IRQ: %d DMA8: %d DMA16: %d\n", irq, dma8,
 									dma16);
 
 	err = snd_sbdsp_create(card, sb_base, irq, snd_sb16dsp_interrupt, dma8,
diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index 1d8b160..07c908c 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -27,7 +27,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
@@ -46,9 +46,9 @@ MODULE_PARM_DESC(ac97_quirk, "AC'97 board specific workarounds.");
 static struct ac97_quirk ac97_quirks[] __devinitdata = {
 #if 0 /* Not yet confirmed if all 5536 boards are HP only */
 	{
-		.subvendor = PCI_VENDOR_ID_AMD, 
-		.subdevice = PCI_DEVICE_ID_AMD_CS5536_AUDIO, 
-		.name = "AMD RDK",     
+		.subvendor = PCI_VENDOR_ID_AMD,
+		.subdevice = PCI_DEVICE_ID_AMD_CS5536_AUDIO,
+		.name = "AMD RDK",
 		.type = AC97_TUNE_HP_ONLY
 	},
 #endif
diff --git a/sound/pci/cs5535audio/cs5535audio_pm.c b/sound/pci/cs5535audio/cs5535audio_pm.c
index 564c33b..ea67963 100644
--- a/sound/pci/cs5535audio/cs5535audio_pm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pm.c
@@ -32,18 +32,18 @@
 
 static void snd_cs5535audio_stop_hardware(struct cs5535audio *cs5535au)
 {
-	/* 
+	/*
 	we depend on snd_ac97_suspend to tell the
 	AC97 codec to shutdown. the amd spec suggests
 	that the LNK_SHUTDOWN be done at the same time
 	that the codec power-down is issued. instead,
-	we do it just after rather than at the same 
+	we do it just after rather than at the same
 	time. excluding codec specific build_ops->suspend
 	ac97 powerdown hits:
-	0x8000 EAPD 
-	0x4000 Headphone amplifier 
-	0x0300 ADC & DAC 
-	0x0400 Analog Mixer powerdown (Vref on) 
+	0x8000 EAPD
+	0x4000 Headphone amplifier
+	0x0300 ADC & DAC
+	0x0400 Analog Mixer powerdown (Vref on)
 	I am not sure if this is the best that we can do.
 	The remainder to be investigated are:
 	- analog mixer (vref off) 0x0800
