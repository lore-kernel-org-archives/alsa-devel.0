From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002049]: No sound output on Sony Vaio
	PCG FR130
Date: Thu, 27 Jul 2006 16:15:24 +0200
Message-ID: <4b76a7aba54137e35a73654135051932@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CAA9521F
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Jul 2006 16:15:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2049> 
======================================================================
Reported By:                gerd94706
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2049
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             04-21-2006 04:43 CEST
Last Modified:              07-27-2006 16:15 CEST
======================================================================
Summary:                    No sound output on Sony Vaio PCG FR130
Description: 
The driver compiles & loads fine, but sound output does not work.
Don't recall if the sound output was choppy or not-present, since it's
been a while since I last tried.

======================================================================

----------------------------------------------------------------------
 gerd94706 - 04-21-06 06:00 
----------------------------------------------------------------------
Sorry, I selected the wrong Category.
This is what happens if you file a trouble-ticker just from memory.
I believe it was the via-something drier, not cs46xx.
Anyway, I looked it up at the time (whatever PCI id fit) and it loaded
and
recognized the chip. Just the sound-output didn't work!

----------------------------------------------------------------------
 tiwai - 04-25-06 17:40 
----------------------------------------------------------------------
The description is too ambiguous (what is via-something?).
Which driver did you try exactly?  Did you unmute and adjust mixer
properly after loading the driver?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-06 04:43 gerd94706      New Issue                                    
04-21-06 06:00 gerd94706      Note Added: 0009407                          
04-25-06 17:40 tiwai          Note Added: 0009492                          
07-27-06 16:15 Adrian Bunk    Status                   new => closed       
07-27-06 16:15 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
