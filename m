From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000169]: Oopses when closing alsaplayer
Date: Sat, 19 Mar 2005 12:44:52 +0100
Message-ID: <18dcfc2199da6c0cbac05494a4b23c40@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 59C741D8
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 12:44:52 +0100 (MET)
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
Status:                     new
Distribution:               debian
Kernel Version:             2.6.5-rc2
======================================================================
Date Submitted:             03-30-2004 13:16 CEST
Last Modified:              03-19-2005 12:44 CET
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
 palcolor - 03-31-04 20:13 
----------------------------------------------------------------------
Uploaded the Oops and ksymoops output.

----------------------------------------------------------------------
 jdthood - 03-19-05 12:44 
----------------------------------------------------------------------
Submitter: Are you still getting these oopsen?

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
