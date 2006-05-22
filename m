From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: DMX6fire  Consumer AC97 not used
Date: Mon, 22 May 2006 14:52:08 +0100
Message-ID: <200605221450.14491.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IIccEJ3nyBV6201"
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


--Boundary-00=_IIccEJ3nyBV6201
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Another little 'tidy-up':

Have always had the following log message with DMX6fire:

 linux kernel: Consumer PCM code does not work well at the moment --jk
 linux kernel: ALSA ac97_codec.c:1671: AC'97 0:0 does not respond - RESET
 linux kernel: ALSA ac97_codec.c:1682: AC'97 0:0 access is not valid 
[0xffffffff], removing mixer.
 linux kernel: ice1712: cannot initialize ac97 for consumer, skipped

and thought the last 3 were due to the first.  However, after comparing 
DMX6fire with STDSP24 card, it seems to me that the 6fire doesn't have an 
AC97 chip, nor anywhere to connect to one in the standard front box, and the 
W2K drivers from Terratec don't support it.  It is remotely possible that 
other extension boxes may use it -but they do not have alsa support at 
present.

BUT the eeprom data has it enabled.  As the value is checked at several places 
in the code, the attached patch changes the stored value for this and the 
previous 'Limit ADACs to 6' bits.

As a result, the log now shows no evidence of ice1712 driver at all, so I 
added 'init...done' as in the attached 'init-message' patch.  It may be the 
wrong place, or not wanted at all, so I kept it separate from the AC97 patch.  
Hope it's OK in this case to attach both here.

BTW, re 'Consumer PCM code does not work well at the moment --jk',  will it be 
fixed?

Alan

ice1712.c-disable-6fire-AC97.patch

Summary:  Disable AC97 for DMX6fire

Consumer AC97 is not used by the Terratec DMX6fire, but eeprom bit indicates 
it is; change the stored value to disable failling consumer mode.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

ice1712.c-init-message.patch

Adds init message to the ice1712 driver.



--Boundary-00=_IIccEJ3nyBV6201
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ice1712.c-disable-6fire-AC97.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ice1712.c-disable-6fire-AC97.patch"

--- alsa-driver-1.0.11-orig/alsa-kernel/pci/ice1712/ice1712.c	2006-04-18 12:38:03.000000000 +0100
+++ alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ice1712.c	2006-05-20 17:09:53.000000000 +0100
@@ -2398,13 +2398,11 @@
 	udelay(200);
 	outb(ICE1712_NATIVE, ICEREG(ice, CONTROL));
 	udelay(200);
-	if (ice->eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE && !ice->dxr_enable) {
-                /* Limit active ADCs and DACs to 6;  */
-                /* Note: DXR extension not supported */
-		pci_write_config_byte(ice->pci, 0x60, 0x2a);
-	} else {
-		pci_write_config_byte(ice->pci, 0x60, ice->eeprom.data[ICE_EEP1_CODEC]);
-	}
+	if (ice->eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE && !ice->dxr_enable)
+		/*  Limit active ADCs and DACs to 6;  Note: DXR extensions are not currently supported */
+		/*  Also AC97 Consumer hardware is not provided in standard 6fire front box            */
+		ice->eeprom.data[ICE_EEP1_CODEC] = 0x3a;  /*  Correct eeprom value  */
+	pci_write_config_byte(ice->pci, 0x60, ice->eeprom.data[ICE_EEP1_CODEC]);
 	pci_write_config_byte(ice->pci, 0x61, ice->eeprom.data[ICE_EEP1_ACLINK]);
 	pci_write_config_byte(ice->pci, 0x62, ice->eeprom.data[ICE_EEP1_I2SID]);
 	pci_write_config_byte(ice->pci, 0x63, ice->eeprom.data[ICE_EEP1_SPDIF]);

--Boundary-00=_IIccEJ3nyBV6201
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ice1712.c-init-message.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ice1712.c-init-message.patch"

--- alsa-driver-1.0.11-orig/alsa-kernel/pci/ice1712/ice1712.c	2006-04-18 12:38:03.000000000 +0100
+++ alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ice1712.c	2006-05-20 21:57:03.000000000 +0100
@@ -2394,7 +2394,6 @@
 
 static int __devinit snd_ice1712_chip_init(struct snd_ice1712 *ice)
 {
+	printk("ice1712: Init...");
 	outb(ICE1712_RESET | ICE1712_NATIVE, ICEREG(ice, CONTROL));
 	udelay(200);
 	outb(ICE1712_NATIVE, ICEREG(ice, CONTROL));
@@ -2434,6 +2433,7 @@
 		snd_ice1712_write(ice, ICE1712_IREG_CONSUMER_POWERDOWN, 0);
 	}
 	snd_ice1712_set_pro_rate(ice, 48000, 1);
+	printk("done\n");
 
 	return 0;
 }

--Boundary-00=_IIccEJ3nyBV6201--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
