From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002300]: No sound with module
	snd-hda-intel but alsa mixer works
Date: Wed, 2 Aug 2006 14:25:36 +0200
Message-ID: <f58b599db23a628f466288da1c50d2da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3802A16F
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Aug 2006 14:25:37 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2300> 
======================================================================
Reported By:                jredrejo
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2300
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.16
======================================================================
Date Submitted:             07-24-2006 15:04 CEST
Last Modified:              08-02-2006 14:25 CEST
======================================================================
Summary:                    No sound with module snd-hda-intel but alsa mixer
works
Description: 
I have last alsa stable release and tried also with 1.0.12rc1 with the same
results: The sound seems to be configured but I get no sound output.
These are some of my data:
# cat /sys/module/snd_hda_intel/parameters/model
<NULL>
 lspci -nvd 8086:2668
0000:00:1b.0 0403: 8086:2668 (rev 04)
        Subsystem: 1025:007b
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at d000c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] #10 [0091]

linex-bcMnHH:/opt/zend# lspci -vd 8086:2668
0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 04)
        Subsystem: Acer Incorporated [ALI]: Unknown device 007b
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at d000c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] #10 [0091]

======================================================================

----------------------------------------------------------------------
 jredrejo - 08-02-06 14:25 
----------------------------------------------------------------------
I've attached the file alsa2.txt containing the output of:
cat /proc/asound/card0/codec#0>alsa2.txt

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-24-06 15:04 jredrejo       New Issue                                    
07-24-06 15:04 jredrejo       Kernel Version            => 2.6.16          
08-02-06 14:25 jredrejo       File Added: alsa2.txt                        
08-02-06 14:25 jredrejo       Note Added: 0011386                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
