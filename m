From: Doug McLain <doug@nostar.net>
Subject: Re: ice1712 -wordclock and SPDIF
Date: Wed, 01 Feb 2006 16:30:14 -0500
Message-ID: <43E12866.4030903@nostar.net>
References: <200601262301.23064.gineera@aspect135.co.uk> <43DA6EB0.3030203@nostar.net> <200601281424.14897.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050908090300000405050207"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200601281424.14897.gineera@aspect135.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Horstmann <gineera@aspect135.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050908090300000405050207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I see, as someone else reported a few weeks ago, spdif appears to work 
much better on this card than on the 1010LT.  SPDIF is pretty much 
totally broken on the 1010LT.  Hopefully I can use information gathered 
from your card to get the 1010LT working.

I applied your printk's, got expected results:
Jan 31 09:07:20 localhost kernel: U 9 CS0
Jan 31 09:07:51 localhost kernel: U 13 CS1 IfT Y
Jan 31 09:07:55 localhost kernel: U 9 CS0 IfT Y
Jan 31 09:07:56 localhost kernel: U 8 CS0
Jan 31 09:07:59 localhost kernel: U 13 CS1 IfT Y
Jan 31 09:08:04 localhost kernel: U 8 CS0 IfT Y

Nothing out of the ordinary here.  I added the output of the ice1712 
GPIO registers and a full register dump of the cs8427 (minus 0x38-0x7e, 
unused register addresses) to the output of /proc/asound/cardX/ice1712 
(where X is the card #).  Could I bother you to apply this patch and 
send me an output from your card while running off internal clock, at 
say 48k, and also when clocked via spdif in, and while audio is playing? 
   This patch also has perex's patch applied.  If it doesn't apply 
correctly for you, it should be an easy task to manually apply the 
changes in snd_ice1712_proc_read(). Thanks.  Here is the output of mine 
with this patch:

$ cat /proc/asound/card1/ice1712
M Audio Delta 1010LT at 0xd400, irq 9

EEPROM:
   Subvendor        : 0x12143bd6
   Size             : 29 bytes
   Version          : 1
   Codec            : 0x1f
   ACLink           : 0x80
   I2S ID           : 0x72
   S/PDIF           : 0x3
   GPIO mask        : 0x4
   GPIO state       : 0x7e
   GPIO direction   : 0xfb
   AC'97 main       : 0x0
   AC'97 pcm        : 0x0
   AC'97 record     : 0x0
   AC'97 record src : 0x44
   DAC ID #0        : 0x3
   DAC ID #1        : 0x3
   DAC ID #2        : 0x3
   DAC ID #3        : 0x3
   ADC ID #0        : 0x3
   ADC ID #1        : 0x3
   ADC ID #2        : 0x3
   ADC ID #3        : 0x3
   Extra #28        : 0x0

Registers:
   PSDOUT03         : 0x0000
   CAPTURE          : 0x00000000
   SPDOUT           : 0x0000
   RATE             : 0x00
   GPIO_DATA        : 0xd2
   GPIO_WRITE_MASK  : 0x04
   GPIO_DIRECTION   : 0x7b

CS8427 register dump:
   reg[0x01] = 0x81
   reg[0x02] = 0x00
   reg[0x03] = 0x0c
   reg[0x04] = 0x41
   reg[0x05] = 0x05
   reg[0x06] = 0x05
   reg[0x07] = 0x00
   reg[0x08] = 0x00
   reg[0x09] = 0x00
   reg[0x0a] = 0x00
   reg[0x0b] = 0x00
   reg[0x0c] = 0x00
   reg[0x0d] = 0x00
   reg[0x0e] = 0x00
   reg[0x0f] = 0x41
   reg[0x10] = 0x00
   reg[0x11] = 0x00
   reg[0x12] = 0x18
   reg[0x13] = 0x12
   reg[0x14] = 0x00
   reg[0x15] = 0x00
   reg[0x16] = 0x00
   reg[0x17] = 0x00
   reg[0x18] = 0x00
   reg[0x19] = 0x00
   reg[0x1a] = 0x00
   reg[0x1b] = 0x00
   reg[0x1c] = 0x00
   reg[0x1d] = 0x00
   reg[0x1e] = 0x40
   reg[0x1f] = 0x00
   reg[0x20] = 0x00
   reg[0x21] = 0x00
   reg[0x22] = 0x00
   reg[0x23] = 0x00
   reg[0x24] = 0x00
   reg[0x25] = 0x00
   reg[0x26] = 0x00
   reg[0x27] = 0x00
   reg[0x28] = 0x00
   reg[0x29] = 0x00
   reg[0x2a] = 0x00
   reg[0x2b] = 0x00
   reg[0x2c] = 0x00
   reg[0x2d] = 0x00
   reg[0x2e] = 0x00
   reg[0x2f] = 0x00
   reg[0x30] = 0x00
   reg[0x31] = 0x00
   reg[0x32] = 0x00
   reg[0x33] = 0x00
   reg[0x34] = 0x00
   reg[0x35] = 0x00
   reg[0x36] = 0x00
   reg[0x37] = 0x00
   reg[0x7f] = 0x71





Alan Horstmann wrote:
> As I indicated in an email 18.1.06, SPDIF in and out both work fine with 
> DMX6fire, so long as (with un-moded code) SPDIF is selected at least once (to 
> write to chip initially) for SPDIF in.  SPDIF out works always from driver 
> start.  It is the SPDIF input that is messed up if internal clock is selected 
> at different freqs twice or more in a row.
> 
> I will try the specific test you mentioned just to check when I can get a 
> moment.  It sounds like your problems may well also be chip registers not set 
> up correctly.  Perex's patch is just for the startup problem.  Later it's the 
> set_pro_rate that leads to the registers being messed up I think.
> 


--------------050908090300000405050207
Content-Type: text/x-patch;
 name="ice1712_proc_mod.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ice1712_proc_mod.diff"

Index: ice1712.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/ice1712.c,v
retrieving revision 1.75
diff -u -r1.75 ice1712.c
--- ice1712.c	17 Nov 2005 14:59:53 -0000	1.75
+++ ice1712.c	1 Feb 2006 21:16:57 -0000
@@ -60,7 +60,7 @@
 #include <sound/info.h>
 #include <sound/mpu401.h>
 #include <sound/initval.h>
-
+#include <sound/cs8427.h>
 #include <sound/asoundef.h>
 
 #include "ice1712.h"
@@ -316,7 +316,6 @@
 	inb(ICEREG(ice, DATA)); /* dummy read for pci-posting */
 }
 
