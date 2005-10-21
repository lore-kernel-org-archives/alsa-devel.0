From: Ville Herva <vherva@v.iki.fi>
Subject: Re: Re: ice1724 M-Audio Revolution 5.1 support?
Date: Fri, 21 Oct 2005 21:51:05 +0300
Message-ID: <20051021185105.GA30806@v.iki.fi>
References: <s5hmzl4jx34.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hmzl4jx34.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 20, 2005 at 12:34:39PM +0200, you [Takashi Iwai] wrote:
> 
> AK4358 is already supported (Juli uses it).
> If the communication protocol is as same as revo 7.1, it wouldn't be
> too difficlt to implement.  But chechking the communication protocol
> _is_ the most important thing.
> 
> You can do a trial-and-error, or check the pin connection between
> ICE1724 and the codec chip.

With the attached (stupid, clueless) patch, I still get the same distorted
sound, so I guess the communication protocol is different :(.


-- v -- 

v@iki.fi


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

--- ice1724.c.ORIG	2005-10-20 00:17:57.000000000 +0300
+++ ice1724.c	2005-10-20 00:21:24.000000000 +0300
@@ -389,7 +389,7 @@ static int get_max_rate(ice1712_t *ice)
 {
 	if (ice->eeprom.data[ICE_EEP2_ACLINK] & VT1724_CFG_PRO_I2S) {
 		if ((ice->eeprom.data[ICE_EEP2_I2S] & 0x08) && !ice->vt1720)
-			return 192000;
+			return 96000;
 		else
 			return 96000;
 	} else
@@ -657,9 +657,9 @@ static snd_pcm_hardware_t snd_vt1724_pla
 				 SNDRV_PCM_INFO_MMAP_VALID |
 				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_SYNC_START),
 	.formats =		SNDRV_PCM_FMTBIT_S32_LE,
-	.rates =		SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_192000,
+	.rates =		SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_96000,
 	.rate_min =		8000,
-	.rate_max =		192000,
+	.rate_max =		96000,
 	.channels_min =		2,
 	.channels_max =		8,
 	.buffer_bytes_max =	(1UL << 21),	/* 19bits dword */
@@ -695,9 +695,9 @@ static snd_pcm_hardware_t snd_vt1724_2ch
 				 SNDRV_PCM_INFO_MMAP_VALID |
 				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_SYNC_START),
 	.formats =		SNDRV_PCM_FMTBIT_S32_LE,
-	.rates =		SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_192000,
+	.rates =		SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_96000,
 	.rate_min =		8000,
-	.rate_max =		192000,
+	.rate_max =		96000,
 	.channels_min =		2,
 	.channels_max =		2,
 	.buffer_bytes_max =	(1UL << 18),	/* 16bits dword */
@@ -724,7 +724,7 @@ static int set_rate_constraints(ice1712_
 		/* I2S */
 		/* VT1720 doesn't support more than 96kHz */
 		if ((ice->eeprom.data[ICE_EEP2_I2S] & 0x08) && !ice->vt1720)
-			return snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates_192);
+			return snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates_96);
 		else {
 			runtime->hw.rates = SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_96000;
 			runtime->hw.rate_max = 96000;
--- revo.c.ORIG	2005-10-21 21:39:31.000000000 +0300
+++ revo.c	2005-10-21 21:41:46.000000000 +0300
@@ -64,6 +64,9 @@ static void revo_set_rate_val(akm4xxx_t 
 	if (ak->type == SND_AK4355) {
 		reg = 2;
 		shift = 4;
+	} else if (ak->type == SND_AK4358) {
+		reg = 2;
+		shift = 4;
 	} else {
 		reg = 1;
 		shift = 3;
@@ -107,6 +110,14 @@ static struct snd_ak4xxx_private akm_rev
 	.mask_flags = 0,
 };
 
+static akm4xxx_t akm_revo51_front __devinitdata = {
+	.type = SND_AK4358,
+	.num_dacs = 2,
+	.ops = {
+		.set_rate_val = revo_set_rate_val
+	}
+};
+
 static akm4xxx_t akm_revo_surround __devinitdata = {
 	.type = SND_AK4355,
 	.idx_offset = 1,
@@ -116,6 +127,15 @@ static akm4xxx_t akm_revo_surround __dev
 	}
 };
 
+static akm4xxx_t akm_revo51_surround __devinitdata = {
+	.type = SND_AK4358,
+	.idx_offset = 1,
+	.num_dacs = 4,
+	.ops = {
+		.set_rate_val = revo_set_rate_val
+	}
+};
+
 static struct snd_ak4xxx_private akm_revo_surround_priv __devinitdata = {
 	.caddr = 3,
 	.cif = 0,
@@ -150,6 +170,10 @@ static int __devinit revo_init(ice1712_t
 		ice->num_total_dacs = 8;
 		ice->num_total_adcs = 2;
 		break;
+	case VT1724_SUBDEVICE_REVOLUTION51:
+		ice->num_total_dacs = 6;
+		ice->num_total_adcs = 2;
+		break;
 	default:
 		snd_BUG();
 		return -EINVAL;
@@ -163,6 +187,14 @@ static int __devinit revo_init(ice1712_t
 		return -ENOMEM;
 	ice->akm_codecs = 2;
 	switch (ice->eeprom.subvendor) {
+	case VT1724_SUBDEVICE_REVOLUTION51:
+		if ((err = snd_ice1712_akm4xxx_init(ak, &akm_revo51_front, &akm_revo_front_priv, ice)) < 0)
+			return err;
+		if ((err = snd_ice1712_akm4xxx_init(ak + 1, &akm_revo51_surround, &akm_revo_surround_priv, ice)) < 0)
+			return err;
+		/* unmute all codecs */
+		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE, VT1724_REVO_MUTE);
+		break;
 	case VT1724_SUBDEVICE_REVOLUTION71:
 		if ((err = snd_ice1712_akm4xxx_init(ak, &akm_revo_front, &akm_revo_front_priv, ice)) < 0)
 			return err;
@@ -185,6 +217,7 @@ static int __devinit revo_add_controls(i
 
 	switch (ice->eeprom.subvendor) {
 	case VT1724_SUBDEVICE_REVOLUTION71:
+	case VT1724_SUBDEVICE_REVOLUTION51:
 		err = snd_ice1712_akm4xxx_build_controls(ice);
 		if (err < 0)
 			return err;
--- revo.h.ORIG	2005-10-21 21:32:33.000000000 +0300
+++ revo.h	2005-10-17 21:51:01.000000000 +0300
@@ -26,8 +26,11 @@
 
 #define REVO_DEVICE_DESC \
 		"{MidiMan M Audio,Revolution 7.1},"
+#define REVO51_DEVICE_DESC \
+		"{MidiMan M Audio,Revolution 5.1},"
 
 #define VT1724_SUBDEVICE_REVOLUTION71	0x12143036
+#define VT1724_SUBDEVICE_REVOLUTION51	0x12143136
 
 /* entry point */
 extern struct snd_ice1712_card_info snd_vt1724_revo_cards[];

--UlVJffcvxoiEqYs2--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
