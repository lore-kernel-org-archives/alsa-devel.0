From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Terratec EWS88MT: fool protection :-)
Date: Tue, 6 Aug 2002 17:37:26 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208061706330.15433-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

My problem with Terratec EWS88MT was cause by two factors - I didn't 
connect the front module, and the driver wasn't handling this situation 
gracefully.

I guess I'm not the only person who can have this problem.  The cable can
be disconnected accidentally, or something can break in the front module.

And most importantly, snd_runtime_check() was used incorrectly in
alsa-kernel/pci/ice1712.c, causing a mutex to remain down.  As the result,
modprobe would get stuck until reboot.  Such errors should be fixed.

In snd_ice1712_ews88mt_chip_select(), snd_runtime_check() didn't work as 
expected (I'm using gcc-2.96 as shipped with RedHat 7.3).  I don't know it 
it's a preprocessor bug or not, but the comma in the arguments looks very 
ambiguous even to me, let alone preprocessors.

So, instead of using snd_i2c_unlock() inside snd_runtime_check(), it is
now called at the end of the function.  I know that not everybody likes 
goto, but I tried to be consistent with other drivers that use the 
"__error" label in similar situations.

As an additional bonus, it's now possible to alert user of the problem.  
Since this function is specific for Terratec EWS88MT, I decided to be very 
specific and to ask user to check the cable.

snd_ice1712_ews88mt_chip_select() also returns -1 now.  I don't want to
change many function to return int instead of void to handle this very
specific situation (I'll do it if somebody askes me), so I decided to put
a check before snd_ice1712_ak4524_init() is called.  The driver selects
all 4 channels.  If this fails, we return an error, telling the caller
that the device doesn't work.

The testing of the fixed driver shows that:

1) The driver works if the front module is connected:

PCI: Found IRQ 12 for device 00:11.0
PCI: Sharing IRQ 12 with 00:0d.1
Consumer PCM code does not work well at the moment --jk

2) The driver refuses to work if the front module is disconnected.

PCI: Found IRQ 12 for device 00:11.0
PCI: Sharing IRQ 12 with 00:0d.1
ALSA ../alsa-kernel/pci/ice1712.c:977: AK4524 chip select failed, check 
cable to the front module
ICE1712 soundcard not found or device busy

modutils output:

/home/proski/src/alsa-cvs/alsa-driver/pci/ice1712.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg

No more hangs!  This patch is against current CVS.

========================================
--- alsa-kernel/pci/ice1712.c
+++ alsa-kernel/pci/ice1712.c
@@ -960,17 +960,23 @@ static snd_i2c_bit_ops_t snd_ice1712_ewx
 };
 
 /* AK4524 chip select; address 0x48 bit 0-3 */
-static void snd_ice1712_ews88mt_chip_select(ice1712_t *ice, int chip_mask)
+static int snd_ice1712_ews88mt_chip_select(ice1712_t *ice, int chip_mask)
 {
 	unsigned char data, ndata;
 
 	snd_assert(chip_mask >= 0 && chip_mask <= 0x0f, return);
 	snd_i2c_lock(ice->i2c);
-	snd_runtime_check(snd_i2c_readbytes(ice->pcf8574[1], &data, 1) == 1, snd_i2c_unlock(ice->i2c); return);
+	snd_runtime_check((snd_i2c_readbytes(ice->pcf8574[1], &data, 1) == 1), goto __error);
 	ndata = (data & 0xf0) | chip_mask;
 	if (ndata != data)
-		snd_runtime_check(snd_i2c_sendbytes(ice->pcf8574[1], &ndata, 1) == 1, snd_i2c_unlock(ice->i2c); return);
+		snd_runtime_check((snd_i2c_sendbytes(ice->pcf8574[1], &ndata, 1) == 1), goto __error);
 	snd_i2c_unlock(ice->i2c);
+	return 0;
+
+      __error:
+	snd_printk("AK4524 chip select failed, check cable to the front module\n");
+	snd_i2c_unlock(ice->i2c);
+	return -EIO;
 }
 
 /*
@@ -3836,11 +3842,15 @@ static int __devinit snd_ice1712_chip_in
 	}
 	/* second stage of initialization, analog parts and others */
 	switch (ice->eeprom.subvendor) {
+	case ICE1712_SUBDEVICE_EWS88MT:
+		/* Check if the front module is connected */
+		if ((err = snd_ice1712_ews88mt_chip_select(ice, 0x0f)) < 0)
+			return err;
+		/* Fall through */
 	case ICE1712_SUBDEVICE_DELTA66:
 	case ICE1712_SUBDEVICE_DELTA44:
 	case ICE1712_SUBDEVICE_AUDIOPHILE:
 	case ICE1712_SUBDEVICE_EWX2496:
-	case ICE1712_SUBDEVICE_EWS88MT:
 	case ICE1712_SUBDEVICE_DMX6FIRE:
 		snd_ice1712_ak4524_init(ice);
 		break;
========================================

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