-
 /*
  *
  * CS8427 interface
@@ -332,7 +331,7 @@
 	unsigned char reg[2] = { 0x80 | 4, 0 };   /* CS8427 auto increment | register number 4 + data */
 	unsigned char val, nval;
 	int res = 0;
-	
+	//printk("spdif_clock = %d\n", spdif_clock);
 	snd_i2c_lock(ice->i2c);
 	if (snd_i2c_sendbytes(ice->cs8427, reg, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
@@ -396,6 +395,21 @@
 	return 0;
 }
 
+static void snd_ice1712_init_input_clock(struct snd_ice1712 *ice)
+{
+        /* change CS8427 clock source too */
+        if (ice->cs8427)
+		printk("Y");
+                snd_ice1712_cs8427_set_input_clock(ice, is_spdif_master(ice));
+	/* notify ak4524 chip as well */
+	if (is_spdif_master(ice)) {
+		unsigned int i;
+		for (i = 0; i < ice->akm_codecs; i++) {
+			if (ice->akm[i].ops.set_rate_val)
+				ice->akm[i].ops.set_rate_val(&ice->akm[i], 0);
+		}
+	}
+}
 
 /*
  *  Interrupt handler
@@ -1537,6 +1551,7 @@
 {
 	struct snd_ice1712 *ice = entry->private_data;
 	unsigned int idx;
+	char reg[128] = {1};
 
 	snd_iprintf(buffer, "%s\n\n", ice->card->longname);
 	snd_iprintf(buffer, "EEPROM:\n");
@@ -1567,6 +1582,17 @@
 	snd_iprintf(buffer, "  CAPTURE          : 0x%08x\n", inl(ICEMT(ice, ROUTE_CAPTURE)));
 	snd_iprintf(buffer, "  SPDOUT           : 0x%04x\n", (unsigned)inw(ICEMT(ice, ROUTE_SPDOUT)));
 	snd_iprintf(buffer, "  RATE             : 0x%02x\n", (unsigned)inb(ICEMT(ice, RATE)));
+	snd_iprintf(buffer, "  GPIO_DATA        : 0x%02x\n", (unsigned)snd_ice1712_get_gpio_data(ice));
+        snd_iprintf(buffer, "  GPIO_WRITE_MASK  : 0x%02x\n", (unsigned)snd_ice1712_read(ice, ICE1712_IREG_GPIO_WRITE_MASK));
+	snd_iprintf(buffer, "  GPIO_DIRECTION   : 0x%02x\n", (unsigned)snd_ice1712_read(ice, ICE1712_IREG_GPIO_DIRECTION));
+	snd_iprintf(buffer, "\nCS8427 register dump:\n");
+	if (snd_i2c_sendbytes(ice->cs8427, reg, 1) != 1)
+		snd_printk(KERN_ERR "unable to send register 0x%x byte to CS8427\n", reg[0]);
+	snd_i2c_readbytes(ice->cs8427, reg, 127);
+	for (idx = 0; idx < 0x37; idx++)
+		snd_iprintf(buffer, "  reg[0x%02x] = 0x%02x\n", idx+1, 0xff & reg[idx]);
+
+	snd_iprintf(buffer, "  reg[0x7f] = 0x%02x\n", reg[126]);
 }
 
 static void __devinit snd_ice1712_proc_init(struct snd_ice1712 * ice)
@@ -1844,6 +1870,7 @@
 
 	spin_lock_irq(&ice->reg_lock);
 	oval = inb(ICEMT(ice, RATE));
+	printk("U %i ",ucontrol->value.enumerated.item[0]);
 	if (ucontrol->value.enumerated.item[0] == 13) {
 		outb(oval | ICE1712_SPDIF_MASTER, ICEMT(ice, RATE));
 	} else {
@@ -1855,22 +1882,12 @@
 	change = inb(ICEMT(ice, RATE)) != oval;
 	spin_unlock_irq(&ice->reg_lock);
 
-	if ((oval & ICE1712_SPDIF_MASTER) !=
-	    (inb(ICEMT(ice, RATE)) & ICE1712_SPDIF_MASTER)) {
-		/* change CS8427 clock source too */
-		if (ice->cs8427) {
-			snd_ice1712_cs8427_set_input_clock(ice, is_spdif_master(ice));
-		}
-		/* notify ak4524 chip as well */
-		if (is_spdif_master(ice)) {
-			unsigned int i;
-			for (i = 0; i < ice->akm_codecs; i++) {
-				if (ice->akm[i].ops.set_rate_val)
-					ice->akm[i].ops.set_rate_val(&ice->akm[i], 0);
-			}
-		}
+	printk("CS%i ",is_spdif_master(ice));
+	if ((oval & ICE1712_SPDIF_MASTER) != (inb(ICEMT(ice, RATE)) & ICE1712_SPDIF_MASTER)) {
+		printk("IfT ");
+	        snd_ice1712_init_input_clock(ice);
 	}
-
+	printk("\n");
 	return change;
 }
 
@@ -2394,7 +2411,7 @@
 	pci_write_config_byte(ice->pci, 0x63, ice->eeprom.data[ICE_EEP1_SPDIF]);
 	if (ice->eeprom.subvendor != ICE1712_SUBDEVICE_STDSP24) {
 		ice->gpio.write_mask = ice->eeprom.gpiomask;
-		ice->gpio.direction = ice->eeprom.gpiodir;
+		ice->gpio.direction = (0x7f & ice->eeprom.gpiodir);
 		snd_ice1712_write(ice, ICE1712_IREG_GPIO_WRITE_MASK,
 				  ice->eeprom.gpiomask);
 		snd_ice1712_write(ice, ICE1712_IREG_GPIO_DIRECTION,
@@ -2735,6 +2752,8 @@
 			}
 	}
 
+	snd_ice1712_init_input_clock(ice);
+
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
 		card->shortname, ice->port, ice->irq);
 

--------------050908090300000405050207--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
