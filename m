From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000230]: sound is bad when dma is enabled
Date: Wed, 23 Nov 2005 20:43:32 +0100
Message-ID: <2e7d4a46e55299908cf304291a8520bd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E832B1BA
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 20:43:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=230> 
======================================================================
Reported By:                Hetfield
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   230
Category:                   PCI - ens1370
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.x
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             04-23-2004 18:55 CEST
Last Modified:              11-23-2005 20:43 CET
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
 Hetfield - 11-01-05 19:06 
----------------------------------------------------------------------
seems now i got it **pretty** fixed.

what i did:
1) updated kernel to 2.6.14-git4
2) setted 100Hz instead of 250
3) setted latency to 0x40 (64) instead of old 0x20 (32)
4) disabled pci 2.1 in my bios.

you can mark as closed

----------------------------------------------------------------------
 rlrevell - 11-23-05 20:43 
----------------------------------------------------------------------
Seems to have been a hardware problem.

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
07-03-05 13:50 Hetfield       Note Added: 0005375                          
11-01-05 19:06 Hetfield       Note Added: 0006598                          
11-23-05 20:43 rlrevell       Status                   new => resolved     
11-23-05 20:43 rlrevell       Resolution               open => not an issue
11-23-05 20:43 rlrevell       Assigned To               => rlrevell        
11-23-05 20:43 rlrevell       Note Added: 0006830                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
