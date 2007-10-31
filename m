From: "Timofei V. Bondarenko" <tim@ipi.ac.ru>
Subject: Re: [PATCH] cmipci at 96kHz
Date: Wed, 31 Oct 2007 19:25:24 +0300
Message-ID: <4728AC74.4040404@ipi.ac.ru>
References: <4725F492.9020304@ipi.ac.ru>	<1193733852.1219.1218549445@webmail.messagingengine.com>	<47273E3A.8030205@ipi.ac.ru>
	<s5hzlxzofl8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040009010405050609050003"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipi.ac.ru (blackpeer.ipi.ac.ru [83.149.227.82])
	by alsa0.perex.cz (Postfix) with ESMTP id 23F37243C9
	for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2007 17:25:27 +0100 (CET)
In-Reply-To: <s5hzlxzofl8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040009010405050609050003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Tue, 30 Oct 2007 17:22:50 +0300,
> Timofei V. Bondarenko wrote:
>> Clemens Ladisch wrote:
>>> Timofei V. Bondarenko wrote:
>>>> This patch adds support for 88.2k, 96k, and 128k samplerates
>>>> on cmi8738-55 chip.
>>>> Analog playback works fine on all channels.
>>>> Analog capture works well too, though the extra samples seems 
>>>> interpolated by hardware.
>>>> spdif playback and capture works fine.
>>>> +		freq_ext = CM_CH0_SRATE_88K | CM_CH0_SRATE_96K;
>>> I'd guess there should be a new symbol CM_CH0_SRATE_128K.
>> Ok. One more one-time-use symbol.
>>
>>>> +		case 88200:
>>>> +			freq = 44100;
>>>> +		case 96000:
>>>> +			freq = 48000;
>>>> +		case 128000:
>>>> +			freq = 32000; /* not matter, 
>>> Wouldn't it be simpler to divide freq by two in all three cases?
>> Not so easy, 128/2 = 64 - is an invalid rate,
>> snd_cmipci_rate_freq() will complain.
>> On another hand an invalid 64k/2=32k (valid) - this make snd_BUG() in 
>> snd_cmipci_rate_freq() useless.
>>
>> If the '68 chip also don't care about CM_REG_FUNCTRL1:ASFC/DSFC then
>> freq can be set to 0 for all doubled frequencies.
> 
> The changes in your patch look good to me, but I'd like to ask you to
> fix the coding style.  (At least, we should follow the standard coding
> style for new codes.)
> 
> Run checkpatch.pl script included in linux-kernel/scripts directory,
> and you'll see what I meant :)
> 

Nice tool. I should be using it before.

Regards,
	Tim.

--------------040009010405050609050003
Content-Type: text/x-patch;
 name="cmi96k-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmi96k-3.patch"

Signed-off-by: Timofei Bondarenko <tim@ipi.ac.ru>

--- alsa-driver-hg20071027/alsa-kernel/pci/cmipci.c	2007-09-18 04:00:10.000000000 +0400
+++ alsa-driver/alsa-kernel/pci/cmipci.c	2007-10-31 19:04:51.000000000 +0300
@@ -150,6 +150,8 @@ MODULE_PARM_DESC(joystick_port, "Joystic
 #define CM_CH0_SRATE_176K	0x00000200
 #define CM_CH0_SRATE_96K	0x00000200	/* model 055? */
 #define CM_CH0_SRATE_88K	0x00000100
+#define CM_CH0_SRATE_128K	0x00000300
+#define CM_CH0_SRATE_MASK	0x00000300
 
 #define CM_SPDIF_INVERSE2	0x00000080	/* model 055? */
 #define CM_DBLSPDS		0x00000040	/* double SPDIF sample rate 88.2/96 */
