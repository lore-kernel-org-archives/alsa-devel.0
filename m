From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000286]: Wrong MIDI I/O count in HDSP9632
Date: Tue, 1 Feb 2005 21:42:22 +0100
Message-ID: <8afcd669a732aed9a70bff9ee9775889@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A59831E7
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2005 21:42:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=286> 
======================================================================
Reported By:                penttiala
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - driver
Issue ID:                   286
Category:                   PCI - RME HDSP
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-20-2004 17:22 CEST
Last Modified:              02-01-2005 21:42 CET
======================================================================
Summary:                    Wrong MIDI I/O count in HDSP9632
Description: 
There is only one MIDI I/O in HDSP9632 but driver tells there is two.
======================================================================

----------------------------------------------------------------------
 charbonnel - 01-28-05 18:22 
----------------------------------------------------------------------
I just submitted a patch on alsa-devel that should solve the problem.
Sorry about the "soon" in my previous note :)

----------------------------------------------------------------------
 charbonnel - 02-01-05 21:42 
----------------------------------------------------------------------
Fixed in cvs, fix should appear in alsa > 1.0.8

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-20-04 17:22 penttiala      New Issue                                    
05-22-04 13:42 charbonnel     Note Added: 0001170                          
12-24-04 12:35 penttiala      Issue Monitored: penttiala                    
01-28-05 18:22 charbonnel     Note Added: 0003433                          
02-01-05 21:42 charbonnel     Status                   assigned => resolved
02-01-05 21:42 charbonnel     Resolution               open => fixed       
02-01-05 21:42 charbonnel     Note Added: 0003469                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
