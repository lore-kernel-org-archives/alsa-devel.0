From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000796]: Behavior of LED on mute button
Date: Tue, 11 Jan 2005 12:11:10 +0100
Message-ID: <d28af536b6f6b27e5a21bc21d68f3d42@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0EA022DE
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2005 12:11:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=796> 
======================================================================
Reported By:                kempokaraterulz
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   796
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-09-2005 02:26 CET
Last Modified:              01-11-2005 12:11 CET
======================================================================
Summary:                    Behavior of LED on mute button
Description: 
On my laptop, there is this little blue LED on the mute button, muting  /
unmuting the sound doesnt have any effect on this LED currently, if i
unload the sound module the LED turns on, and if i reload the sound module
it turns back off. Since the sound driver turns the light on when being
unloaded, my (possibly incorrect) guess is that this would be a fairly
easy thing to implement properly, or at least allow control of the light
through the proc interface or something. 
======================================================================

----------------------------------------------------------------------
 kempokaraterulz - 01-10-05 23:17 
----------------------------------------------------------------------
The mute led is in fact turned on / off by the external amplifier mixer
switch, but the problem im having is that ac97_quirk doesnt appear to be a
valid option for the atiixp driver:

HPimp sound # modprobe snd-atiixp ac97_quirk=mute_led
HPimp sound # dmesg|tail -n3
usb-storage: device scan complete
snd_atiixp: Unknown parameter `ac97_quirk'
ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 5 (level, low) -> IRQ 5
HPimp sound # modinfo snd-atiixp
author:         Takashi Iwai <tiwai@suse.de>
description:    ATI IXP AC97 controller
license:        GPL
parm:           index:Index value for ATI IXP controller.
parm:           id:ID string for ATI IXP controller.
parm:           enable:Enable audio part of ATI IXP controller.
parm:           ac97_clock:AC'97 codec clock (default 48000Hz).
parm:           spdif_aclink:S/PDIF over AC-link.
vermagic:       2.6.10-gentoo-r1 preempt PENTIUM4 4KSTACKS gcc-3.3
depends:        snd-pcm,snd-page-alloc,snd-ac97-codec,snd,snd
alias:          pci:v00001002d00004341sv*sd*bc*sc*i*
alias:          pci:v00001002d00004361sv*sd*bc*sc*i*
alias:          pci:v00001002d00004370sv*sd*bc*sc*i*

its alsa driver 1.0.8rc2

----------------------------------------------------------------------
 tiwai - 01-11-05 12:11 
----------------------------------------------------------------------
Oh I forgot that atiixp still doesn't have this option.
Try the attached patch.
Also, please show the output of lspci -nv.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-09-05 02:26 kempokaraterulzNew Issue                                    
01-10-05 14:59 tiwai          Note Added: 0003135                          
01-10-05 23:17 kempokaraterulzNote Added: 0003140                          
01-11-05 12:11 tiwai          Note Added: 0003143                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
