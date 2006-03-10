From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001841]: Mixer not working  / fujitsu laptop V2060 with HDA intel & AD1986A
Date: Fri, 10 Mar 2006 23:12:18 +0100
Message-ID: <9b0ebd05609b47e313d11404409af7a6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4FB31192
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2006 23:12:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1841> 
======================================================================
Reported By:                fchevalier
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1841
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-11-2006 14:13 CET
Last Modified:              03-10-2006 23:12 CET
======================================================================
Summary:                    Mixer not working  / fujitsu laptop V2060 with HDA
intel & AD1986A
Description: 
Hi all,

I am unable to use mixer settings on my laptop.
Basically ALSA correctly detects HDA intel, Analog device chip. Mixer
settings are there but changing volume, muting/unmuting does not make any
difference. Playing  mp3 file with xmms sometimes i can hear some sound,
but not loud enough.
I tried with the latest ALSA version available, still not luck :-(

Can anyone help ?

Fabien
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001714 Intel HDA (AD1986A) no sound
======================================================================

----------------------------------------------------------------------
 kratz00 - 03-10-06 20:28 
----------------------------------------------------------------------
root@hermes:~# lspci -s 00:1b.0
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 03)
root@hermes:~# lspci -s 00:1b.0 -nv
00:1b.0 0403: 8086:2668 (rev 03)
        Subsystem: 144d:c01e
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at 80000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

----------------------------------------------------------------------
 kratz00 - 03-10-06 23:12 
----------------------------------------------------------------------
not the right place, I know

but i tried teamspeak and i could hear people but recording didn't work so
they didn't hear me
any ideas or information you would need to solve this problem?

now i'm trying to get this hda softmodem to work :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-11-06 14:13 fchevalier     New Issue                                    
03-09-06 17:01 fchevalier     Note Added: 0008392                          
03-09-06 18:23 tiwai          Note Added: 0008393                          
03-09-06 18:24 tiwai          File Added: ad1986a-fix.diff                    
03-09-06 18:25 tiwai          Note Added: 0008394                          
03-09-06 18:43 tiwai          Note Added: 0008395                          
03-10-06 18:17 kratz00        Note Added: 0008406                          
03-10-06 18:25 tiwai          Note Added: 0008407                          
03-10-06 18:26 tiwai          Relationship added       has duplicate 0001714
03-10-06 20:28 kratz00        Note Added: 0008410                          
03-10-06 23:12 kratz00        Note Added: 0008412                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
