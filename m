From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000670]: soundmax integrated digital not working in slack 10
Date: Wed, 24 Nov 2004 17:54:47 +0100
Message-ID: <f941bc984dee7c03746951f5817a1967@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4D2FD2E3
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 17:54:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=670> 
======================================================================
Reported By:                michaelhoy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   670
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               slackware
Kernel Version:             2.4.26
======================================================================
Date Submitted:             11-24-2004 00:55 CET
Last Modified:              11-24-2004 17:54 CET
======================================================================
Summary:                    soundmax integrated digital not working in slack 10
Description: 
basically the sound card won't work with alsa. below is an email to lee a
developer he recommended i submit this as a bug fix. please read the
'additional information section' if this is not the correct way of
submitting a bug fix i apologize as this is my first.
======================================================================

----------------------------------------------------------------------
 michaelhoy - 11-24-04 17:48 
----------------------------------------------------------------------
you wanted to know what was in /dev/snd?

i do not know what should be there so I simply pasted the contents of it
all here. thanks.
mike h

root@slackware:~# ls /dev/snd
controlC0  hwC2D0    midiC0D4  midiC2D0  midiC3D4  pcmC0D4c  pcmC1D2c 
pcmC2D0c  pcmC2D6c  pcmC3D4c
controlC1  hwC2D1    midiC0D5  midiC2D1  midiC3D5  pcmC0D4p  pcmC1D2p 
pcmC2D0p  pcmC2D6p  pcmC3D4p
controlC2  hwC2D2    midiC0D6  midiC2D2  midiC3D6  pcmC0D5c  pcmC1D3c 
pcmC2D1c  pcmC2D7c  pcmC3D5c
controlC3  hwC2D3    midiC0D7  midiC2D3  midiC3D7  pcmC0D5p  pcmC1D3p 
pcmC2D1p  pcmC2D7p  pcmC3D5p
hwC0D0     hwC3D0    midiC1D0  midiC2D4  pcmC0D0c  pcmC0D6c  pcmC1D4c 
pcmC2D2c  pcmC3D0c  pcmC3D6c
hwC0D1     hwC3D1    midiC1D1  midiC2D5  pcmC0D0p  pcmC0D6p  pcmC1D4p 
pcmC2D2p  pcmC3D0p  pcmC3D6p
hwC0D2     hwC3D2    midiC1D2  midiC2D6  pcmC0D1c  pcmC0D7c  pcmC1D5c 
pcmC2D3c  pcmC3D1c  pcmC3D7c
hwC0D3     hwC3D3    midiC1D3  midiC2D7  pcmC0D1p  pcmC0D7p  pcmC1D5p 
pcmC2D3p  pcmC3D1p  pcmC3D7p
hwC1D0     midiC0D0  midiC1D4  midiC3D0  pcmC0D2c  pcmC1D0c  pcmC1D6c 
pcmC2D4c  pcmC3D2c  seq
hwC1D1     midiC0D1  midiC1D5  midiC3D1  pcmC0D2p  pcmC1D0p  pcmC1D6p 
pcmC2D4p  pcmC3D2p  timer
hwC1D2     midiC0D2  midiC1D6  midiC3D2  pcmC0D3c  pcmC1D1c  pcmC1D7c 
pcmC2D5c  pcmC3D3c
hwC1D3     midiC0D3  midiC1D7  midiC3D3  pcmC0D3p  pcmC1D1p  pcmC1D7p 
pcmC2D5p  pcmC3D3p
root@slackware:~#

----------------------------------------------------------------------
 tiwai - 11-24-04 17:54 
----------------------------------------------------------------------
The kernel should have shown any error/warning messages when you load
snd-atiixp module.  If so, it's either a BIOS problem or a well-known ACPI
problem.

I'd recommend you to play with different boot options related with ACPI. 
(Check other bug entries about atiixp.)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 00:55 michaelhoy     New Issue                                    
11-24-04 00:55 michaelhoy     Distribution              => slackware       
11-24-04 00:55 michaelhoy     Kernel Version            => 2.4.26          
11-24-04 12:18 tiwai          Note Added: 0002547                          
11-24-04 17:48 michaelhoy     Note Added: 0002573                          
11-24-04 17:54 tiwai          Note Added: 0002574                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
