From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000875]: Can't get nm256 up & running
Date: Tue, 15 Feb 2005 10:32:09 +0100
Message-ID: <0e817e3ac8761018e1f561eb1b7f87f4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0DFC9278
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2005 10:32:09 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=875> 
======================================================================
Reported By:                Jean-Louis Crouzet
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   875
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             # uname -a<br />
Linux hp900 2.6.8jlcv34 view.php?id=1 Tue Feb 1 13:43:52 CET 2005 i686 GNU/Linux
======================================================================
Date Submitted:             02-01-2005 16:17 CET
Last Modified:              02-15-2005 10:32 CET
======================================================================
Summary:                    Can't get nm256 up & running
Description: 
I trying since ages to get this nm256 up & running with ALSA, w/o any
sucess.

PC Omnibook 900 (not a 900B)

# uname -a
Linux hp900 2.6.8jlcv34 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
Tue Feb 1 13:43:52 CET 2005 i686 GNU/Linux


#lspci  -tv
-[00]-+-00.0  Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
      +-01.0-[01]--+-00.0  Neomagic Corporation NM2200 [MagicGraph 256AV]
      |            \-00.1  Neomagic Corporation NM2200 [MagicMedia 256AV
Audio]
      +-04.0  Texas Instruments PCI1225
      +-04.1  Texas Instruments PCI1225
      +-07.0  Intel Corp. 82371AB/EB/MB PIIX4 ISA
      +-07.1  Intel Corp. 82371AB/EB/MB PIIX4 IDE
      +-07.2  Intel Corp. 82371AB/EB/MB PIIX4 USB
      \-07.3  Intel Corp. 82371AB/EB/MB PIIX4 A	
	
# modinfo snd_nm256
filename:      
/lib/modules/2.6.8jlcv32/kernel/sound/pci/nm256/snd-nm256.ko
author:         Takashi Iwai <tiwai@suse.de>
description:    NeoMagic NM256AV/ZX
license:        GPL
vermagic:       2.6.8jlcv32 PENTIUMII gcc-3.3
depends:        snd-pcm,snd,snd-ac97-codec
alias:          pci:v000010C8d00008005sv*sd*bc*sc*i*
alias:          pci:v000010C8d00008006sv*sd*bc*sc*i*
alias:          pci:v000010C8d00008016sv*sd*bc*sc*i*
parm:           vaio_hack:Enable workaround for Sony VAIO notebooks.
parm:           use_cache:Enable the cache for coefficient table access.
parm:           buffer_top:Set the top address of audio buffer for
NeoMagic 256AV/ZX soundcard.
parm:           force_ac97:Force to use AC97 codec for NeoMagic 256AV/ZX
soundcard.
parm:           capture_bufsize:ADC frame size in kB for NeoMagic 256AV/ZX
soundcard.
parm:           playback_bufsize:DAC frame size in kB for NeoMagic
256AV/ZX soundcard.
parm:           enable:Enable this soundcard.
parm:           id:ID string for NeoMagic 256AV/ZX soundcard.
parm:           index:Index value for NeoMagic 256AV/ZX soundcard.

# alsaconf
Unloading sound driver modules...done.
Building card database..


Running update-modules...
Loading driver...
FATAL: Error running install command for snd_nm256
Setting default volumes...
Saving the mixer setup used for this in /var/lib/alsa/asound.state.
/usr/sbin/alsactl: save_state:1061: No soundcards found...

===============================================================================

 Now ALSA is ready to use.
 For adjustment of volumes, use your favorite mixer.

 Have a lot of fun!


???????????????????????????,,
======================================================================

----------------------------------------------------------------------
 Jean-Louis Crouzet - 02-15-05 10:08 
----------------------------------------------------------------------
Hi,

tried your latest guidelines (not sure about parms value according to my
BIOS settings above).

hp900:~# /sbin/modinfo snd-cs4232
filename:      
/lib/modules/2.6.8jlcv38/kernel/sound/isa/cs423x/snd-cs4232.ko
author:         Jaroslav Kysela <perex@suse.cz>
license:        GPL
description:    Cirrus Logic CS4232
vermagic:       2.6.8jlcv38 PENTIUMII gcc-3.3
depends:        snd-cs4231-lib,snd-opl3-lib,snd-mpu401-uart,snd
parm:           dma2:DMA2 # for CS4232 driver.
parm:           dma1:DMA1 # for CS4232 driver.
parm:           mpu_irq:MPU-401 IRQ # for CS4232 driver.
parm:           irq:IRQ # for CS4232 driver.
parm:           sb_port:SB port # for CS4232 driver (optional).
parm:           fm_port:FM port # for CS4232 driver.
parm:           mpu_port:MPU-401 port # for CS4232 driver.
parm:           cport:Control port # for CS4232 driver.
parm:           port:Port # for CS4232 driver.
parm:           enable:Enable CS4232 soundcard.
parm:           id:ID string for CS4232 soundcard.
parm:           index:Index value for CS4232 soundcard.

