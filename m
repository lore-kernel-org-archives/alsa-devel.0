From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000286]: Wrong MIDI I/O count in HDSP9632
Date: Fri, 28 Jan 2005 18:22:09 +0100
Message-ID: <cd6dc43ea21d3cbcab39157b1b318518@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 79B7E20A
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2005 18:22:09 +0100 (MET)
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
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-20-2004 17:22 CEST
Last Modified:              01-28-2005 18:22 CET
======================================================================
Summary:                    Wrong MIDI I/O count in HDSP9632
Description: 
There is only one MIDI I/O in HDSP9632 but driver tells there is two.
======================================================================

----------------------------------------------------------------------
 charbonnel - 05-22-04 13:42 
----------------------------------------------------------------------
Hi Pentti,

It will be fixed soon (the problem exists also for all hdsp cards with
only one midi port, e.g. multiface).

Thomas

----------------------------------------------------------------------
 charbonnel - 01-28-05 18:22 
----------------------------------------------------------------------
I just submitted a patch on alsa-devel that should solve the problem.
Sorry about the "soon" in my previous note :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-20-04 17:22 penttiala      New Issue                                    
05-22-04 13:42 charbonnel     Note Added: 0001170                          
12-24-04 12:35 penttiala      Issue Monitored: penttiala                    
01-28-05 18:22 charbonnel     Note Added: 0003433                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
