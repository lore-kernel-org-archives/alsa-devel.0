From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001841]: Mixer not working  / fujitsu laptop V2060 with HDA intel & AD1986A
Date: Mon, 13 Mar 2006 15:36:25 +0100
Message-ID: <45cf975248ce583534fd766204dd6344@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A14EC177
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 15:36:25 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0001531.
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
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-11-2006 14:13 CET
Last Modified:              03-13-2006 15:36 CET
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
related to          0001531 PCM output is muted most of the time
has duplicate       0001714 Intel HDA (AD1986A) no sound
======================================================================

----------------------------------------------------------------------
 fchevalier - 03-09-06 17:01 
----------------------------------------------------------------------
Looks like afterwards this is a duplicated of bug id 1531...

----------------------------------------------------------------------
 tiwai - 03-09-06 18:23 
----------------------------------------------------------------------
Could you check whether the attached patch works with "model=3stack" module
option?

----------------------------------------------------------------------
 tiwai - 03-09-06 18:25 
----------------------------------------------------------------------
Or, try "model=2ch" at first, then "model=3stack".

----------------------------------------------------------------------
 tiwai - 03-09-06 18:43 
----------------------------------------------------------------------
Forgot to add: the patch is to the latest ALSA CVS version.  Don't try it
with 1.0.11rc3.

----------------------------------------------------------------------
 kratz00 - 03-10-06 18:17 
----------------------------------------------------------------------
i have the same hardware (see bugid 1714) and i can confirm the patch
works
sound is better with "model=2ch" than "model=3stack"
with "model=3stack" the sound is really scratchy

----------------------------------------------------------------------
 tiwai - 03-10-06 18:25 
----------------------------------------------------------------------
Good to hear that something gets better.

Please provide the output of "lspci -nv" (only for the corresponding
device) to choose this model for your laptop as default.

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

----------------------------------------------------------------------
 fchevalier - 03-12-06 20:27 
----------------------------------------------------------------------
Hi guys,

Sorry for this late answer, but fact is that as was off to my parents
house for a long WE, with no Internet access of course :-(

Takashi, i tried your patch and it works FINE for my laptop too (Tested
PCM playback only). Model i used was model=2ch
By the way i had been working this WE on a patch of my own and was ready
to submit it to you :-). I attached it anyway so that you can grab my
vendor/device id.

HOWEVER,
Using my patch i never got microphone to work properly, and for now i
don't have any microphone under my hands anymore to test your patch, its
too bad :-(

Some more random comments to further improbe things on a laptop
configuration:
 - For what i've tried, Headphone volume is useless. Headphone volume is
the same as Front DAC. (==>remove it from mixer list ??)
 - PC speaker is not connected to anything (==>remove it from mixer list
??)
 - Is stereo downmix switch usefull on a 2ch configutation ? (It might be
a dumb question, i'm not familiar to this stuff ;-) )
 - I'm not sure if mono input is usefull.


By the way here the decription of the connectivity on my laptop:
 - A set of speakers, obviously connected to Front DAC.
 - A microphone input
 - A line in input
 - A headset output
 - A SPDIF output 
 ... and that' all :-)

Many thanks for the good work anyway !!

----------------------------------------------------------------------
 tiwai - 03-13-06 15:27 
----------------------------------------------------------------------
Applied the fixed patch to CVS.

Let's close this bug once.  For a problem with recording, please open
another bug.  The bug might have been fixed by my recent udpates.  Try CVS
version at first.

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
03-12-06 20:27 fchevalier     Note Added: 0008434                          
03-12-06 20:28 fchevalier     File Added: patch_analog_ad1986a_laptop.diff      
             
03-13-06 15:27 tiwai          Status                   assigned => resolved
03-13-06 15:27 tiwai          Resolution               open => fixed       
03-13-06 15:27 tiwai          Note Added: 0008445                          
03-13-06 15:36 tiwai          Relationship added       related to 0001531  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
