From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000671]: ALSA sound cuts out w/ message: ALSA sound/pci/via82xx.c:737: invalid via82xx_cur_ptr, using last valid pointer
Date: Thu, 16 Dec 2004 17:53:35 +0100
Message-ID: <3d94cb9ed132c75c8d43546042dc30d4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 77529244
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 17:53:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=671> 
======================================================================
Reported By:                brentcfisher
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   671
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             11-24-2004 06:36 CET
Last Modified:              12-16-2004 17:53 CET
======================================================================
Summary:                    ALSA sound cuts out w/ message: ALSA
sound/pci/via82xx.c:737: invalid via82xx_cur_ptr, using last valid pointer
Description: 
Particularily noticeable when watching a DVD via xine using AC3 Pass
Through.  Sound will cut out momentarily (usually for no more than a
second).  The skip is always accompanied by multiples of this message in
the /var/log/messages file:

Nov 23 22:33:06 hostname ALSA sound/pci/via82xx.c:737: invalid
via82xx_cur_ptr, using last valid pointer
Nov 23 22:33:06 hostname ALSA sound/pci/via82xx.c:737: invalid
via82xx_cur_ptr, using last valid pointer
Nov 23 22:33:06 hostname ALSA sound/pci/via82xx.c:737: invalid
via82xx_cur_ptr, using last valid pointer

These messages appear in the log file once or twice a minute although the
sound only noticable cuts out every few minutes .  Very annoying on an
HTPC.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-15-04 16:13 
----------------------------------------------------------------------
Let's try take 4.

----------------------------------------------------------------------
 brentcfisher - 12-16-04 17:53 
----------------------------------------------------------------------
Takashi,

I dare say that it looks like you've done it!  I've watched a little over
an hour's worth of video and there hasn't been a single bump in the sound.
 Nor has there been a complaint in the error log!

Outstanding!

-Brent

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 06:36 brentcfisher   New Issue                                    
11-24-04 06:36 brentcfisher   Distribution              => Gentoo          
11-24-04 06:36 brentcfisher   Kernel Version            => 2.6.8.1         
11-24-04 06:47 brentcfisher   Note Added: 0002541                          
11-24-04 06:48 brentcfisher   Issue Monitored: brentcfisher                    
11-24-04 23:50 squarooticus   Note Added: 0002584                          
11-25-04 01:59 brentcfisher   Note Added: 0002585                          
11-25-04 06:45 squarooticus   Note Added: 0002586                          
12-02-04 19:34 tiwai          Note Added: 0002694                          
12-06-04 02:24 brentcfisher   Note Added: 0002725                          
12-07-04 18:24 tiwai          Note Added: 0002753                          
12-07-04 18:24 tiwai          File Added: via-pointer-fix.diff                  
 
12-08-04 05:03 brentcfisher   Note Added: 0002774                          
12-08-04 12:13 tiwai          Note Added: 0002779                          
12-08-04 16:33 brentcfisher   Note Added: 0002786                          
12-08-04 16:35 tiwai          Note Added: 0002787                          
12-08-04 16:36 tiwai          File Added: via-pointer-fix2.diff                 
  
12-08-04 17:02 brentcfisher   Note Added: 0002789                          
12-09-04 15:35 tiwai          Note Added: 0002803                          
12-09-04 15:35 tiwai          File Added: via-pointer-fix3.diff                 
  
12-10-04 16:59 brentcfisher   Note Added: 0002807                          
12-11-04 23:30 brentcfisher   Note Added: 0002812                          
12-12-04 03:14 squarooticus   Issue Monitored: squarooticus                    
12-12-04 03:14 squarooticus   Issue End Monitor: squarooticus                   

12-15-04 16:13 tiwai          Note Added: 0002827                          
12-15-04 16:13 tiwai          File Added: via-pointer-fix4.diff                 
  
12-16-04 17:53 brentcfisher   Note Added: 0002831                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
