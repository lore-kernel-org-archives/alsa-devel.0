From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000875]: Can't get nm256 up & running
Date: Wed, 16 Mar 2005 14:53:35 +0100
Message-ID: <55d7ac5455aab67d21d954b9383f1bdd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5A194211
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 14:53:35 +0100 (MET)
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
Last Modified:              03-16-2005 14:53 CET
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
 tiwai - 03-16-05 12:27 
----------------------------------------------------------------------
force_ac97 won't work anyway.

Now you wrote it doesn't work -- you mean lock up?

----------------------------------------------------------------------
 Jean-Louis Crouzet - 03-16-05 14:53 
----------------------------------------------------------------------
Hi Tiwai,

all my appologizes for being unclear in my last note. I meant I succeed to
remove the force_ac97 from my module option. But even then, the module is
never correctly loaded therefore any playing with alsaconf always end the
same.

# lsmod
Module                  Size  Used by
serial_cs               5276  1
apm                    12972  2
uhci_hcd               24016  0
usbcore                76964  3 uhci_hcd
intel_agp              13888  1
snd_nm256              62568  0
snd_ac97_codec         57220  1 snd_nm256
snd_pcm_oss            49448  0
snd_mixer_oss          15648  1 snd_pcm_oss
snd_pcm                73448  2 snd_nm256,snd_pcm_oss
snd_page_alloc          6088  1 snd_pcm
snd_timer              16836  1 snd_pcm
snd                    40612  6
snd_nm256,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               3648  1 snd
xirc2ps_cs             12784  1
genrtc                  5524  0
ext3                   93256  1
jbd                    39032  1 ext3
mbcache                 3716  1 ext3
piix                    8800  1
unix                   16276  32

#alsaconf -L logalsa
Unloading ALSA sound driver modules: snd-nm256 snd-ac97-codec snd-pcm-oss
snd-mixer-oss snd-pcm snd-page-alloc snd-timer.
Building card database...


Running update-modules...
Loading driver...
Setting up ALSA...done.
Setting default volumes...
Saving the mixer setup used for this in /var/lib/alsa/asound.state.
/usr/sbin/alsactl: save_state:1194: No soundcards found...


===============================================================================

 Now ALSA is ready to use.
 For adjustment of volumes, use your favorite mixer.

 Have a lot of fun!

Hoping this is clearer? As far as I can understand the situation, the
problem is first located in this nm256 module or any associated file.
Obviously no one will ever have a loock into those jurassic ages for basic
operation. This is why I definitely appreciate your permanent effort.
Tkx,

JL

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
03-16-05 08:50 Jean-Louis CrouzetNote Added: 0003934                          
03-16-05 11:26 Jean-Louis CrouzetNote Added: 0003937                          
03-16-05 12:27 tiwai          Note Added: 0003940                          
03-16-05 14:53 Jean-Louis CrouzetNote Added: 0003960                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
