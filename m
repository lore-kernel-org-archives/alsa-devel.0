From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Hercules Gamesurround Fortissimo III 7.1
Date: Sat, 28 Jun 2003 14:28:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EFD89F2.5000609@cucumelo.org>
References: <200306271848.20758.gtdev@spearhead.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicos Gollan <gtdev@spearhead.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
> - Without the external_amp parameter, sound is sometimes OK, sometimes 
>distorted, sometimes not available at all.
>
> - With external_amp set, the card basically works, but there are some quirks
>  
>
But, amp_hercules(...) and hercules_mixer_init(...) function have only 
been implemented to
do some specific initializations to the Game Theater XP card, which 
probably is very
similar to the Fortissimo card, but my guess is that something slight 
diferenent is needed on
the initialization phase. (which can be hard to know course Hercules 
seems to be yet another company
which dont releases any spec. about their soundcards ....)

If you say that it works better with the external_amp=1, then this card 
must have some similarity
with the Santa Cruz card ... the amp_voyectra(...) function will also 
set some GPIO's on
the seconary cs4294 codec, who knows if this is good or bad for the 
Fortissimo card ....

> - After a cold boot, the driver loads OK. After some 2-3 minutes uptime, 
>there's a very loud crackling noise, independent of sound output (like very 
>high spikes in the output). This goes away after about 20 seconds. After 
>that, sound is either "normal" (definition of normal follows...) or entirely 
>gone.
>
> - Unloading the driver module works. However, reloading the module fails the 
>first time. Trying to load the driver a second time is always successful. See 
>the "reload-module.txt" attachment for output.
>  
>
This card is not the only one that has initialization problems, I've got 
similar
problems with the Terratec SixPack 5.1. Some of the initialization 
problems could
probably be fixed having some time and pacience.

The other sound problems you're talking about seems to be new to the 
Fortissimo card ...

> - Sometimes, sound is distorted at high PCM volume settings, sometimes it 
>isn't. I have not found any way to reproduce this, it just happens from time 
>to time. (Lasts as long as the machine isn't power-cycled). Setting the PCM 
>volume down to about 77% avoids this.
>  
>
Well, and thoose distortion problems with cs46xx are not new either.
Try having the master volume at 100% and 3D settings to "Post 3D" then
play with the PCM volume, and check what's the behaviour.

> - After rebooting from Windows, sound dies with a "plop" afer some minutes. 
>Reloading the module gives another few minutes of sound. (repeat ad nauseam)
>  
>
Who knows what the Windows driver does with the HW that the ALSA driver 
dont ....


What about the other functions on the card:
Have you tested the SPDIF output/input AC3 pass-through?
 the different outputs, center, rear, surround speakers ?

/Benny

>------------------------------------------------------------------------
>
>--- modules/alsa-driver/alsa-kernel/pci/cs46xx/cs46xx_lib.c	2003-05-25 12:22:10.000000000 +0200
>+++ /home/nicos/systemcode/alsa-driver-0.9.3c/alsa-kernel/pci/cs46xx/cs46xx_lib.c	2003-05-30 14:48:52.000000000 +0200
>@@ -3743,6 +3743,13 @@
> 		.amp = amp_hercules,
> 		.mixer_init = hercules_mixer_init,
> 	},
>+  {
>+		.vendor = 0x1681,
>+    .id = 0xa011,
>+    .name = "Hercules Fortissimo III 7.1",
>+    .amp = amp_hercules,
>+    .mixer_init = hercules_mixer_init,
>+  },
> 	/* Teratec */
> 	{
> 		.vendor = 0x153b,
>  
>
>------------------------------------------------------------------------
>
>--- loading the module after unloading ---
>elysium:~# modprobe snd-cs46xx
>Warning: ignoring device_gid=29, no such parameter in this module
>Warning: ignoring device_uid=0, no such parameter in this module
>Module snd loaded, with warnings
>Module snd-seq-device loaded, with warnings
>Module snd-rawmidi loaded, with warnings
>Module snd-timer loaded, with warnings
>Module snd-pcm loaded, with warnings
>Module snd-ac97-codec loaded, with warnings
>/lib/modules/2.4.21-personal-alsa/alsa/snd-cs46xx.o: init_module: No such device
>Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.
>      You may find more information in syslog or the output from dmesg
>/lib/modules/2.4.21-personal-alsa/alsa/snd-cs46xx.o: insmod /lib/modules/2.4.21-personal-alsa/alsa/snd-cs46xx.o failed
>/lib/modules/2.4.21-personal-alsa/alsa/snd-cs46xx.o: insmod snd-cs46xx failed
>elysium:~# modprobe snd-cs46xx
>Warning: ignoring device_gid=29, no such parameter in this module
>Warning: ignoring device_uid=0, no such parameter in this module
>Module snd loaded, with warnings
>Module snd-seq-device loaded, with warnings
>Module snd-rawmidi loaded, with warnings
>Module snd-timer loaded, with warnings
>Module snd-pcm loaded, with warnings
>Module snd-ac97-codec loaded, with warnings
>Module snd-cs46xx loaded, with warnings
>
>
>--- dmesg ---
>PCI: Found IRQ 5 for device 00:0f.0
>ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:416: cs46xx: failure waiting for FIFO command to complete
>ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3216: ERROR: snd-cs46xx: never read ISV3 & ISV4 from AC'97
>ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3217:        Try reloading the ALSA driver, if you find something
>ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3218:        broken or not working on your soundcard upon
>ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3219:        this message please report to alsa-devel@lists.sourceforge.net
>Sound Fusion CS46xx soundcard not found or device busy
>PCI: Found IRQ 5 for device 00:0f.0
>ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:416: cs46xx: failure waiting for FIFO command to complete
>  
>





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
