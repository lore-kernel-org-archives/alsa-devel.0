From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000581]: non-blocking write to alsa's OSS drivers eats data
Date: Thu, 18 Nov 2004 18:09:52 +0100
Message-ID: <41910d67706b8303925d3ed75de82081@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 737FF230
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 18:09:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=581> 
======================================================================
Reported By:                Benjamin Otte
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   581
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 duplicate
Duplicate:                  582
Fixed in Version:           
======================================================================
Date Submitted:             10-15-2004 15:35 CEST
Last Modified:              11-18-2004 18:09 CET
======================================================================
Summary:                    non-blocking write to alsa's OSS drivers eats data
Description: 
write() calls in non-blocking mode eat the written data and never return
-EAGAIN. The attached patch fixes the problem.

Signed-off-by: Benjamin Otte <otte@gnome.org>
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000582 non-blocking write to alsa's OSS driver...
======================================================================

----------------------------------------------------------------------
 Benjamin Otte - 10-15-04 15:40 
----------------------------------------------------------------------
Disregard this bug and close it please, it's not an alsalib bug. I've
refiled it as bug 582 for alsa-driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-15-04 15:35 Benjamin Otte  New Issue                                    
10-15-04 15:35 Benjamin Otte  File Added: dont-eat-data.diff                    
10-15-04 15:40 Benjamin Otte  Note Added: 0002167                          
10-18-04 17:27 tiwai          Status                   new => resolved     
10-18-04 17:27 tiwai          Resolution               open => duplicate   
10-18-04 17:27 tiwai          Relationship added       duplicate of 0000582
10-18-04 17:27 tiwai          Assigned To               => tiwai           
11-18-04 18:09 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
