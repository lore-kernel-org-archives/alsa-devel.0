From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001115]: codec_semaphore: semaphore is not ready [0x1][0x1300]
Date: Mon, 23 May 2005 17:09:42 +0200
Message-ID: <b9bf7416bb5cf6be7b001439306b08cb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2E1EA20A
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2005 17:09:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1115> 
======================================================================
Reported By:                keinstein
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1115
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-18-2005 16:53 CEST
Last Modified:              05-23-2005 17:09 CEST
======================================================================
Summary:                    codec_semaphore: semaphore is not ready
[0x1][0x1300]
Description: 
I'm using a Laptop with sis630 chipset. The sound works with the
snd-trident driver, but the modem seems to be a SIS 7013. 

When loading the modem I get error messages. In the log file I find the
following information:
May 18 16:48:23 tobias1 kernel: ACPI: PCI interrupt 0000:00:01.6[C] -> GSI
10 (level, low) -> IRQ 10
May 18 16:48:23 tobias1 kernel: codec_semaphore: semaphore is not ready
[0x1][0x1300]
May 18 16:48:23 tobias1 last message repeated 378 times
May 18 16:48:23 tobias1 kernel: AC'97 1 does not respond - RESET
May 18 16:48:23 tobias1 kernel: codec_semaphore: semaphore is not ready
[0x1][0x1300]
May 18 16:48:23 tobias1 kernel: codec_semaphore: semaphore is not ready
[0x1][0x1300]
May 18 16:48:23 tobias1 kernel: AC'97 1 access is not valid [0xffffffff],
removing mixer.
May 18 16:48:23 tobias1 kernel: Unable to initialize codec
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
May 18 16:48:23 tobias1 kernel: Intel ICH Modem: probe of 0000:00:01.6
failed with error -5


Loading before the trident driver does not help.
======================================================================

----------------------------------------------------------------------
 sashak - 05-19-05 21:42 
----------------------------------------------------------------------
Looks like semaphore policy missunderstanding between 'trident' and
'intel8x0m' drivers. Could you test with 'intel8x0' + 'intel8x0m'  instead
of  'trident' + 'intel8x0m' (probably after cold reboot)? ('intel8x0'
supports SiS audio as well).

----------------------------------------------------------------------
 keinstein - 05-23-05 17:09 
----------------------------------------------------------------------
Using snd-intel8x0 instead of snd-trident doesn't produce any audio at
all.  That isn't very surprising to me.  Yes, both modules support the
SIS audio, but they don't claim to support the same devices, as modinfo
tells you.  (snd-intel8x0 works on my sisters SIS 650(?) chipset, where
trident doesn't work).

tobias@tobias1:~$ /sbin/modinfo snd-trident|grep 1039
alias:          pci:v00001039d00007018sv*sd*bc*sc*i*
tobias@tobias1:~$ /sbin/modinfo snd-intel8x0|grep 1039
alias:          pci:v00001039d00007012sv*sd*bc*sc*i*
tobias@tobias1:~$ /sbin/modinfo snd-intel8x0m|grep 1039
alias:          pci:v00001039d00007013sv*sd*bc*sc*i*

slmodemd is still complaining about missing modem device, but I didn't
see the semaphore error after cold reboot.  Well, I didn't really try to
get slmodemd running, as I would miss the sound much more than the
modem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-18-05 16:53 keinstein      New Issue                                    
05-19-05 21:42 sashak         Note Added: 0004695                          
05-23-05 17:09 keinstein      Note Added: 0004704                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
