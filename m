From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000169]: Oopses when closing alsaplayer
Date: Tue, 31 May 2005 17:56:49 +0200
Message-ID: <4a23f37892ed76592d3e12ba71e81ddb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 653961AF
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 17:56:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=169> 
======================================================================
Reported By:                palcolor
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   169
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               debian
Kernel Version:             2.6.5-rc2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-30-2004 13:16 CEST
Last Modified:              05-31-2005 17:56 CEST
======================================================================
Summary:                    Oopses when closing alsaplayer
Description: 
Hi all
I´m getting oopses (only and always) when closing alsaplayer. mpg123 or
dcd works fine. I've found these messages at the alsa-devel list:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg04024.html
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg03891.html

Seem to be the same problem than mine.


======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 12:44 
----------------------------------------------------------------------
Submitter: Are you still getting these oopsen?

----------------------------------------------------------------------
 palcolor - 03-30-05 19:32 
----------------------------------------------------------------------
The oopses are gone. They went to segfaults after a libc6 upgrade, and
dissappeared after a kernel upgrade. I can't tell you which kernel solved
the issue, sorry.
Thanks for your work
Pal

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-04 13:16 palcolor       New Issue                                    
03-30-04 13:16 palcolor       Distribution              => debian          
03-30-04 13:16 palcolor       Kernel Version            => 2.6.5-rc2       
03-30-04 14:40 perex          Note Added: 0000719                          
03-30-04 21:53 palcolor       File Added: ksymoops.txt                     
03-31-04 20:12 palcolor       File Added: Oops.text                        
03-31-04 20:13 palcolor       Note Added: 0000728                          
04-01-04 20:49 palcolor       Issue Monitored: palcolor                    
03-19-05 12:44 jdthood        Note Added: 0004038                          
03-30-05 19:32 palcolor       Note Added: 0004273                          
03-30-05 19:35 jdthood        Status                   new => resolved     
03-30-05 19:35 jdthood        Resolution               open => fixed       
05-31-05 17:56 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
