From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000875]: Can't get nm256 up & running
Date: Wed, 2 Feb 2005 13:05:59 +0100
Message-ID: <9a5e0fecb7d4988ca020a362f8a27b71@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A1A62215
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2005 13:05:59 +0100 (MET)
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
Last Modified:              02-02-2005 13:05 CET
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
 tiwai - 02-02-05 12:46 
----------------------------------------------------------------------
As the driver told you, the chip has no AC97 codec but most likely it's
connected to another ISA codec chip.

Run alsaconf and proceed to probe legacy ISA device.  Then choose cs4232
and cs4236.  If it can't detect, check BIOS setting which parameters are
used.

----------------------------------------------------------------------
 Jean-Louis Crouzet - 02-02-05 13:05 
----------------------------------------------------------------------
Done this test with my initial kernel uname -a
Linux hp900 2.6.8-2-686 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
Sat Jan 8 16:50:08 EST 2005 i686 GNU/Linux

The BIOS settings are:

SBI/O = 0x220
WSSI/O = 0x530
AdLib I/O = 0x388
Int = IRQ5
1st DMA = DMA1
2nd DMA = DMA0

running alsaconf give:
alsaconf
Unloading sound driver modules...done.
Probing legacy cards..   This may take a few minutes..
Probing:  cs4232 cs4231
hp900:/usr/src#

in consequence nothing is being detected! I shall change something for
sure but where?

lsmod
Module                  Size  Used by
snd_pcm_oss            55048  0
snd_mixer_oss          20096  1 snd_pcm_oss
snd_pcm                98728  1 snd_pcm_oss
snd_timer              25668  1 snd_pcm
snd_page_alloc         11752  1 snd_pcm
snd                    57156  4
snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10336  1 snd
apm                    21100  1
af_packet              22568  2
ipv6                  264612  8
serial_cs              10396  1
uhci_hcd               33136  0
usbcore               119012  3 uhci_hcd
yenta_socket           21728  1
pci_hotplug            34640  0
intel_agp              22816  1
agpgart                34664  1 intel_agp
floppy                 61200  0
tsdev                   7392  0
mousedev               10476  2
irtty_sir               9152  0
sir_dev                19244  1 irtty_sir
irda                  197120  2 irtty_sir,sir_dev
crc_ccitt               2144  1 irda
psmouse                20360  0
parport_pc             36900  0
parport                41800  1 parport_pc
pcspkr                  3592  0
evdev                   9600  0
capability              4520  0
commoncap               7232  1 capability
xirc2ps_cs             19184  1
ds                     18756  6 serial_cs,xirc2ps_cs
pcmcia_core            70868  4 serial_cs,yenta_socket,xirc2ps_cs,ds
genrtc                  9588  0
ext2                   71848  0
ext3                  127304  1
jbd                    62616  1 ext3
mbcache                 9348  2 ext2,ext3
ide_generic             1408  0
piix                   13440  1
ide_disk               19296  3
ide_core              139908  3 ide_generic,piix,ide_disk
unix                   28756  158
font                    8320  0
vesafb                  6656  0
cfbcopyarea             3840  1 vesafb
cfbimgblt               3040  1 vesafb
cfbfillrect             3776  1 vesafb

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
