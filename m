From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000582]: non-blocking write to alsa's OSS drivers eats data
Date: Thu, 18 Nov 2004 18:10:46 +0100
Message-ID: <03ff972c872c73aa01c24bf2552bc39f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6238E230
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 18:10:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=582> 
======================================================================
Reported By:                Benjamin Otte
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   582
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-15-2004 15:39 CEST
Last Modified:              11-18-2004 18:10 CET
======================================================================
Summary:                    non-blocking write to alsa's OSS drivers eats data
Description: 
write() calls in non-blocking mode eat the written data and never return
-EAGAIN. The attached patch fixes the problem.

Signed-off-by: Benjamin Otte <otte@gnome.org>
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000581 non-blocking write to alsa's OSS driver...
======================================================================

----------------------------------------------------------------------
 tiwai - 10-18-04 17:55 
----------------------------------------------------------------------
Thanks, the patch was applied to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-15-04 15:39 Benjamin Otte  New Issue                                    
10-15-04 15:39 Benjamin Otte  File Added: dont-eat-data.diff                    
10-18-04 17:27 tiwai          Relationship added       has duplicate 0000581
10-18-04 17:55 tiwai          Status                   new => resolved     
10-18-04 17:55 tiwai          Resolution               open => fixed       
10-18-04 17:55 tiwai          Assigned To               => tiwai           
10-18-04 17:55 tiwai          Note Added: 0002197                          
11-18-04 18:10 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
