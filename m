From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000234]: Sound problems with APM Suspend/Resume on HP Omnibook 4150
Date: Fri, 30 Dec 2005 04:52:52 +0100
Message-ID: <3bc31efb57b3861d7bb51530e8d8a0dd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5BF221A3
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:52:52 +0100 (MET)
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
Status:                     new
Distribution:               
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-26-2004 10:09 CEST
Last Modified:              12-30-2005 04:52 CET
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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
