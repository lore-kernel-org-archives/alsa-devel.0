From: Rafal Dejewski <lardel@interia.pl>
Subject: Re: Ali5451 on HP VT6200 notebook not working
Date: Fri, 29 Nov 2002 10:53:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211291053.15510.lardel@interia.pl>
References: <200211211230.00392.lardel@interia.pl> <s5hof89zm68.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Lkz59HPSFpzSXrt"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hof89zm68.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_Lkz59HPSFpzSXrt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 28 November 2002 17:36, Takashi Iwai wrote:
> Hi,
>
> At Thu, 21 Nov 2002 12:29:59 +0100,
>
> Rafal Dejewski wrote:
> > Hi,
> > I have HP vt6200 notebook. It has ALI5451 chip. I tried diffrent kernels
> > 2.4.18, 2.4.19, 2.4.20rc1, 2.5.48 and alsa-driver 0.9rc4,rc5,rc6.
> > The standard kernel trident module works OK on all kernels but alsa
> > driver does not on any.
> > Before rc6 the snd-ali5451 module would just hang with "(initializing)"
> > status. Now with rc6 or kernel 2.5.48 when I uncomment "#define
> > ALI_DEBUG" this what dmesg is showing:
> > driver pci:ALI 5451: registering
> > kobject ALI 5451: registering
> > bus pci: add driver ALI 5451
> > probe ...
> > creating ...
> > PCI: IRQ 7 for device 00:04.0 doesn't match PIRQ mask - try
> > pci=usepirqmask
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> is this ok?
Apparently adding this to doesn't change much, except that ali5451 now uses 
irq10 along with ati graphics chip, network card, wlan and usb.
>
> > PCI: Found IRQ 7 for device 00:04.0
> > resouces allocation ...
> > resouces allocated.
> > snd_device_new is called.
> > chip initializing ...
> > ALSA sound/pci/ali5451/ali5451.c:2159: ali create: chip init error.
>
> it looks like the driver failed the reset of ac97 codec.
> the attached patch will let the driver continue after the error.
> please let me know whether it works for you.
>
The patch you supplied did not help me. I tried to find the place where it 
fails. I applied attached patch to ali5451.c from 2.5.50 kernel. This is what 
I get in dmesg now:
probe ...
creating ...
PCI: Found IRQ 10 for device 00:04.0
resouces allocation ...
resouces allocated.
snd_device_new is called.
chip initializing ...
pci_dev is NULL after pci_find_device!
ALSA sound/pci/ali5451/ali5451.c:2160: ali create: chip init error.

Hope this helps,
Rafal




----------------------------------------------------------------------
Powiedz sobie dobre "Dzien dobry"!http://link.interia.pl/f168b

--Boundary-00=_Lkz59HPSFpzSXrt
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ali_mypatch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ali_mypatch.diff"

--- ali5451.c_org	2002-11-29 10:24:28.000000000 +0100
+++ ali5451.c	2002-11-29 10:32:24.000000000 +0100
@@ -70,7 +70,7 @@
  *  Debug part definations
  */
 
-//#define ALI_DEBUG
+#define ALI_DEBUG
 
 #ifdef ALI_DEBUG
 #define snd_ali_printk(format, args...) printk(format, ##args);
@@ -529,7 +529,7 @@
 		udelay(5000);
 	}
 
-	return -1;
+	return 0;
 }
 
 #ifdef CODEC_RESET
@@ -2004,8 +2004,9 @@
 		pci_read_config_byte(pci_dev, 0x59, &temp);
 	
 		pci_dev = pci_find_device(0x10b9,0x7101, pci_dev);
-		if (pci_dev == NULL)
-                	return -1;
+		if (pci_dev == NULL) {
+			snd_ali_printk("pci_dev is NULL after pci_find_device!\n");
+                	return -1; }
 		pci_read_config_byte(pci_dev,0xb8,&temp);
 		temp |= 1 << 6;
 		pci_write_config_byte(pci_dev, 0xB8, temp);

--Boundary-00=_Lkz59HPSFpzSXrt--



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
