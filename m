From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] SB Live24bit: Adds support for SPDIF in.
Date: Sun, 19 Dec 2004 21:02:11 +0000
Message-ID: <41C5EC53.70809@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040304080707090708010401"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

This is a multi-part message in MIME format.
--------------040304080707090708010401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch against the current CVS adds SPDIF capture for the SB Live 
24bit. It works with the optional external Digital I/O module for the SB 
Live 24bit.

Analogue capture is not yet possible, and I have no idea when it will be 
implemented, as the datasheets I have don't help at all.

James

--------------040304080707090708010401
Content-Type: text/plain;
 name="ca0106-spdif-capture.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ca0106-spdif-capture.diff.txt"

Index: alsa-driver/pci/ca0106/ca0106.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/ca0106/ca0106.h,v
retrieving revision 1.1
diff -u -r1.1 ca0106.h
--- alsa-driver/pci/ca0106/ca0106.h	6 Dec 2004 15:24:28 -0000	1.1
+++ alsa-driver/pci/ca0106/ca0106.h	19 Dec 2004 20:50:26 -0000
@@ -388,7 +388,7 @@
 						 * Host Right volume [23:16]
 						 * Host Left  volume [31:24]
 						 */
-#define CAPTURE_ROUTING1        0x67            /* Playback Routing. Default 0x32765410 */
+#define CAPTURE_ROUTING1        0x67            /* Capture Routing. Default 0x32765410 */
 						/* Similar to register 0x63, except that the destination is the I2S mixer instead of the SPDIF mixer. I.E. Outputs to the Analog outputs instead of SPDIF. */
 #define CAPTURE_ROUTING2        0x68            /* Unknown Routing. Default 0x76767676 */
 						/* Similar to register 0x64, except that the destination is the I2S mixer instead of the SPDIF mixer. I.E. Outputs to the Analog outputs instead of SPDIF. */
@@ -526,8 +526,8 @@
 	ac97_t *ac97;
 	snd_pcm_t *pcm;
 
-	ca0106_channel_t channels[4];
-	ca0106_channel_t capture_channel;
+	ca0106_channel_t playback_channels[4];
+	ca0106_channel_t capture_channels[4];
 	u32 spdif_bits[4];             /* s/pdif out setup */
 	int spdif_enable;
 	int capture_source;
Index: alsa-driver/pci/ca0106/ca0106_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/ca0106/ca0106_main.c,v
retrieving revision 1.1
diff -u -r1.1 ca0106_main.c
--- alsa-driver/pci/ca0106/ca0106_main.c	6 Dec 2004 15:24:28 -0000	1.1
+++ alsa-driver/pci/ca0106/ca0106_main.c	19 Dec 2004 20:50:26 -0000
@@ -1,7 +1,7 @@
 /*
  *  Copyright (c) 2004 James Courtier-Dutton <James@superbug.demon.co.uk>
  *  Driver CA0106 chips. e.g. Sound Blaster Audigy LS and Live 24bit
- *  Version: 0.0.20
+ *  Version: 0.0.21
  *
  *  FEATURES currently supported:
  *    Front, Rear and Center/LFE.
@@ -72,6 +72,9 @@
  *    The output codec needs resetting, otherwise all output is muted.
  *  0.0.20
  *    Merge "pci_disable_device(pci);" fixes.
+ *  0.0.21
+ *    Add 4 capture channels. (SPDIF only comes in on channel 0. )
+ *    Add SPDIF capture using optional digital I/O module for SB Live 24bit. (Analog capture does not yet work.)
  *
  *  BUGS:
  *    Some stability problems when unloading the snd-ca0106 kernel module.
@@ -263,7 +266,7 @@
 static int snd_ca0106_pcm_open_playback_channel(snd_pcm_substream_t *substream, int channel_id)
 {
 	ca0106_t *chip = snd_pcm_substream_chip(substream);
-        ca0106_channel_t *channel = &(chip->channels[channel_id]);
+        ca0106_channel_t *channel = &(chip->playback_channels[channel_id]);
 	ca0106_pcm_t *epcm;
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
@@ -301,7 +304,7 @@
 	ca0106_t *chip = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
         ca0106_pcm_t *epcm = runtime->private_data;
-        chip->channels[epcm->channel_id].use=0;
+        chip->playback_channels[epcm->channel_id].use=0;
 /* FIXME: maybe zero others */
 	return 0;
 }
