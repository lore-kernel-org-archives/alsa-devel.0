From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000874]: Opening hdspmixer causes dropouts in audio
Date: Tue, 1 Feb 2005 20:55:21 +0100
Message-ID: <ace7ef75dd854fc9a1fbc5fe242ba0c4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EA32D201
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2005 20:55:21 +0100 (MET)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=874> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - driver
Issue ID:                   874
Category:                   OTHERS
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-01-2005 02:21 CET
Last Modified:              02-01-2005 20:55 CET
======================================================================
Summary:                    Opening hdspmixer causes dropouts in audio
Description: 
With the HDSP 9652 running audio through it from ADAT port to ADAT port
opening hdspmixer causes audio dropouts. This makes it impossible to
adjust audio levels realtime without creating glitches. This does not
happen with the RME version (TotalMix) under Windows.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-01-05 02:21 Mark Knecht    New Issue                                    
02-01-05 20:55 charbonnel     Status                   new => assigned     
02-01-05 20:55 charbonnel     Assigned To               => charbonnel      
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
