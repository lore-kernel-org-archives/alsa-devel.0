From: Lee Revell <rlrevell@joe-job.com>
Subject: emu10k1 patches for 1.0.11
Date: Fri, 16 Dec 2005 17:17:53 -0500
Message-ID: <1134771473.19091.16.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

These were in my CVS tree.

Add some new PCI IDs.

p16v: Change Unknown to Side channels.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Index: alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.79
diff -u -r1.79 emu10k1_main.c
--- alsa-kernel/pci/emu10k1/emu10k1_main.c	6 Dec 2005 14:10:57 -0000	1.79
+++ alsa-kernel/pci/emu10k1/emu10k1_main.c	16 Dec 2005 22:13:47 -0000
@@ -728,7 +728,17 @@
 	return snd_emu10k1_free(emu);
 }
 
-static struct snd_emu_chip_details emu_chip_details[] = {
+static emu_chip_details_t emu_chip_details[] = {
+	/* Tested by Christian Parpart <trapni at gentoo.org> 10th Dec 2005 */
+	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x10211102,
+	 .driver = "Audigy4", .name = "Audigy 4 64bit [SB0610]", 
+	 .id = "Audigy4",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0151_chip = 1,
+	 .spk71 = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
 	/* Audigy 2 Value AC3 out does not work yet. Need to find out how to turn off interpolators.*/
 	/* Tested by James@superbug.co.uk 3rd July 2005 */
 	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x10011102,
@@ -847,7 +857,7 @@
 	 .spdif_bug = 1,
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x00511102,
-	 .driver = "Audigy", .name = "Audigy 1 [SB0090]", 
+	 .driver = "Audigy", .name = "Audigy 1 Player [SB0090]", 
 	 .id = "Audigy",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
@@ -876,9 +886,16 @@
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
+	/* Tested by Alexandr 25th Nov 2005 */
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80661102,
+	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	/* Tested by Thomas Zehetbauer 27th Aug 2005 */
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80651102,
-	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
+	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0222]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
Index: alsa-kernel/pci/emu10k1/p16v.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/p16v.c,v
retrieving revision 1.15
diff -u -r1.15 p16v.c
--- alsa-kernel/pci/emu10k1/p16v.c	5 Dec 2005 15:12:20 -0000	1.15
+++ alsa-kernel/pci/emu10k1/p16v.c	16 Dec 2005 22:13:52 -0000
@@ -103,15 +103,15 @@
 #include <sound/emu10k1.h>
 #include "p16v.h"
 
-#define SET_CHANNEL 0  /* Testing channel outputs 0=Front, 1=Center/LFE, 2=Unknown, 3=Rear */
+#define SET_CHANNEL 0  /* Testing channel outputs 0=Front, 1=Center/LFE, 2=Side, 3=Rear */
 #define PCM_FRONT_CHANNEL 0
 #define PCM_REAR_CHANNEL 1
 #define PCM_CENTER_LFE_CHANNEL 2
-#define PCM_UNKNOWN_CHANNEL 3
+#define PCM_SIDE_CHANNEL 3
 #define CONTROL_FRONT_CHANNEL 0
 #define CONTROL_REAR_CHANNEL 3
 #define CONTROL_CENTER_LFE_CHANNEL 1
-#define CONTROL_UNKNOWN_CHANNEL 2
+#define CONTROL_SIDE_CHANNEL 2
 
 /* Card IDs:
  * Class 0401: 1102:0004 (rev 04) Subsystem: 1102:2002 -> Audigy2 ZS 7.1 Model:SB0350
@@ -613,8 +613,8 @@
 
 	pcm->info_flags = 0;
 	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
-	strcpy(pcm->name, "p16v");
-	emu->pcm_p16v = pcm;
+	strcpy(pcm->name, "HD Audio (P16V)");
+	emu->pcm = pcm;
 
 	for(substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; 
 	    substream; 
@@ -685,8 +685,8 @@
 	int reg = PLAYBACK_VOLUME_MIXER7;
         return snd_p16v_volume_get(kcontrol, ucontrol, reg, high_low);
 }
-static int snd_p16v_volume_get_spdif_unknown(struct snd_kcontrol *kcontrol,
-                                       struct snd_ctl_elem_value *ucontrol)
+static int snd_p16v_volume_get_spdif_side(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
 {
 	int high_low = 0;
 	int reg = PLAYBACK_VOLUME_MIXER8;
@@ -723,8 +723,8 @@
         return snd_p16v_volume_get(kcontrol, ucontrol, reg, high_low);
 }
 
-static int snd_p16v_volume_get_analog_unknown(struct snd_kcontrol *kcontrol,
-                                       struct snd_ctl_elem_value *ucontrol)
+static int snd_p16v_volume_get_analog_side(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
 {
 	int high_low = 0;
 	int reg = PLAYBACK_VOLUME_MIXER10;
@@ -765,8 +765,8 @@
         return snd_p16v_volume_put(kcontrol, ucontrol, reg, high_low);
 }
 
-static int snd_p16v_volume_put_spdif_unknown(struct snd_kcontrol *kcontrol,
-                                       struct snd_ctl_elem_value *ucontrol)
+static int snd_p16v_volume_put_spdif_side(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
 {
 	int high_low = 0;
 	int reg = PLAYBACK_VOLUME_MIXER8;
@@ -805,8 +805,8 @@
         return snd_p16v_volume_put(kcontrol, ucontrol, reg, high_low);
 }
 
-static int snd_p16v_volume_put_analog_unknown(struct snd_kcontrol *kcontrol,
-                                       struct snd_ctl_elem_value *ucontrol)
+static int snd_p16v_volume_put_analog_side(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
 {
 	int high_low = 0;
 	int reg = PLAYBACK_VOLUME_MIXER10;
@@ -831,13 +831,13 @@
         .put =          snd_p16v_volume_put_analog_center_lfe
 };
 
-static struct snd_kcontrol_new snd_p16v_volume_control_analog_unknown =
+static snd_kcontrol_new_t snd_p16v_volume_control_analog_side =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "HD Analog Unknown Playback Volume",
+        .name =         "HD Analog Side Playback Volume",
         .info =         snd_p16v_volume_info,
-        .get =          snd_p16v_volume_get_analog_unknown,
-        .put =          snd_p16v_volume_put_analog_unknown
+        .get =          snd_p16v_volume_get_analog_side,
+        .put =          snd_p16v_volume_put_analog_side
 };
 
 static struct snd_kcontrol_new snd_p16v_volume_control_analog_rear =
@@ -867,13 +867,13 @@
         .put =          snd_p16v_volume_put_spdif_center_lfe
 };
 
-static struct snd_kcontrol_new snd_p16v_volume_control_spdif_unknown =
+static snd_kcontrol_new_t snd_p16v_volume_control_spdif_side =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "HD SPDIF Unknown Playback Volume",
+        .name =         "HD SPDIF Side Playback Volume",
         .info =         snd_p16v_volume_info,
-        .get =          snd_p16v_volume_get_spdif_unknown,
-        .put =          snd_p16v_volume_put_spdif_unknown
+        .get =          snd_p16v_volume_get_spdif_side,
+        .put =          snd_p16v_volume_put_spdif_side
 };
 
 static struct snd_kcontrol_new snd_p16v_volume_control_spdif_rear =
@@ -1002,7 +1002,7 @@
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = snd_ctl_new1(&snd_p16v_volume_control_analog_unknown, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_p16v_volume_control_analog_side, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
@@ -1018,7 +1018,7 @@
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = snd_ctl_new1(&snd_p16v_volume_control_spdif_unknown, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_p16v_volume_control_spdif_side, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
Index: alsa-kernel/pci/emu10k1/p16v.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/p16v.h,v
retrieving revision 1.1
diff -u -r1.1 p16v.h
--- alsa-kernel/pci/emu10k1/p16v.h	13 Mar 2005 12:17:10 -0000	1.1
+++ alsa-kernel/pci/emu10k1/p16v.h	16 Dec 2005 22:13:54 -0000
@@ -260,7 +260,7 @@
 						 * 0xXXXXXXX2 = PCM0 Right.
 						 * 0xXXXXXXX4 = PCM1 Left. (Center/LFE)
 						 * 0xXXXXXXX8 = PCM1 Right.
-						 * 0xXXXXXX1X = PCM2 Left. (Unknown)
+						 * 0xXXXXXX1X = PCM2 Left. (Side)
 						 * 0xXXXXXX2X = PCM2 Right.
 						 * 0xXXXXXX4X = PCM3 Left. (Rear)
 						 * 0xXXXXXX8X = PCM3 Right.
@@ -278,7 +278,7 @@
 						/* 0 -> Not playback sound, irq still running */
 						/* 0xXXXXXX10 = PCM0 Left/Right On. (Front)
 						 * 0xXXXXXX20 = PCM1 Left/Right On. (Center/LFE)
-						 * 0xXXXXXX40 = PCM2 Left/Right On. (Unknown)
+						 * 0xXXXXXX40 = PCM2 Left/Right On. (Side)
 						 * 0xXXXXXX80 = PCM3 Left/Right On. (Rear)
 						 */
 #define PLAYBACK_SPDIF_SELECT     0x70          /* Default: 12030F00 */




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