@@ -330,7 +333,7 @@
 static int snd_ca0106_pcm_open_capture_channel(snd_pcm_substream_t *substream, int channel_id)
 {
 	ca0106_t *chip = snd_pcm_substream_chip(substream);
-        ca0106_channel_t *channel = &(chip->capture_channel);
+        ca0106_channel_t *channel = &(chip->capture_channels[channel_id]);
 	ca0106_pcm_t *epcm;
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
@@ -368,18 +371,33 @@
 static int snd_ca0106_pcm_close_capture(snd_pcm_substream_t *substream)
 {
 	ca0106_t *chip = snd_pcm_substream_chip(substream);
-	//snd_pcm_runtime_t *runtime = substream->runtime;
-        //ca0106_pcm_t *epcm = runtime->private_data;
-        chip->capture_channel.use=0;
+	snd_pcm_runtime_t *runtime = substream->runtime;
+        ca0106_pcm_t *epcm = runtime->private_data;
+        chip->capture_channels[epcm->channel_id].use=0;
 /* FIXME: maybe zero others */
 	return 0;
 }
 
-static int snd_ca0106_pcm_open_capture(snd_pcm_substream_t *substream)
+static int snd_ca0106_pcm_open_0_capture(snd_pcm_substream_t *substream)
 {
 	return snd_ca0106_pcm_open_capture_channel(substream, 0);
 }
 
+static int snd_ca0106_pcm_open_1_capture(snd_pcm_substream_t *substream)
+{
+	return snd_ca0106_pcm_open_capture_channel(substream, 1);
+}
+
+static int snd_ca0106_pcm_open_2_capture(snd_pcm_substream_t *substream)
+{
+	return snd_ca0106_pcm_open_capture_channel(substream, 2);
+}
+
+static int snd_ca0106_pcm_open_3_capture(snd_pcm_substream_t *substream)
+{
+	return snd_ca0106_pcm_open_capture_channel(substream, 3);
+}
+
 /* hw_params callback */
 static int snd_ca0106_pcm_hw_params_playback(snd_pcm_substream_t *substream,
 				      snd_pcm_hw_params_t * hw_params)
@@ -666,8 +684,41 @@
 	.pointer =     snd_ca0106_pcm_pointer_playback,
 };
 
