From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: add 96Khz support and setting sample rate for
 direct SPDIF output
Date: Sun, 06 Feb 2005 16:12:43 -0500
Message-ID: <1107724363.4212.74.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch should add support for 96Khz "direct SPDIF" aka "SPDIF
Bypass" (not P16V) playback mode available on the Audigy1 and 2 and
newer SBLives (?).  It lets you bypass the 48khz DSP resampling when
using the card in digital mode.  It also adds 96khz analog playback
support, good for testing but less interesting because it's downsampled
to 48khz.  A new mixer control "Audigy SPDIF Output Sample Rate" is
created, you can choose 44100, 48000, or 96000.  Standard SPDIF
playback, AC3 passthrough (real 96khz playback), and analog playback
(96khz is resampled to 48khz in the DSP) all work with a 16 bit,96khz
wav file.  Only the last was tested due to lack of any SPDIF hardware.

This was derived mostly from the opensource.creative.com driver.  All
that was needed for 96khz playback to work in analog mode was changing
the format to 8000_96000 (looks like the creative driver supports 192khz
too).  And, of course this sample rate has always been supported (albeit
downsampled) because if you have 48khz samples in a soundfont the
envelope engine has to be able to pitch shift them in both directions.

I still have not been able to figure out how to get 24 bit playback to
work.  This is possible, independent of the P16V, for spdif and analog
24/48 playback via the DSP.  I do know how to access the full 24 bits
from the ADC from within the DSP, just not how to get it in there.  For
one thing I have no idea which 24 bit format it supports.  Some of them
seemed to work with JACK but produced noise.

This was generated with my multichannel patch but it applies against
ALSA CVS as well.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

diff -ru alsa-48/alsa-kernel/include/emu10k1.h alsa-old/alsa-kernel/include/emu10k1.h
--- alsa-48/alsa-kernel/include/emu10k1.h	2005-02-06 13:46:51.000000000 -0500
+++ alsa-old/alsa-kernel/include/emu10k1.h	2005-02-06 09:27:06.000000000 -0500
@@ -789,9 +789,10 @@
 #define A_FXWC2			0x75		/* Selects 0x9f-0x80 for FX recording           */
 
 #define A_SPDIF_SAMPLERATE	0x76		/* Set the sample rate of SPDIF output		*/
-#define A_SPDIF_48000		0x00000080
-#define A_SPDIF_44100		0x00000000
-#define A_SPDIF_96000		0x00000040
+#define A_SPDIF_RATE_MASK	0x000000c0
+#define A_SPDIF_48000		0x00000000
+#define A_SPDIF_44100		0x00000040
+#define A_SPDIF_96000		0x00000080
 
 /* 0x77,0x78,0x79 "something i2s-related" - default to 0x01080000 on my audigy 2 ZS --rlrevell	*/
 /* 0x7a, 0x7b - lookup tables */
diff -ru alsa-48/alsa-kernel/pci/emu10k1/emumixer.c alsa-old/alsa-kernel/pci/emu10k1/emumixer.c
--- alsa-48/alsa-kernel/pci/emu10k1/emumixer.c	2005-02-06 13:46:51.000000000 -0500
+++ alsa-old/alsa-kernel/pci/emu10k1/emumixer.c	2005-02-06 10:15:04.000000000 -0500
@@ -67,6 +67,92 @@
 	return 0;
 }
 
+static int snd_audigy_spdif_output_rate_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	static char *texts[] = {"44100", "48000", "96000"};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 3;
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_audigy_spdif_output_rate_get(snd_kcontrol_t * kcontrol,
+                                 snd_ctl_elem_value_t * ucontrol)
+{
+	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
+	unsigned int tmp;
+	unsigned long flags;
+	
+
+	spin_lock_irqsave(&emu->reg_lock, flags);
+	tmp = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, 0);
+	switch (tmp & A_SPDIF_RATE_MASK) {
+	case A_SPDIF_44100:
+		ucontrol->value.enumerated.item[0] = 0;
+		break;
+	case A_SPDIF_48000:
+		ucontrol->value.enumerated.item[0] = 1;
+		break;
+	case A_SPDIF_96000:
+		ucontrol->value.enumerated.item[0] = 2;
+		break;
+	default:
+		ucontrol->value.enumerated.item[0] = 1;
+	}
+	spin_unlock_irqrestore(&emu->reg_lock, flags);
+	return 0;
+}
+
+static int snd_audigy_spdif_output_rate_put(snd_kcontrol_t * kcontrol,
+                                 snd_ctl_elem_value_t * ucontrol)
+{
+	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
+	int change;
+	unsigned int reg, val, tmp;
+	unsigned long flags;
+
+	switch(ucontrol->value.enumerated.item[0]) {
+	case 0:
+		val = A_SPDIF_44100;
+		break;
+	case 1:
+		val = A_SPDIF_48000;
+		break;
+	case 2:
+		val = A_SPDIF_96000;
+		break;
+	default:
+		val = A_SPDIF_48000;
+		break;
+	}
+
+	
+	spin_lock_irqsave(&emu->reg_lock, flags);
+	reg = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, 0);
+	tmp = reg & ~A_SPDIF_RATE_MASK;
+	tmp |= val;
+	if (change = (tmp != reg)) {
+		snd_emu10k1_ptr_write(emu, A_SPDIF_SAMPLERATE, 0, tmp);
+	}
+	spin_unlock_irqrestore(&emu->reg_lock, flags);
+	return change;
+}
+
+static snd_kcontrol_new_t snd_audigy_spdif_output_rate =
+{
+	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =         "Audigy SPDIF Output Sample Rate",
+	.count =	1,
+	.info =         snd_audigy_spdif_output_rate_info,
+	.get =          snd_audigy_spdif_output_rate_get,
+	.put =          snd_audigy_spdif_output_rate_put
+};
+
 static int snd_emu10k1_spdif_put(snd_kcontrol_t * kcontrol,
                                  snd_ctl_elem_value_t * ucontrol)
 {
@@ -842,6 +928,10 @@
 			return -ENOMEM;
 		if ((err = snd_ctl_add(card, kctl)))
 			return err;
+		if ((kctl = snd_ctl_new1(&snd_audigy_spdif_output_rate, emu)) == NULL)
+			return -ENOMEM;
+		if ((err = snd_ctl_add(card, kctl)))
+			return err;
 	} else if (! emu->APS) {
 		/* sb live! */
 		if ((kctl = snd_ctl_new1(&snd_emu10k1_shared_spdif, emu)) == NULL)
diff -ru alsa-48/alsa-kernel/pci/emu10k1/emupcm.c alsa-old/alsa-kernel/pci/emu10k1/emupcm.c
--- alsa-48/alsa-kernel/pci/emu10k1/emupcm.c	2005-02-06 13:46:51.000000000 -0500
+++ alsa-old/alsa-kernel/pci/emu10k1/emupcm.c	2005-02-06 13:44:11.000000000 -0500
@@ -946,9 +947,9 @@
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_PAUSE),
 	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
-	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
+	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_96000,
 	.rate_min =		4000,
-	.rate_max =		48000,
+	.rate_max =		96000,
 	.channels_min =		1,
 	.channels_max =		2,
 	.buffer_bytes_max =	(128*1024),




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
