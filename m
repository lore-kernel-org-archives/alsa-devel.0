From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000954]: no audible sound with AD1981B
Date: Wed, 9 Mar 2005 17:19:45 +0100
Message-ID: <2651205eef3857e9fadbd89f66f504b7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9DD84153
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2005 17:20:00 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=954> 
======================================================================
Reported By:                gismo
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   954
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian unstable
Kernel Version:             2.6.10 / 2.6.11-rc[24]
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-01-2005 14:20 CET
Last Modified:              03-09-2005 17:19 CET
======================================================================
Summary:                    no audible sound with AD1981B
Description: 
Already reported in the Debian BTS [1].

Since having upgraded to 1.0.8, I've no more audible sound on my
Debian. This happens on 2.6.10 and on 2.6.11-rc[24] (on the latest,
with or without the external compiled ALSA modules).

What is strange is that all is working as expected, but I cannot hear
the sound: if I launch the GNOME Volume Meter ('vumeter'), I can see
the bars moving when Rhythmbox is playing, indicating that there's
sound.

Obviously, all modules are correctly loaded (I don't use the OSS
emulation, but I tried with it and it doens't change anything) and the
volumes properly set and unmuted. As I've an IBM T42p, I unmuted the
volume via the tpb-enabled keys.

I guess the problem is something related to this ALSA bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=925 [2], but I
cannot find a solution (and actually I'm quite sure I don't have an
S/PDIF output).

Some useful info:
=====
gismo:/home/luca# lspci -v
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
 (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
        Subsystem: IBM: Unknown device 0537
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1c00 [size=256]
        I/O ports at 18c0 [size=64]
        Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
        Memory at c0000800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

gismo:/home/luca# cat /proc/asound/cards
0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                  Intel 82801DB-ICH4 with AD1981B at 0xc0000c00,
                  irq 11
=====

I just tried today CVS, but it didn't solve the problem.

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=297343
[2] https://bugtrack.alsa-project.org/alsa-bug/view.php?id=925

======================================================================

----------------------------------------------------------------------
 gismo - 03-01-05 14:23 
----------------------------------------------------------------------
I'm sorry, after having digged in the bug reports, it seems that my problem
is the same as ALSA bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14 [1]. Am I correct?

In this case, I don't know how to mark this bug as a duplicate of the
other...

[1] https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14

----------------------------------------------------------------------
 tiwai - 03-09-05 17:19 
----------------------------------------------------------------------
It might be a different matter.
Just turn off 'Headphone Jack Sense' and 'Line Jack Sense' mixer switches.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-01-05 14:20 gismo          New Issue                                    
03-01-05 14:20 gismo          Distribution              => Debian unstable 
03-01-05 14:20 gismo          Kernel Version            => 2.6.10 /
2.6.11-rc[24]
03-01-05 14:23 gismo          Note Added: 0003760                          
03-09-05 17:19 tiwai          Status                   new => resolved     
03-09-05 17:19 tiwai          Resolution               open => fixed       
03-09-05 17:19 tiwai          Assigned To               => tiwai           
03-09-05 17:19 tiwai          Note Added: 0003829                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