hp900:~# alsaconf -L logfile -p snd-cs4232 sb_port=0x530 cport=0x538
dma1=1 dma2=0 irq=5 isapnp=0
Usage: /etc/init.d/alsa {start [CARD]|stop [CARD]|restart
[CARD]|force-unload|force-reload|suspend|resume}
FAILED
hp900:~# cat logfile
Starting alsaconf: Tue Feb 15 10:11:07 CET 2005
hp900:~#                                              

Knowing that BIOS has those settings:
SBI/O = 0x220
WSSI/O = 0x530
AdLib I/O = 0x388
Int = IRQ5
1st DMA = DMA1
2nd DMA = DMA0
I'm not sure of which parm. correspond which value, beside sb_port which
might be equal to 0x220.
I gave try but no success...

Thanks very much for digging this with me. I'll try other combination
today until you have something more accurate than my emprical way to
check.
JL

----------------------------------------------------------------------
 Jean-Louis Crouzet - 02-15-05 10:32 
----------------------------------------------------------------------
I also tried this with cs4232 not snd_cs4232, shall I change my BIOS
settings and again which parm correspond to what?

hp900:~# modinfo cs4232
filename:       /lib/modules/2.6.8jlcv38/kernel/sound/oss/cs4232.ko
description:    CS4232 based soundcard driver
author:         Hannu Savolainen, Paul Barton-Davis
license:        GPL
vermagic:       2.6.8jlcv38 PENTIUMII gcc-3.3
depends:        uart401,sound,ad1848
alias:          pnp:dCSC0100*
alias:          pnp:dCSC0000*
alias:          pnp:dGIM0100*
parm:           bss:Enable Bose Sound System Support (default 0)
parm:           isapnp:Enable ISAPnP probing (default 1)
parm:           synthirq:Maui WaveTable IRQ
parm:           synthio:Maui WaveTable base I/O port
parm:           mpuirq:MPU 401 IRQ
parm:           mpuio:MPU 401 base address
parm:           dma2:16 bit DMA for AD1848 chip
parm:           dma:8 bit DMA for AD1848 chip
parm:           irq:IRQ for AD1848 chip
parm:           io:base I/O port for AD1848
hp900:~# alsaconf -L logfile -p cs4232 io=0x220 dma=1 dma2=0 irq=5
isapnp=0
Usage: /etc/init.d/alsa {start [CARD]|stop [CARD]|restart
[CARD]|force-unload|force-reload|suspend|resume}
FAILED
hp900:~# cat logfile
Starting alsaconf: Tue Feb 15 10:36:47 CET 2005
cs4232 port=0x530 cport=0x538 dma1=1 dma2=0 irq=5
cs4232 port=0x534 cport=0x538 dma1=1 dma2=0 irq=5
cs4232 port=0x530 cport=0x210 dma1=1 dma2=0 irq=5
cs4232 port=0x534 cport=0x210 dma1=1 dma2=0 irq=5
cs4232 port=0x530 cport=0xf00 dma1=1 dma2=0 irq=5
cs4232 port=0x534 cport=0xf00 dma1=1 dma2=0 irq=5
hp900:~# modinfo ad1848
filename:       /lib/modules/2.6.8jlcv38/kernel/sound/oss/ad1848.ko
license:        GPL
vermagic:       2.6.8jlcv38 PENTIUMII gcc-3.3
depends:        sound
hp900:~# modinfo sound
filename:       /lib/modules/2.6.8jlcv38/kernel/sound/oss/sound.ko
license:        GPL
description:    OSS Sound subsystem
author:         Hannu Savolainen, et al.
vermagic:       2.6.8jlcv38 PENTIUMII gcc-3.3
depends:        soundcore
hp900:~# modinfo soundcore
filename:       /lib/modules/2.6.8jlcv38/kernel/sound/soundcore.ko
description:    Core sound module
author:         Alan Cox
license:        GPL
alias:          char-major-14-*
vermagic:       2.6.8jlcv38 PENTIUMII gcc-3.3
depends:
hp900:~#

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-01-05 16:17 Jean-Louis CrouzetNew Issue                                    
02-01-05 16:17 Jean-Louis CrouzetKernel Version            => # uname -a
Linux hp900 2.6.8jlcv34 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
Tue Feb 1 13:43:52 CET 2005 i686 GNU/Linux
02-02-05 11:18 tiwai          Note Added: 0003483                          
02-02-05 12:40 Jean-Louis CrouzetNote Added: 0003485                          
02-02-05 12:46 tiwai          Note Added: 0003486                          
02-02-05 13:05 Jean-Louis CrouzetNote Added: 0003487                          
02-09-05 12:09 tiwai          Note Added: 0003547                          
02-10-05 09:54 Jean-Louis CrouzetNote Added: 0003563                          
02-14-05 19:46 tiwai          Note Added: 0003605                          
02-15-05 10:08 Jean-Louis CrouzetNote Added: 0003617                          
02-15-05 10:32 Jean-Louis CrouzetNote Added: 0003618                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
