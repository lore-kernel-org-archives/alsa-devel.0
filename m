From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000666]: Simply no sound ... no line ... no mixer
Date: Thu, 9 Dec 2004 11:34:10 +0100
Message-ID: <9593cfbfe36e92abb2cab1a0454bd2f5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9FC4532A
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2004 11:34:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=666> 
======================================================================
Reported By:                footcow
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   666
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-23-2004 01:31 CET
Last Modified:              12-09-2004 11:34 CET
======================================================================
Summary:                    Simply no sound ... no line ... no mixer
Description: 
I have compiled the last release : 1.0.7 stable.
But I do not have any sound, no line ... no mixer ... :(

I have an AsusTek P5GD2 motherboard with lspci -v :
0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 813d
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at cccf4000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70]
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=10 [0091]


The snd_azx module is well loaded :
lsmod : 
snd_azx                30920  1
snd_pcm                95112  1 snd_azx
snd_timer              25476  1 snd_pcm
snd                    54500  5 snd_azx,snd_pcm,snd_timer
snd_page_alloc         10120  1 snd_pcm

If I run alsamixer I get this :
$ alsamixer
No mixer elems found

If I run alsamixergui, I get 3 columns:
Line is emplty and can't change
Same for Mic
I can only move values for a third column called Capt.

======================================================================

----------------------------------------------------------------------
 tiwai - 12-09-04 11:27 
----------------------------------------------------------------------
Please write how did you get the error (what did you run exactly).

Also, compile with --with-debug=detect option.  This will show more
information in the kernel message.  At least, I need to know which format
is used.

Perhaps it's because the audio-out widget doesn't have the overriding
rates and formats information.

----------------------------------------------------------------------
 tiwai - 12-09-04 11:34 
----------------------------------------------------------------------
Try the attached patch.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-04 01:31 footcow        New Issue                                    
11-23-04 01:31 footcow        Distribution              => Debian          
11-23-04 01:31 footcow        Kernel Version            => 2.6.9           
11-23-04 21:49 footcow        Note Added: 0002530                          
12-08-04 19:54 tiwai          Note Added: 0002791                          
12-08-04 23:56 footcow        Note Added: 0002795                          
12-09-04 11:27 tiwai          Note Added: 0002799                          
12-09-04 11:33 tiwai          File Added: hda-query-fix.diff                    
12-09-04 11:34 tiwai          Note Added: 0002800                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