-static snd_pcm_ops_t snd_ca0106_capture_ops = {
-	.open =        snd_ca0106_pcm_open_capture,
+static snd_pcm_ops_t snd_ca0106_capture_0_ops = {
+	.open =        snd_ca0106_pcm_open_0_capture,
+	.close =       snd_ca0106_pcm_close_capture,
+	.ioctl =       snd_pcm_lib_ioctl,
+	.hw_params =   snd_ca0106_pcm_hw_params_capture,
+	.hw_free =     snd_ca0106_pcm_hw_free_capture,
+	.prepare =     snd_ca0106_pcm_prepare_capture,
+	.trigger =     snd_ca0106_pcm_trigger_capture,
+	.pointer =     snd_ca0106_pcm_pointer_capture,
+};
+
+static snd_pcm_ops_t snd_ca0106_capture_1_ops = {
+	.open =        snd_ca0106_pcm_open_1_capture,
+	.close =       snd_ca0106_pcm_close_capture,
+	.ioctl =       snd_pcm_lib_ioctl,
+	.hw_params =   snd_ca0106_pcm_hw_params_capture,
+	.hw_free =     snd_ca0106_pcm_hw_free_capture,
+	.prepare =     snd_ca0106_pcm_prepare_capture,
+	.trigger =     snd_ca0106_pcm_trigger_capture,
+	.pointer =     snd_ca0106_pcm_pointer_capture,
+};
+
+static snd_pcm_ops_t snd_ca0106_capture_2_ops = {
+	.open =        snd_ca0106_pcm_open_2_capture,
+	.close =       snd_ca0106_pcm_close_capture,
+	.ioctl =       snd_pcm_lib_ioctl,
+	.hw_params =   snd_ca0106_pcm_hw_params_capture,
+	.hw_free =     snd_ca0106_pcm_hw_free_capture,
+	.prepare =     snd_ca0106_pcm_prepare_capture,
+	.trigger =     snd_ca0106_pcm_trigger_capture,
+	.pointer =     snd_ca0106_pcm_pointer_capture,
+};
+
+static snd_pcm_ops_t snd_ca0106_capture_3_ops = {
+	.open =        snd_ca0106_pcm_open_3_capture,
 	.close =       snd_ca0106_pcm_close_capture,
 	.ioctl =       snd_pcm_lib_ioctl,
 	.hw_params =   snd_ca0106_pcm_hw_params_capture,
@@ -821,7 +872,21 @@
 	//snd_printk("ptr=0x%08x\n",snd_ca0106_ptr_read(chip, PLAYBACK_POINTER, 0));
         mask = 0x11; /* 0x1 for one half, 0x10 for the other half period. */
 	for(i = 0; i < 4; i++) {
-		pchannel = &(chip->channels[i]);
+		pchannel = &(chip->playback_channels[i]);
+		if(stat76 & mask) {
+/* FIXME: Select the correct substream for period elapsed */
+			if(pchannel->use) {
+                          snd_pcm_period_elapsed(pchannel->epcm->substream);
+	                //printk(KERN_INFO "interrupt [%d] used\n", i);
+                        }
+		}
+	        //printk(KERN_INFO "channel=%p\n",pchannel);
+	        //printk(KERN_INFO "interrupt stat76[%d] = %08x, use=%d, channel=%d\n", i, stat76, pchannel->use, pchannel->number);
+		mask <<= 1;
+	}
+        mask = 0x110000; /* 0x1 for one half, 0x10 for the other half period. */
+	for(i = 0; i < 4; i++) {
+		pchannel = &(chip->capture_channels[i]);
 		if(stat76 & mask) {
 /* FIXME: Select the correct substream for period elapsed */
 			if(pchannel->use) {
@@ -833,11 +898,6 @@
 	        //printk(KERN_INFO "interrupt stat76[%d] = %08x, use=%d, channel=%d\n", i, stat76, pchannel->use, pchannel->number);
 		mask <<= 1;
 	}
-	if(stat76 & 0x110000) {
-		if(chip->capture_channel.use) {
-                  snd_pcm_period_elapsed(chip->capture_channel.epcm->substream);
-                }
-        }
 
         snd_ca0106_ptr_write(chip, EXTENDED_INT, 0, stat76);
 	spin_lock(&chip->emu_lock);
@@ -861,12 +921,10 @@
 	snd_pcm_t *pcm;
 	snd_pcm_substream_t *substream;
 	int err;
-        int capture=0;
   
 	if (rpcm)
 		*rpcm = NULL;
-        if (device == 0) capture=1; 
-	if ((err = snd_pcm_new(emu->card, "ca0106", device, 1, capture, &pcm)) < 0)
+	if ((err = snd_pcm_new(emu->card, "ca0106", device, 1, 1, &pcm)) < 0)
 		return err;
   
 	pcm->private_data = emu;
@@ -875,16 +933,19 @@
 	switch (device) {
 	case 0:
 	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_ca0106_playback_front_ops);
-	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ca0106_capture_ops);
+	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ca0106_capture_0_ops);
           break;
 	case 1:
 	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_ca0106_playback_rear_ops);
+	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ca0106_capture_1_ops);
           break;
 	case 2:
 	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_ca0106_playback_center_lfe_ops);
+	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ca0106_capture_2_ops);
           break;
 	case 3:
 	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_ca0106_playback_unknown_ops);
+	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ca0106_capture_3_ops);
           break;
         }
 
Index: alsa-driver/pci/ca0106/ca0106_mixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/ca0106/ca0106_mixer.c,v
retrieving revision 1.1
diff -u -r1.1 ca0106_mixer.c
--- alsa-driver/pci/ca0106/ca0106_mixer.c	6 Dec 2004 15:24:28 -0000	1.1
+++ alsa-driver/pci/ca0106/ca0106_mixer.c	19 Dec 2004 20:50:26 -0000
@@ -134,13 +134,13 @@
 
 static int snd_ca0106_capture_source_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
