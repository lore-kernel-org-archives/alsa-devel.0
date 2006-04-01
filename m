From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: ice1712 overwrite standard midi port names
Date: Sat, 1 Apr 2006 22:06:27 +0100
Message-ID: <200604012206.27893.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TtuLEVtu4qyNmQh"
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


--Boundary-00=_TtuLEVtu4qyNmQh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Following our discussions I had time to prepare this patch for ice1712 driver.  
I figured you prefered the minimum changes to achieve the end result.  The 
replacement names in ews.c are left as I prefer, 'detail, card', but if you 
choose, just reverse the order, to comply instead with convention.  How does 
this proposal look?

There are no name entries in _card_info for any card sub-vendors other than 
DMX6fire.  Perhaps others could add these as appropriate?

Alan

ice1712-add-pref-midi-names.patch

Summary: Provides specified midi port names instead of defaults

Patch provides for the ice1712 card driver to overwrite the midi port name 
string given by default in mpu401_uart, with one specified in 
snd_ice1712_card_info.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>



--Boundary-00=_TtuLEVtu4qyNmQh
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ice1712-add-pref-midi-names.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ice1712-add-pref-midi-names.patch"

diff -ru ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ews.c ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ews.c
--- ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ews.c	2005-11-22 14:33:27.000000000 +0000
+++ ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ews.c	2006-03-31 14:12:46.000000000 +0100
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
+++ ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.c	2006-03-31 14:02:30.000000000 +0100
@@ -2725,8 +2743,11 @@
 			snd_card_free(card);
 			return err;
 		}
+		if (c->mpu401_1_name != NULL)   /*  Prefered name available in card_info  */
+			snprintf(ice->rmidi[0]->name, sizeof(ice->rmidi[0]->name),
+						"%s %d-0", c->mpu401_1_name, card->number);
 
-		if (ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_2xMPU401)
+		if (ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_2xMPU401) {  /*  2nd port used  */
 			if ((err = snd_mpu401_uart_new(card, 1, MPU401_HW_ICE1712,
 						       ICEREG(ice, MPU2_CTRL), 1,
 						       ice->irq, 0,
@@ -2734,6 +2755,11 @@
 				snd_card_free(card);
 				return err;
 			}
+			if (c->mpu401_2_name != NULL)   /*  Prefered name available in card_info  */
+				snprintf(ice->rmidi[1]->name, sizeof(ice->rmidi[1]->name),
+							"%s %d-1", c->mpu401_2_name, card->number);
+
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

--Boundary-00=_TtuLEVtu4qyNmQh--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
