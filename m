From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000234]: Sound problems with APM Suspend/Resume on HP Omnibook 4150
Date: Wed, 1 Mar 2006 01:02:15 +0100
Message-ID: <e3560875e05925016fd15cc9deb915a9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1A7911C1
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 01:02:15 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=234> 
======================================================================
Reported By:                mtvoid
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   234
Category:                   ISA - ad1848
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.5
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-26-2004 10:09 CEST
Last Modified:              03-01-2006 01:02 CET
======================================================================
Summary:                    Sound problems with APM Suspend/Resume on HP
Omnibook 4150
Description: 
I have an HP Omnibook 4150 notebook. It is reported to have a Crystal Sound
chipset, and sound support works with both the CS423x and the AD1848
driver modules. I am using the snd-ad1848 driver with the following
settings: port=0x534 irq=7 dma1=1. The sound works alright with this, but
it seems the driver has trouble dealing with a system that has resumed
from an APM suspend state. After resuming, the sound samples play with
breaks and repetitions. Often, the following is printed into the syslog:
kernel: mce_down [0x534]: serious init problem - codec still busy

Note: This is observed even if I do not load any sound modules at bootup,
do a suspend/resume, and then load the drivers. It seems that after
resume, the card is put in a state different from before, which the driver
is unable to handle.
======================================================================

----------------------------------------------------------------------
 mtvoid - 04-04-05 16:14 
----------------------------------------------------------------------
I now use the snd-cs4232 module. Sound plays fine, but the system cannot
recover from a suspend with it, even if all sound modules have been
unloaded beforehand. This doesn't bother me that much now, because I use
the Software Suspend 2 patch to hibernate my system, and sound continues
to work after resuming from hibernation. But the drivers do have problems
handling APM suspend/resume on the Omnibook 4150.

This is printed into the syslog when I do a modprobe snd-cs4232:
kernel: ALSA sound/isa/cs423x/cs4231_lib.c:1053: cs4231: port = 0x534, id
= 0xa
kernel: ALSA sound/isa/cs423x/cs4231_lib.c:1059: CS4231: VERSION (I25) =
0x80
kernel: ALSA sound/isa/cs423x/cs4231_lib.c:386: cs4231_mce_down - auto
calibration time out (1)

Let me know if there is any diagnostic / debugging information that I can
provide to further help with this issue.

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:52 
----------------------------------------------------------------------
Any improvement with later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-04 10:09 mtvoid         New Issue                                    
04-26-04 10:09 mtvoid         Kernel Version            => 2.6.5           
04-03-05 20:01 jdthood        Note Added: 0004315                          
04-04-05 16:14 mtvoid         Note Added: 0004326                          
12-30-05 04:52 rlrevell       Note Added: 0007227                          
03-01-06 01:02 rlrevell       Status                   new => closed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
