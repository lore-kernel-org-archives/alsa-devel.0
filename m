From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: ice712 -set mpu401 info flags from card info, patch
Date: Wed, 24 May 2006 22:35:31 +0100
Message-ID: <200605242235.31408.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jGNdEqPHQUqp442"
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_jGNdEqPHQUqp442
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Following your recent addition of mpu401 info flags, patch to set additional 
flags from snd_ice1712_card_info.

For my ease I moved  #include <sound/mpu401.h>  from ice1712.c to ice1712.h so 
that the flags definition is available to all vendor specific code files 
(such as ews.c) without duplicating the include in each one.  Please advise 
if you have a different preference.

Alan


Summary: in ice1712, set mpu401 info flags from _card_info

To permit use, in ice1712, of the mpu401 info flags recently added to 
mpu401_uart, adds info_flags in snd_ice1712_card_info so that additional 
flags can be set, if desired.  'MPU401_INFO_INTEGRATED' is always set with 
the ice1712.  The flags are passed on to snd_mpu401_uart_new().  _INFO_OUTPUT 
is set for DMX6fire mpu2.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_jGNdEqPHQUqp442
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ice1712-mpu401-infoflags.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ice1712-mpu401-infoflags.patch"

diff -ru alsa-driver-1.0.11-18.05.06/alsa-kernel/pci/ice1712/ews.c alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ews.c
--- alsa-driver-1.0.11-18.05.06/alsa-kernel/pci/ice1712/ews.c	2006-04-26 11:10:58.000000000 +0100
+++ alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ews.c	2006-05-24 11:43:53.000000000 +0100
@@ -1033,6 +1033,7 @@
 		.build_controls = snd_ice1712_ews_add_controls,
 		.mpu401_1_name = "MIDI-Front DMX6fire",
 		.mpu401_2_name = "Wavetable DMX6fire",
+		.mpu401_2_info_flags = MPU401_INFO_OUTPUT,
 	},
 	{ } /* terminator */
 };
diff -ru alsa-driver-1.0.11-18.05.06/alsa-kernel/pci/ice1712/ice1712.c alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ice1712.c
--- alsa-driver-1.0.11-18.05.06/alsa-kernel/pci/ice1712/ice1712.c	2006-04-26 11:10:58.000000000 +0100
+++ alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ice1712.c	2006-05-24 14:45:08.000000000 +0100
@@ -61,7 +61,6 @@
 #include <sound/core.h>
 #include <sound/cs8427.h>
 #include <sound/info.h>
-#include <sound/mpu401.h>
 #include <sound/initval.h>

 #include <sound/asoundef.h>
@@ -2736,9 +2737,10 @@
 		}

 	if (! c->no_mpu401) {
+		c->mpu401_1_info_flags |= MPU401_INFO_INTEGRATED;
 		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ICE1712,
-					       ICEREG(ice, MPU1_CTRL),
-					       MPU401_INFO_INTEGRATED,
+					       ICEREG(ice, MPU1_CTRL),
+					       c->mpu401_1_info_flags,
 					       ice->irq, 0,
 					       &ice->rmidi[0])) < 0) {
 			snd_card_free(card);
@@ -2748,9 +2751,10 @@
 						"%s %d", c->mpu401_1_name, card->number);
 
 		if (ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_2xMPU401) {  /*  2nd port used  */
+			c->mpu401_2_info_flags |= MPU401_INFO_INTEGRATED;
 			if ((err = snd_mpu401_uart_new(card, 1, MPU401_HW_ICE1712,
-						       ICEREG(ice, MPU2_CTRL),
-						       MPU401_INFO_INTEGRATED,
+						       ICEREG(ice, MPU2_CTRL),
+						       c->mpu401_2_info_flags,
 						       ice->irq, 0,
 						       &ice->rmidi[1])) < 0) {
 				snd_card_free(card);
diff -ru alsa-driver-1.0.11-18.05.06/alsa-kernel/pci/ice1712/ice1712.h alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ice1712.h
--- alsa-driver-1.0.11-18.05.06/alsa-kernel/pci/ice1712/ice1712.h	2006-04-26 11:10:58.000000000 +0100
+++ alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ice1712.h	2006-05-24 14:34:21.000000000 +0100
@@ -29,6 +29,7 @@
 #include <sound/ak4xxx-adda.h>
 #include <sound/ak4114.h>
 #include <sound/pcm.h>
+#include <sound/mpu401.h>
 
 
 /*
@@ -495,6 +496,8 @@
 	int (*chip_init)(struct snd_ice1712 *);
 	int (*build_controls)(struct snd_ice1712 *);
 	unsigned int no_mpu401: 1;
+	unsigned int mpu401_1_info_flags;
+	unsigned int mpu401_2_info_flags;
 	const char *mpu401_1_name;
 	const char *mpu401_2_name;
 	unsigned int eeprom_size;

--Boundary-00=_jGNdEqPHQUqp442--



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
