From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000875]: Can't get nm256 up & running
Date: Wed, 2 Feb 2005 12:46:02 +0100
Message-ID: <c6d57b53f929795aa9d04444161f803b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9F913211
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2005 12:46:02 +0100 (MET)
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
Last Modified:              02-02-2005 12:46 CET
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
 Jean-Louis Crouzet - 02-02-05 12:40 
----------------------------------------------------------------------
First many thanks for that so prompt answer, actually apreciated after a so
long period of solitude ;-)
I'm a real newbie somehow, I founded the FATAL:Error woth dmesg, but I'm
not sure how to narrow down my investigation. Any pointer for me on HowTo
do this?
Anticipated thanks.
JL

/...
PCI: Found IRQ 10 for device 0000:01:00.1
PCI: Sharing IRQ 10 with 0000:00:04.1
nm256: no ac97 is found!
  force the driver to load by passing in the module parameter
    force_ac97=1
  or try sb16 or cs423x drivers instead.
NeoMagic 256: probe of 0000:01:00.1 failed with error -6
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff
0xdc000-0xfffff
.../

----------------------------------------------------------------------
 tiwai - 02-02-05 12:46 
----------------------------------------------------------------------
As the driver told you, the chip has no AC97 codec but most likely it's
connected to another ISA codec chip.

Run alsaconf and proceed to probe legacy ISA device.  Then choose cs4232
and cs4236.  If it can't detect, check BIOS setting which parameters are
used.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
