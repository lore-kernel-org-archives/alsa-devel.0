From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000230]: sound is bad when dma is enabled
Date: Wed, 23 Feb 2005 13:34:21 +0100
Message-ID: <2919fc28a5879009b5e111d7a4d06323@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4CE311E3
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 13:34:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=230> 
======================================================================
Reported By:                Hetfield
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   230
Category:                   PCI - ens1370
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.x
======================================================================
Date Submitted:             04-23-2004 18:55 CEST
Last Modified:              02-23-2005 13:34 CET
======================================================================
Summary:                    sound is bad when dma is enabled
Description: 
when dma is enabled for my harddisk sound is so bad

0000:00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev
01)
        Subsystem: Unknown device 4942:4c4c
        Flags: bus master, slow devsel, latency 248, IRQ 10
        I/O ports at b000

i setted latency to 248 but i tried lots of values, nothing changed.
interrupts are not shared.
disabling dma make sound clean.

with 2.6.x only...2.4.x works so good.
i tred with 2.6 integrated or external libs too, as module o builtin.
nothing changes.

how to fix that? should i disable busmaster or change devsel value? how?




======================================================================

----------------------------------------------------------------------
 Hetfield - 04-25-04 11:00 
----------------------------------------------------------------------
ok...please check the ens1370 code and i'll search and ask in kernel ml.

thx

----------------------------------------------------------------------
 Hetfield - 02-23-05 13:34 
----------------------------------------------------------------------
with 2.6.11-rc4 and alsa 1.0.8 i have the same errors.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-23-04 18:55 Hetfield       New Issue                                    
04-23-04 18:55 Hetfield       Kernel Version            => 2.6.x           
04-24-04 14:10 perex          Note Added: 0000924                          
04-24-04 14:10 perex          Severity                 major => tweak      
04-24-04 14:10 perex          Description Updated                          
04-25-04 11:00 Hetfield       Note Added: 0000937                          
02-23-05 13:34 Hetfield       Note Added: 0003710                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