@@ -474,6 +476,7 @@ struct cmipci {
 	unsigned int can_ac3_sw: 1;
 	unsigned int can_ac3_hw: 1;
 	unsigned int can_multi_ch: 1;
+	unsigned int can_96k: 1;	/* samplerate above 48k */
 	unsigned int do_soft_ac3: 1;
 
 	unsigned int spdif_playback_avail: 1;	/* spdif ready? */
@@ -604,8 +607,6 @@ static unsigned int snd_cmipci_rate_freq
 {
 	unsigned int i;
 
-	if (rate > 48000)
-		rate /= 2;
 	for (i = 0; i < ARRAY_SIZE(rates); i++) {
 		if (rates[i] == rate)
 			return i;
@@ -783,7 +784,7 @@ static int set_dac_channels(struct cmipc
 static int snd_cmipci_pcm_prepare(struct cmipci *cm, struct cmipci_pcm *rec,
 				 struct snd_pcm_substream *substream)
 {
-	unsigned int reg, freq, val;
+	unsigned int reg, freq, freq_ext, val;
 	unsigned int period_size;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -831,7 +832,17 @@ static int snd_cmipci_pcm_prepare(struct
 	//snd_printd("cmipci: functrl0 = %08x\n", cm->ctrl);
 
 	/* set sample rate */
-	freq = snd_cmipci_rate_freq(runtime->rate);
+	freq = 0;
+	freq_ext = 0;
+	if (runtime->rate > 48000)
+		switch (runtime->rate) {
+		case 88200:  freq_ext = CM_CH0_SRATE_88K; break;
+		case 96000:  freq_ext = CM_CH0_SRATE_96K; break;
+		case 128000: freq_ext = CM_CH0_SRATE_128K; break;
+		default:     snd_BUG(); break;
+		}
+	else
+		freq = snd_cmipci_rate_freq(runtime->rate);
 	val = snd_cmipci_read(cm, CM_REG_FUNCTRL1);
 	if (rec->ch) {
 		val &= ~CM_DSFC_MASK;
@@ -852,15 +863,9 @@ static int snd_cmipci_pcm_prepare(struct
 		val &= ~CM_CH0FMT_MASK;
 		val |= rec->fmt << CM_CH0FMT_SHIFT;
 	}
-	if (cm->chip_version == 68) {
-		if (runtime->rate == 88200)
-			val |= CM_CH0_SRATE_88K << (rec->ch * 2);
-		else
-			val &= ~(CM_CH0_SRATE_88K << (rec->ch * 2));
-		if (runtime->rate == 96000)
-			val |= CM_CH0_SRATE_96K << (rec->ch * 2);
-		else
-			val &= ~(CM_CH0_SRATE_96K << (rec->ch * 2));
+	if (cm->can_96k) {
+		val &= ~(CM_CH0_SRATE_MASK << (rec->ch * 2));
+		val |= freq_ext << (rec->ch * 2);
 	}
 	snd_cmipci_write(cm, CM_REG_CHFORMAT, val);
 	//snd_printd("cmipci: chformat = %08x\n", val);
@@ -1281,7 +1286,7 @@ static int snd_cmipci_playback_prepare(s
 	int rate = substream->runtime->rate;
 	int err, do_spdif, do_ac3 = 0;
 
-	do_spdif = (rate >= 44100 &&
+	do_spdif = (rate >= 44100 && rate <= 96000 &&
 		    substream->runtime->format == SNDRV_PCM_FORMAT_S16_LE &&
 		    substream->runtime->channels == 2);
 	if (do_spdif && cm->can_ac3_hw) 
@@ -1337,10 +1342,8 @@ static void snd_cmipci_silence_hack(stru
 		val = snd_cmipci_read(cm, CM_REG_CHFORMAT);
 		val &= ~(CM_CH0FMT_MASK << (rec->ch * 2));
 		val |= (3 << CM_CH0FMT_SHIFT) << (rec->ch * 2);
-		if (cm->chip_version == 68) {
-			val &= ~(CM_CH0_SRATE_88K << (rec->ch * 2));
-			val &= ~(CM_CH0_SRATE_96K << (rec->ch * 2));
-		}
+		if (cm->can_96k)
+			val &= ~(CM_CH0_SRATE_MASK << (rec->ch * 2));
 		snd_cmipci_write(cm, CM_REG_CHFORMAT, val);
 	
 		/* start stream (we don't need interrupts) */
@@ -1392,6 +1395,12 @@ static int snd_cmipci_capture_spdif_prep
 
 	spin_lock_irq(&cm->reg_lock);
 	snd_cmipci_set_bit(cm, CM_REG_FUNCTRL1, CM_CAPTURE_SPDF);
+	if (cm->can_96k) {
+		if (substream->runtime->rate > 48000)
+			snd_cmipci_set_bit(cm, CM_REG_CHFORMAT, CM_DBLSPDS);
+		else
+			snd_cmipci_clear_bit(cm, CM_REG_CHFORMAT, CM_DBLSPDS);
+	}
 	spin_unlock_irq(&cm->reg_lock);
 
 	return snd_cmipci_pcm_prepare(cm, &cm->channel[CM_CH_CAPT], substream);
@@ -1568,6 +1577,14 @@ static struct snd_pcm_hardware snd_cmipc
 	.fifo_size =		0,
 };
 
+static unsigned int rate_constraints[] = { 5512, 8000, 11025, 16000, 22050,
+			32000, 44100, 48000, 88200, 96000, 128000 };
+static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+		.count = ARRAY_SIZE(rate_constraints),
+		.list = rate_constraints,
+		.mask = 0,
+};
+
 /*
  * check device open/close
  */
@@ -1637,6 +1654,12 @@ static int snd_cmipci_playback_open(stru
 		runtime->hw.rates |= SNDRV_PCM_RATE_88200 |
 				     SNDRV_PCM_RATE_96000;
 		runtime->hw.rate_max = 96000;
+	} else if (cm->chip_version == 55) {
+		if ((err = snd_pcm_hw_constraint_list(runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates)) < 0)
+			return err;
+		runtime->hw.rates |= SNDRV_PCM_RATE_KNOT;
+		runtime->hw.rate_max = 128000;
 	}
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 0, 0x10000);
 	cm->dig_pcm_status = cm->dig_status;
@@ -1655,6 +1678,12 @@ static int snd_cmipci_capture_open(struc
 	if (cm->chip_version == 68) {	// 8768 only supports 44k/48k recording
 		runtime->hw.rate_min = 41000;
 		runtime->hw.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000;
+	} else if (cm->chip_version == 55) {
+		if ((err = snd_pcm_hw_constraint_list(runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates)) < 0)
+			return err;
+		runtime->hw.rates |= SNDRV_PCM_RATE_KNOT;
+		runtime->hw.rate_max = 128000;
 	}
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 0, 0x10000);
 	return 0;
@@ -1686,6 +1715,12 @@ static int snd_cmipci_playback2_open(str
 		runtime->hw.rates |= SNDRV_PCM_RATE_88200 |
 				     SNDRV_PCM_RATE_96000;
 		runtime->hw.rate_max = 96000;
+	} else if (cm->chip_version == 55) {
+		if ((err = snd_pcm_hw_constraint_list(runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates)) < 0)
+			return err;
+		runtime->hw.rates |= SNDRV_PCM_RATE_KNOT;
+		runtime->hw.rate_max = 128000;
 	}
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 0, 0x10000);
 	return 0;
@@ -1705,7 +1740,7 @@ static int snd_cmipci_playback_spdif_ope
 			runtime->hw.formats |= SNDRV_PCM_FMTBIT_S32_LE;
 			snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
 		}
-		if (cm->chip_version == 68) {
+		if (cm->can_96k) {
 			runtime->hw.rates |= SNDRV_PCM_RATE_88200 |
 					     SNDRV_PCM_RATE_96000;
 			runtime->hw.rate_max = 96000;
@@ -1727,6 +1762,11 @@ static int snd_cmipci_capture_spdif_open
 	if ((err = open_device_check(cm, CM_OPEN_SPDIF_CAPTURE, substream)) < 0) /* use channel B */
 		return err;
 	runtime->hw = snd_cmipci_capture_spdif;
+	if (cm->can_96k && !(cm->chip_version == 68)) {
+		runtime->hw.rates |= SNDRV_PCM_RATE_88200 |
+				     SNDRV_PCM_RATE_96000;
+		runtime->hw.rate_max = 96000;
+	}
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 0, 0x40000);
 	return 0;
 }
@@ -2786,9 +2826,11 @@ static void __devinit query_chip(struct 
 		} else if (detect & CM_CHIP_8768) {
 			cm->chip_version = 68;
 			cm->max_channels = 8;
+			cm->can_96k = 1;
 		} else {
 			cm->chip_version = 55;
 			cm->max_channels = 6;
+			cm->can_96k = 1;
 		}
 		cm->can_ac3_hw = 1;
 		cm->can_multi_ch = 1;

--------------040009010405050609050003
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040009010405050609050003--
