From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Midi name string in mpu401_uart not unique
Date: Wed, 29 Mar 2006 23:20:54 +0100
Message-ID: <200603292313.21160.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GhwKED6htib24RV"
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


--Boundary-00=_GhwKED6htib24RV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

For a card with ->shortname, snd_mpu401_uart_new creates the same string for 
all ports on all cards of same type.  Muse, eg, is unable to distinguish 
them, and cannot use the second port.  As a result, I thought wavetable midi 
on DMX6fire was broken, but some patching solved this. :-)

That set me thinking that really the card driver should be able to pass this 
string to mpu401_uart_new to describe the ports actual use.  It also seems to 
me that however created the string should be unique, and also that the early 
characters are the most useful in a sequencer window; I don't need the 
manufacturer at all -just the model will do.

I have patched one solution, adding a parameter to mpu401_uart_new.  Then 
ice1712 (in my case) generates this string either explicitly from 
snd_ice1712_card_info or from model string, adding card & device numbers.  
Diff is attached.

What do you think?  There must be other ways to achieve this also.  This diff 
is just a starting point;  I've included the 'NULL' parameter just in au88x0 
as it is my other card.

With these changes Muse shows 'MIDI-Front DMX6fire 0-0' and 'Wavetable 
DMX6fire 0-1' which (of course) suits me just fine!  Wavetable daughter card 
now runs great!

Regards   Alan





--Boundary-00=_GhwKED6htib24RV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mpu-names.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mpu-names.diff"

diff -ru ../alsa-driver-orig-1.0.11rc3/alsa-kernel/drivers/mpu401/mpu401_uart.c ../alsa-driver-1.0.11rc3/alsa-kernel/drivers/mpu401/mpu401_uart.c
--- ../alsa-driver-orig-1.0.11rc3/alsa-kernel/drivers/mpu401/mpu401_uart.c	2005-11-18 18:52:14.000000000 +0000
+++ ../alsa-driver-1.0.11rc3/alsa-kernel/drivers/mpu401/mpu401_uart.c	2006-03-29 21:36:42.000000000 +0100
@@ -451,7 +451,8 @@
 			unsigned short hardware,
 			unsigned long port, int integrated,
 			int irq, int irq_flags,
-			struct snd_rawmidi ** rrawmidi)
+			struct snd_rawmidi ** rrawmidi,
+			char *midiportname)
 {
 	struct snd_mpu401 *mpu;
 	struct snd_rawmidi *rmidi;
@@ -505,10 +506,16 @@
 	}
 	mpu->irq = irq;
 	mpu->irq_flags = irq_flags;
-	if (card->shortname[0])
-		snprintf(rmidi->name, sizeof(rmidi->name), "%s MIDI", card->shortname);
-	else
-		sprintf(rmidi->name, "MPU-401 MIDI %d-%d", card->number, device);
+
+	if (midiportname != NULL) {
+		snprintf(rmidi->name, sizeof(rmidi->name), "%s", midiportname);
+	} else {
+		if (card->shortname[0]) {
+			snprintf(rmidi->name, sizeof(rmidi->name), "MIDI %d-%d %s", card->number, device , card->shortname);
+		} else {
+			sprintf(rmidi->name, "MPU-401 MIDI %d-%d", card->number, device);
+		}
+	}
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &snd_mpu401_uart_output);
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &snd_mpu401_uart_input);
 	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT |
diff -ru ../alsa-driver-orig-1.0.11rc3/alsa-kernel/include/mpu401.h ../alsa-driver-1.0.11rc3/alsa-kernel/include/mpu401.h
--- ../alsa-driver-orig-1.0.11rc3/alsa-kernel/include/mpu401.h	2005-11-17 14:12:45.000000000 +0000
+++ ../alsa-driver-1.0.11rc3/alsa-kernel/include/mpu401.h	2006-03-26 22:38:39.000000000 +0100
@@ -108,6 +108,7 @@
 			int integrated,
 			int irq,
 			int irq_flags,
-			struct snd_rawmidi ** rrawmidi);
+			struct snd_rawmidi ** rrawmidi,
+			char *midiportname);

 #endif /* __SOUND_MPU401_H */
