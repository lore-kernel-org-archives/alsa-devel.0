From: Nicos Gollan <gtdev@spearhead.de>
Subject: Hercules Gamesurround Fortissimo III 7.1
Date: Fri, 27 Jun 2003 18:48:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306271848.20758.gtdev@spearhead.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UVH/+5ruZeTZDlg"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_UVH/+5ruZeTZDlg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi...

During the last weeks, I tried to get that card to work with ALSA 0.9.3c. 
Here's what I found:

 - The card is not properly recognized by the driver. I added the card to the 
drivers hardware list (see attached patch) which seemed to help somewhat.

 - Without the external_amp parameter, sound is sometimes OK, sometimes 
distorted, sometimes not available at all.

 - With external_amp set, the card basically works, but there are some quirks

The remaining quirks are:

 - After a cold boot, the driver loads OK. After some 2-3 minutes uptime, 
there's a very loud crackling noise, independent of sound output (like very 
high spikes in the output). This goes away after about 20 seconds. After 
that, sound is either "normal" (definition of normal follows...) or entirely 
gone.

 - Unloading the driver module works. However, reloading the module fails the 
first time. Trying to load the driver a second time is always successful. See 
the "reload-module.txt" attachment for output.

 - Sometimes, sound is distorted at high PCM volume settings, sometimes it 
isn't. I have not found any way to reproduce this, it just happens from time 
to time. (Lasts as long as the machine isn't power-cycled). Setting the PCM 
volume down to about 77% avoids this.

 - After rebooting from Windows, sound dies with a "plop" afer some minutes. 
Reloading the module gives another few minutes of sound. (repeat ad nauseam)

In conclusion, I think there's something wrong with the initialization. My 
configuration is similar to the one given on the alsa-project website. Are 
there any known bugs or workarounds?

-- 
Got Backup?

--Boundary-00=_UVH/+5ruZeTZDlg
Content-Type: text/x-diff;
  charset="us-ascii";
  name="alsa-herculesgsf3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="alsa-herculesgsf3.patch"

--- modules/alsa-driver/alsa-kernel/pci/cs46xx/cs46xx_lib.c	2003-05-25 12:22:10.000000000 +0200
+++ /home/nicos/systemcode/alsa-driver-0.9.3c/alsa-kernel/pci/cs46xx/cs46xx_lib.c	2003-05-30 14:48:52.000000000 +0200
@@ -3743,6 +3743,13 @@
 		.amp = amp_hercules,
 		.mixer_init = hercules_mixer_init,
 	},
+  {
+		.vendor = 0x1681,
+    .id = 0xa011,
+    .name = "Hercules Fortissimo III 7.1",
+    .amp = amp_hercules,
+    .mixer_init = hercules_mixer_init,
+  },
 	/* Teratec */
 	{
 		.vendor = 0x153b,

--Boundary-00=_UVH/+5ruZeTZDlg
Content-Type: text/plain;
  charset="us-ascii";
  name="reload-module.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="reload-module.txt"

--- loading the module after unloading ---
elysium:~# modprobe snd-cs46xx
Warning: ignoring device_gid=29, no such parameter in this module
Warning: ignoring device_uid=0, no such parameter in this module
Module snd loaded, with warnings
Module snd-seq-device loaded, with warnings
Module snd-rawmidi loaded, with warnings
Module snd-timer loaded, with warnings
Module snd-pcm loaded, with warnings
Module snd-ac97-codec loaded, with warnings
/lib/modules/2.4.21-personal-alsa/alsa/snd-cs46xx.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.21-personal-alsa/alsa/snd-cs46xx.o: insmod /lib/modules/2.4.21-personal-alsa/alsa/snd-cs46xx.o failed
/lib/modules/2.4.21-personal-alsa/alsa/snd-cs46xx.o: insmod snd-cs46xx failed
elysium:~# modprobe snd-cs46xx
Warning: ignoring device_gid=29, no such parameter in this module
Warning: ignoring device_uid=0, no such parameter in this module
Module snd loaded, with warnings
Module snd-seq-device loaded, with warnings
Module snd-rawmidi loaded, with warnings
Module snd-timer loaded, with warnings
Module snd-pcm loaded, with warnings
Module snd-ac97-codec loaded, with warnings
Module snd-cs46xx loaded, with warnings


--- dmesg ---
PCI: Found IRQ 5 for device 00:0f.0
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:416: cs46xx: failure waiting for FIFO command to complete
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3216: ERROR: snd-cs46xx: never read ISV3 & ISV4 from AC'97
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3217:        Try reloading the ALSA driver, if you find something
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3218:        broken or not working on your soundcard upon
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3219:        this message please report to alsa-devel@lists.sourceforge.net
Sound Fusion CS46xx soundcard not found or device busy
PCI: Found IRQ 5 for device 00:0f.0
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:416: cs46xx: failure waiting for FIFO command to complete

--Boundary-00=_UVH/+5ruZeTZDlg--



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
