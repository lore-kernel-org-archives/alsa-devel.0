From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001662]: No audio output in a laptop
	with hda-intel....
Date: Fri, 21 Jul 2006 09:48:58 +0200
Message-ID: <2fcffeb8d5e057a1ea26a87bd4ecbbcb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2CE6717A
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Jul 2006 09:48:59 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1662> 
======================================================================
Reported By:                shl
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1662
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Gentoo Linux
Kernel Version:             2.6.13.4
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             12-20-2005 11:18 CET
Last Modified:              07-21-2006 09:48 CEST
======================================================================
Summary:                    No audio output in a laptop with hda-intel....
Description: 
Hy, I managed to install the hda-intel on my laptop but my big problem is
:
The speakers inside the laptop work correctly but everytime I try to plug
a headset or some external speaker in the output used normally for it, I'd
the same result : no sound in the laptop'speakers AND no sound at all in
the external speakers. So after looking a long long time about that
problem, I didn't find anything. So maybe the function is not yet
implemented ? If it's the case, is it possible to do it because it'll be
very usefull for a lot of people ! Thanks for advance and don't hesitate
to send me a mail if I missed something ...


======================================================================

----------------------------------------------------------------------
 nutz - 03-08-06 20:44 
----------------------------------------------------------------------
okay here it goes:
# lspci -vs 00:1b.0
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)
        Subsystem: ASUSTeK Computer Inc. Unknown device 1173
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at febf8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)


# lspci -vns 00:1b.0
00:1b.0 0403: 8086:2668 (rev 04)
        Subsystem: 1043:1173
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at febf8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)



thanks again

----------------------------------------------------------------------
 tiwai - 03-09-06 13:09 
----------------------------------------------------------------------
Hm, the entry for your laptop is already registered to use the model "asus"
in the recent versions.  Did you try 1.0.11rc3 or CVS version?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-05 11:18 shl            New Issue                                    
12-20-05 11:18 shl            Distribution              => Gentoo Linux    
12-20-05 11:18 shl            Kernel Version            => 2.6.13.4        
12-20-05 11:19 shl            Issue Monitored: shl                         
12-20-05 11:19 shl            Issue End Monitor: shl                       
12-23-05 01:59 shl            Issue Monitored: shl                         
12-23-05 02:04 shl            Note Added: 0007130                          
01-08-06 13:54 JeanJean       Note Added: 0007525                          
01-08-06 14:06 JeanJean       Note Edited: 0007525                         
03-04-06 03:32 nutz           Note Added: 0008345                          
03-04-06 10:45 er-ku          Note Added: 0008347                          
03-04-06 10:48 er-ku          Note Edited: 0008347                         
03-04-06 10:49 er-ku          Note Edited: 0008347                         
03-04-06 10:56 er-ku          Note Edited: 0008347                         
03-08-06 20:44 nutz           Note Added: 0008384                          
03-09-06 13:09 tiwai          Note Added: 0008390                          
07-21-06 09:48 Adrian Bunk    Status                   assigned => closed  
07-21-06 09:48 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
