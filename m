From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000366]: driver hangs when trying to load a soundfont >8MB
Date: Tue, 9 Nov 2004 16:34:24 +0100
Message-ID: <75f9890b0b5bd562dc5a5e1686371a2a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B394E2B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:34:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=366> 
======================================================================
Reported By:                deathpudding
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   366
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.7
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-05-2004 09:43 CEST
Last Modified:              11-09-2004 16:34 CET
======================================================================
Summary:                    driver hangs when trying to load a soundfont >8MB
Description: 
The alsa driver and the applications using it hang, unkillable and unable
to be unloaded, when I try to load a soundfont larger than 8MB. This
sometimes results in the appearance of a page fault message when shutting
down. The shutdown is never completed because the disk cannot be
unmounted, presumably because the alsa driver is still frozen while trying
load the soundfont from it.

I found a thread in the alsa-devel archives discussing this problem:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg12386.html

I see that the discussed patch has been applied, but I still have this
problem. I haven't tested with versions prior to 1.0.4 because they did
not compile with the later library version, but I do know that it was
working not too long ago (with kernel 2.6.x).
======================================================================

----------------------------------------------------------------------
 vlajsa - 09-22-04 12:05 
----------------------------------------------------------------------
This is even wierder! Upgrading to 2.6.9-rc2 with mm1 patch solved the
problem! At least for me!

----------------------------------------------------------------------
 tiwai - 09-22-04 18:12 
----------------------------------------------------------------------
Ok, then close this bug now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-05-04 09:43 deathpudding   New Issue                                    
07-05-04 09:43 deathpudding   Kernel Version            => 2.6.7           
07-10-04 20:39 vlajsa         Note Added: 0001404                          
07-10-04 21:45 deathpudding   Note Added: 0001405                          
07-12-04 13:31 pzad           Note Added: 0001409                          
07-12-04 23:02 deathpudding   Note Added: 0001411                          
07-12-04 23:03 deathpudding   Note Edited: 0001411                         
08-03-04 17:11 vlajsa         Note Added: 0001528                          
09-07-04 09:37 pzad           Note Added: 0001703                          
09-07-04 10:26 deathpudding   File Added: alsacrash.txt                    
09-07-04 10:31 deathpudding   Note Added: 0001705                          
09-07-04 18:21 vlajsa         Note Added: 0001724                          
09-07-04 18:25 vlajsa         Note Edited: 0001724                         
09-08-04 01:38 deathpudding   Note Added: 0001725                          
09-08-04 17:06 tiwai          Note Added: 0001732                          
09-09-04 03:46 deathpudding   Note Added: 0001740                          
09-09-04 03:49 deathpudding   Note Added: 0001741                          
09-09-04 04:30 deathpudding   Note Added: 0001742                          
09-13-04 15:45 tiwai          Note Added: 0001748                          
09-14-04 02:43 deathpudding   Note Added: 0001756                          
09-21-04 12:41 tiwai          Note Added: 0001800                          
09-22-04 12:05 vlajsa         Note Added: 0001811                          
09-22-04 18:12 tiwai          Status                   assigned => resolved
09-22-04 18:12 tiwai          Resolution               open => fixed       
09-22-04 18:12 tiwai          Note Added: 0001813                          
11-09-04 16:34 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