-	static char *texts[4] = { "SPDIF", "What U Hear", "Unknown", "AC97" };
+	static char *texts[6] = { "SPDIF out", "i2s mixer out", "SPDIF in", "i2s in", "AC97 in", "SRC out" };
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item > 3)
-                uinfo->value.enumerated.item = 3;
+	uinfo->value.enumerated.items = 6;
+	if (uinfo->value.enumerated.item > 5)
+                uinfo->value.enumerated.item = 5;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
 	return 0;
 }
Index: alsa-driver/pci/ca0106/ca0106_proc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/ca0106/ca0106_proc.c,v
retrieving revision 1.1
diff -u -r1.1 ca0106_proc.c
--- alsa-driver/pci/ca0106/ca0106_proc.c	6 Dec 2004 15:24:28 -0000	1.1
+++ alsa-driver/pci/ca0106/ca0106_proc.c	19 Dec 2004 20:50:27 -0000
@@ -1,7 +1,7 @@
 /*
  *  Copyright (c) 2004 James Courtier-Dutton <James@superbug.demon.co.uk>
  *  Driver CA0106 chips. e.g. Sound Blaster Audigy LS and Live 24bit
- *  Version: 0.0.16
+ *  Version: 0.0.17
  *
  *  FEATURES currently supported:
  *    See ca0106_main.c for features.
@@ -37,7 +37,9 @@
  *    Separate ca0106.c into separate functional .c files.
  *  0.0.16
  *    Modified Copyright message.
- *
+ *  0.0.17
+ *    Add iec958 file in proc file system to show status of SPDIF in.
+ *    
  *  This code was initally based on code from ALSA's emu10k1x.c which is:
  *  Copyright (c) by Francisco Moraes <fmoraes@nc.rr.com>
  *
@@ -68,9 +70,227 @@
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
+#include <sound/asoundef.h>
 
 #include "ca0106.h"
 
+
+struct snd_ca0106_category_str {
+	int val;
+	const char *name;
+};
+
+static struct snd_ca0106_category_str snd_ca0106_con_category[] = {
+	{ IEC958_AES1_CON_DAT, "DAT" },
+	{ IEC958_AES1_CON_VCR, "VCR" },
+	{ IEC958_AES1_CON_MICROPHONE, "microphone" },
+	{ IEC958_AES1_CON_SYNTHESIZER, "synthesizer" },
+	{ IEC958_AES1_CON_RATE_CONVERTER, "rate converter" },
+	{ IEC958_AES1_CON_MIXER, "mixer" },
+	{ IEC958_AES1_CON_SAMPLER, "sampler" },
+	{ IEC958_AES1_CON_PCM_CODER, "PCM coder" },
+	{ IEC958_AES1_CON_IEC908_CD, "CD" },
+	{ IEC958_AES1_CON_NON_IEC908_CD, "non-IEC908 CD" },
+	{ IEC958_AES1_CON_GENERAL, "general" },
+};
+
+
+void snd_ca0106_proc_dump_iec958( snd_info_buffer_t *buffer, u32 value)
+{
+	int i;
+	u32 status[4];
+	status[0] = value & 0xff;
+	status[1] = (value >> 8) & 0xff;
+	status[2] = (value >> 16)  & 0xff;
+	status[3] = (value >> 24)  & 0xff;
+	
+	if (! (status[0] & IEC958_AES0_PROFESSIONAL)) {
+		/* consumer */
+		snd_iprintf(buffer, "Mode: consumer\n");
+		snd_iprintf(buffer, "Data: ");
+		if (!(status[0] & IEC958_AES0_NONAUDIO)) {
+			snd_iprintf(buffer, "audio\n");
+		} else {
+			snd_iprintf(buffer, "non-audio\n");
+		}
+		snd_iprintf(buffer, "Rate: ");
+		switch (status[3] & IEC958_AES3_CON_FS) {
+		case IEC958_AES3_CON_FS_44100:
+			snd_iprintf(buffer, "44100 Hz\n");
+			break;
+		case IEC958_AES3_CON_FS_48000:
+			snd_iprintf(buffer, "48000 Hz\n");
+			break;
+		case IEC958_AES3_CON_FS_32000:
+			snd_iprintf(buffer, "32000 Hz\n");
+			break;
+		default:
+			snd_iprintf(buffer, "unknown\n");
+			break;
+		}
+		snd_iprintf(buffer, "Copyright: ");
+		if (status[0] & IEC958_AES0_CON_NOT_COPYRIGHT) {
+			snd_iprintf(buffer, "permitted\n");
+		} else {
+			snd_iprintf(buffer, "protected\n");
+		}
+		snd_iprintf(buffer, "Emphasis: ");
+		if ((status[0] & IEC958_AES0_CON_EMPHASIS) != IEC958_AES0_CON_EMPHASIS_5015) {
+			snd_iprintf(buffer, "none\n");
+		} else {
+			snd_iprintf(buffer, "50/15us\n");
+		}
+		snd_iprintf(buffer, "Category: ");
+		for (i = 0; i < ARRAY_SIZE(snd_ca0106_con_category); i++) {
+			if ((status[1] & IEC958_AES1_CON_CATEGORY) == snd_ca0106_con_category[i].val) {
+				snd_iprintf(buffer, "%s\n", snd_ca0106_con_category[i].name);
+				break;
+			}
+		}
+		if (i >= ARRAY_SIZE(snd_ca0106_con_category)) {
+			snd_iprintf(buffer, "unknown 0x%x\n", status[1] & IEC958_AES1_CON_CATEGORY);
+		}
+		snd_iprintf(buffer, "Original: ");
+		if (status[1] & IEC958_AES1_CON_ORIGINAL) {
+			snd_iprintf(buffer, "original\n");
+		} else {
+			snd_iprintf(buffer, "1st generation\n");
+		}
+		snd_iprintf(buffer, "Clock: ");
+		switch (status[3] & IEC958_AES3_CON_CLOCK) {
+		case IEC958_AES3_CON_CLOCK_1000PPM:
+			snd_iprintf(buffer, "1000 ppm\n");
+			break;
+		case IEC958_AES3_CON_CLOCK_50PPM:
+			snd_iprintf(buffer, "50 ppm\n");
+			break;
+		case IEC958_AES3_CON_CLOCK_VARIABLE:
+			snd_iprintf(buffer, "variable pitch\n");
+			break;
+		default:
+			snd_iprintf(buffer, "unknown\n");
+			break;
+		}
+	} else {
+		snd_iprintf(buffer, "Mode: professional\n");
+		snd_iprintf(buffer, "Data: ");
+		if (!(status[0] & IEC958_AES0_NONAUDIO)) {
+			snd_iprintf(buffer, "audio\n");
+		} else {
+			snd_iprintf(buffer, "non-audio\n");
+		}
+		snd_iprintf(buffer, "Rate: ");
+		switch (status[0] & IEC958_AES0_PRO_FS) {
+		case IEC958_AES0_PRO_FS_44100:
+			snd_iprintf(buffer, "44100 Hz\n");
+			break;
+		case IEC958_AES0_PRO_FS_48000:
+			snd_iprintf(buffer, "48000 Hz\n");
+			break;
+		case IEC958_AES0_PRO_FS_32000:
+			snd_iprintf(buffer, "32000 Hz\n");
+			break;
+		default:
+			snd_iprintf(buffer, "unknown\n");
+			break;
+		}
+		snd_iprintf(buffer, "Rate Locked: ");
+		if (status[0] & IEC958_AES0_PRO_FREQ_UNLOCKED)
+			snd_iprintf(buffer, "no\n");
+		else
+			snd_iprintf(buffer, "yes\n");
+		snd_iprintf(buffer, "Emphasis: ");
+		switch (status[0] & IEC958_AES0_PRO_EMPHASIS) {
+		case IEC958_AES0_PRO_EMPHASIS_CCITT:
+			snd_iprintf(buffer, "CCITT J.17\n");
+			break;
+		case IEC958_AES0_PRO_EMPHASIS_NONE:
+			snd_iprintf(buffer, "none\n");
+			break;
+		case IEC958_AES0_PRO_EMPHASIS_5015:
+			snd_iprintf(buffer, "50/15us\n");
+			break;
+		case IEC958_AES0_PRO_EMPHASIS_NOTID:
+		default:
+			snd_iprintf(buffer, "unknown\n");
+			break;
+		}
+		snd_iprintf(buffer, "Stereophonic: ");
+		if ((status[1] & IEC958_AES1_PRO_MODE) == IEC958_AES1_PRO_MODE_STEREOPHONIC) {
+			snd_iprintf(buffer, "stereo\n");
+		} else {
+			snd_iprintf(buffer, "not indicated\n");
+		}
+		snd_iprintf(buffer, "Userbits: ");
+		switch (status[1] & IEC958_AES1_PRO_USERBITS) {
+		case IEC958_AES1_PRO_USERBITS_192:
+			snd_iprintf(buffer, "192bit\n");
+			break;
+		case IEC958_AES1_PRO_USERBITS_UDEF:
+			snd_iprintf(buffer, "user-defined\n");
+			break;
+		default:
+			snd_iprintf(buffer, "unkown\n");
+			break;
+		}
+		snd_iprintf(buffer, "Sample Bits: ");
+		switch (status[2] & IEC958_AES2_PRO_SBITS) {
+		case IEC958_AES2_PRO_SBITS_20:
+			snd_iprintf(buffer, "20 bit\n");
+			break;
+		case IEC958_AES2_PRO_SBITS_24:
+			snd_iprintf(buffer, "24 bit\n");
+			break;
+		case IEC958_AES2_PRO_SBITS_UDEF:
+			snd_iprintf(buffer, "user defined\n");
+			break;
+		default:
+			snd_iprintf(buffer, "unknown\n");
+			break;
+		}
+		snd_iprintf(buffer, "Word Length: ");
+		switch (status[2] & IEC958_AES2_PRO_WORDLEN) {
+		case IEC958_AES2_PRO_WORDLEN_22_18:
+			snd_iprintf(buffer, "22 bit or 18 bit\n");
+			break;
+		case IEC958_AES2_PRO_WORDLEN_23_19:
+			snd_iprintf(buffer, "23 bit or 19 bit\n");
+			break;
+		case IEC958_AES2_PRO_WORDLEN_24_20:
+			snd_iprintf(buffer, "24 bit or 20 bit\n");
+			break;
+		case IEC958_AES2_PRO_WORDLEN_20_16:
+			snd_iprintf(buffer, "20 bit or 16 bit\n");
+			break;
+		default:
+			snd_iprintf(buffer, "unknown\n");
+			break;
+		}
+	}
+}
+
+static void snd_ca0106_proc_iec958(snd_info_entry_t *entry, 
+				       snd_info_buffer_t * buffer)
+{
+	ca0106_t *emu = entry->private_data;
+	u32 value;
+
+        value = snd_ca0106_ptr_read(emu, SAMPLE_RATE_TRACKER_STATUS, 0);
+	snd_iprintf(buffer, "Status: %s, %s, %s\n",
+		  (value & 0x100000) ? "Rate Locked" : "Not Rate Locked",
+		  (value & 0x200000) ? "SPDIF Locked" : "No SPDIF Lock",
+		  (value & 0x400000) ? "Audio Valid" : "No valid audio" );
+	snd_iprintf(buffer, "Estimated sample rate: %u\n", 
+		  ((value & 0xfffff) * 48000) / 0x8000 );
+	if (value & 0x200000) {
+		snd_iprintf(buffer, "IEC958/SPDIF input status:\n");
+        	value = snd_ca0106_ptr_read(emu, SPDIF_INPUT_STATUS, 0);
+		snd_ca0106_proc_dump_iec958(buffer, value);
+	}
+
+	snd_iprintf(buffer, "\n");
+}
+
 static void snd_ca0106_proc_reg_write32(snd_info_entry_t *entry, 
 				       snd_info_buffer_t * buffer)
 {
@@ -192,6 +412,8 @@
 {
 	snd_info_entry_t *entry;
 	
+	if(! snd_card_proc_new(emu->card, "iec958", &entry))
+		snd_info_set_text_ops(entry, emu, 1024, snd_ca0106_proc_iec958);
 	if(! snd_card_proc_new(emu->card, "ca0106_reg32", &entry)) {
 		snd_info_set_text_ops(entry, emu, 1024, snd_ca0106_proc_reg_read32);
 		entry->c.text.write_size = 64;

--------------040304080707090708010401--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
