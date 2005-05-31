From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000067]: Alsa sound repeats first half a second over and over
Date: Tue, 31 May 2005 18:02:11 +0200
Message-ID: <a32754724d8dd0211733c2d735cbfdff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2DCD21C8
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:02:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=67> 
======================================================================
Reported By:                trejkaz
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   67
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.2
Resolution:                 suspended
Fixed in Version:           
======================================================================
Date Submitted:             02-17-2004 10:05 CET
Last Modified:              05-31-2005 18:02 CEST
======================================================================
Summary:                    Alsa sound repeats first half a second over and over
Description: 
When playing a sound with /usr/bin/aplay, it will play the first half a
second and repeat the same fragment of the file over and over.

Playing with /usr/bin/play, it repeats every second instead.
======================================================================

----------------------------------------------------------------------
 trejkaz - 02-26-04 13:47 
----------------------------------------------------------------------
Okay, I'll take this up with the kernel team.  Although I noticed Kernel
2.6.3 had a whole bunch of fixes which may or may not be relevant anyway,
I just need to get it to compile. ;-)

----------------------------------------------------------------------
 perex - 03-14-04 19:50 
----------------------------------------------------------------------
No further response from user.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-04 10:05 trejkaz        New Issue                                    
02-17-04 10:09 trejkaz        Issue Monitored: trejkaz                     
02-17-04 10:10 trejkaz        Note Added: 0000249                          
02-17-04 18:49 tiwai          Note Added: 0000258                          
02-17-04 22:04 trejkaz        Note Added: 0000261                          
02-26-04 12:06 perex          Note Added: 0000339                          
02-26-04 13:47 trejkaz        Note Added: 0000349                          
03-14-04 19:50 perex          Status                   new => resolved     
03-14-04 19:50 perex          Resolution               open => suspended   
03-14-04 19:50 perex          Assigned To               => perex           
03-14-04 19:50 perex          Note Added: 0000603                          
05-31-05 18:02 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