diff -ru ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0_mpu401.c ../alsa-driver-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0_mpu401.c
--- ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0_mpu401.c	2006-01-13 17:16:29.000000000 +0000
+++ ../alsa-driver-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0_mpu401.c	2006-03-26 22:41:52.000000000 +0100
@@ -98,7 +98,7 @@
 	port = (unsigned long)(vortex->mmio + VORTEX_MIDI_DATA);
 	if ((temp =
 	     snd_mpu401_uart_new(vortex->card, 0, MPU401_HW_AUREAL, port,
-				 1, 0, 0, &rmidi)) != 0) {
+				 1, 0, 0, &rmidi, NULL)) != 0) {
 		hwwrite(vortex->mmio, VORTEX_CTRL,
 			(hwread(vortex->mmio, VORTEX_CTRL) &
 			 ~CTRL_MIDI_PORT) & ~CTRL_MIDI_EN);
diff -ru ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ews.c ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ews.c
--- ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ews.c	2005-11-22 14:33:27.000000000 +0000
+++ ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ews.c	2006-03-29 14:09:23.000000000 +0100
@@ -1031,6 +1031,8 @@
 		.model = "dmx6fire",
 		.chip_init = snd_ice1712_ews_init,
 		.build_controls = snd_ice1712_ews_add_controls,
+		.mpu401_1_name = "MIDI-Front DMX6fire",
+		.mpu401_2_name = "Wavetable DMX6fire",
 	},
 	{ } /* terminator */
 };
diff -ru ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.c ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.c
--- ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.c	2006-01-16 16:34:25.000000000 +0000
+++ ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.c	2006-03-29 22:26:10.000000000 +0100
@@ -2643,6 +2660,8 @@
 	struct snd_ice1712 *ice;
 	int pcm_dev = 0, err;
 	struct snd_ice1712_card_info **tbl, *c;
+	char port_name[24];
+	int midevice;

 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
@@ -2718,21 +2738,34 @@
 		}

 	if (! c->no_mpu401) {
-		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ICE1712,
+		midevice = 0;
+		if (c->mpu401_1_name != NULL)
+			snprintf(port_name, sizeof(port_name), "%s %d-%d", c->mpu401_1_name, card->number, midevice);
+		else
+			snprintf(port_name, sizeof(port_name), "MIDI 1 %s %d-%d", c->model, card->number, midevice);
+
+		if ((err = snd_mpu401_uart_new(card, midevice, MPU401_HW_ICE1712,
 					       ICEREG(ice, MPU1_CTRL), 1,
 					       ice->irq, 0,
-					       &ice->rmidi[0])) < 0) {
+					       &ice->rmidi[0], port_name)) < 0) {
 			snd_card_free(card);
 			return err;
 		}

-		if (ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_2xMPU401)
-			if ((err = snd_mpu401_uart_new(card, 1, MPU401_HW_ICE1712,
+		if (ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_2xMPU401) {
+			midevice = 1;
+			if (c->mpu401_2_name != NULL)
+				snprintf(port_name, sizeof(port_name), "%s %d-%d", c->mpu401_2_name, card->number, midevice);
+			else
+				snprintf(port_name, sizeof(port_name), "MIDI 2 %s %d-%d", c->model, card->number, midevice);
+			if ((err = snd_mpu401_uart_new(card, midevice, MPU401_HW_ICE1712,
 						       ICEREG(ice, MPU2_CTRL), 1,
 						       ice->irq, 0,
-						       &ice->rmidi[1])) < 0) {
+						       &ice->rmidi[1], port_name)) < 0) {
 				snd_card_free(card);
 				return err;
 			}
+		}
 	}

	snd_ice1712_set_input_clock_source(ice, 0);
diff -ru ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.h ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.h
--- ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.h	2006-01-16 16:34:25.000000000 +0000
+++ ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.h	2006-03-29 11:23:12.000000000 +0100
@@ -493,6 +494,8 @@
 	int (*chip_init)(struct snd_ice1712 *);
 	int (*build_controls)(struct snd_ice1712 *);
 	unsigned int no_mpu401: 1;
+	char *mpu401_1_name;
+	char *mpu401_2_name;
 	unsigned int eeprom_size;
 	unsigned char *eeprom_data;
 };

--Boundary-00=_GhwKED6htib24RV--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
