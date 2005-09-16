From: Lee Revell <rlrevell@joe-job.com>
Subject: P16V cleanups
Date: Thu, 15 Sep 2005 22:47:57 -0400
Message-ID: <1126838878.4986.29.camel@mindpipe>
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
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

James,

This patch renames the unknown PCM (PCM2) to "Side" as I'm almost
certain this is what it is.  It also gives the P16V PCM a better name,
"HD Audio (P16V)" rather than "p16v".

This makes the naming consistent with the user-friendly names I gave the
other devices, among other things this makes the device selection menu
in XMMS much more intuitive.

This patch is 100% cosmetic with no changes to the logic.  It does
rename two mixer controls so will cause alsactl warnings.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Index: alsa/alsa-kernel/pci/emu10k1/p16v.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/p16v.c,v
retrieving revision 1.10
diff -u -r1.10 p16v.c
--- alsa/alsa-kernel/pci/emu10k1/p16v.c	9 Sep 2005 13:21:46 -0000	1.10
+++ alsa/alsa-kernel/pci/emu10k1/p16v.c	16 Sep 2005 02:45:12 -0000
@@ -102,15 +102,15 @@
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
@@ -619,7 +619,7 @@
 
 	pcm->info_flags = 0;
 	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
-	strcpy(pcm->name, "p16v");
+	strcpy(pcm->name, "HD Audio (P16V)");
 	emu->pcm = pcm;
 
 	for(substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; 
@@ -691,7 +691,7 @@
 	int reg = PLAYBACK_VOLUME_MIXER7;
         return snd_p16v_volume_get(kcontrol, ucontrol, reg, high_low);
 }
-static int snd_p16v_volume_get_spdif_unknown(snd_kcontrol_t * kcontrol,
+static int snd_p16v_volume_get_spdif_side(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
 	int high_low = 0;
@@ -729,7 +729,7 @@
         return snd_p16v_volume_get(kcontrol, ucontrol, reg, high_low);
 }
 
-static int snd_p16v_volume_get_analog_unknown(snd_kcontrol_t * kcontrol,
+static int snd_p16v_volume_get_analog_side(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
 	int high_low = 0;
@@ -771,7 +771,7 @@
         return snd_p16v_volume_put(kcontrol, ucontrol, reg, high_low);
 }
 
-static int snd_p16v_volume_put_spdif_unknown(snd_kcontrol_t * kcontrol,
+static int snd_p16v_volume_put_spdif_side(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
 	int high_low = 0;
@@ -811,7 +811,7 @@
         return snd_p16v_volume_put(kcontrol, ucontrol, reg, high_low);
 }
 
-static int snd_p16v_volume_put_analog_unknown(snd_kcontrol_t * kcontrol,
+static int snd_p16v_volume_put_analog_side(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
 	int high_low = 0;
@@ -837,13 +837,13 @@
         .put =          snd_p16v_volume_put_analog_center_lfe
 };
 
-static snd_kcontrol_new_t snd_p16v_volume_control_analog_unknown =
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
 
 static snd_kcontrol_new_t snd_p16v_volume_control_analog_rear =
@@ -873,13 +873,13 @@
         .put =          snd_p16v_volume_put_spdif_center_lfe
 };
 
-static snd_kcontrol_new_t snd_p16v_volume_control_spdif_unknown =
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
 
 static snd_kcontrol_new_t snd_p16v_volume_control_spdif_rear =
@@ -1008,7 +1008,7 @@
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = snd_ctl_new1(&snd_p16v_volume_control_analog_unknown, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_p16v_volume_control_analog_side, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
@@ -1024,7 +1024,7 @@
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = snd_ctl_new1(&snd_p16v_volume_control_spdif_unknown, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_p16v_volume_control_spdif_side, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
Index: alsa/alsa-kernel/pci/emu10k1/p16v.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/p16v.h,v
retrieving revision 1.1
diff -u -r1.1 p16v.h
--- alsa/alsa-kernel/pci/emu10k1/p16v.h	13 Mar 2005 12:17:10 -0000	1.1
+++ alsa/alsa-kernel/pci/emu10k1/p16v.h	16 Sep 2005 02:45:12 -0000
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
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
