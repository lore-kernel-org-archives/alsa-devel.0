From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000437]: Problem with the spec file
Date: Mon, 31 Jan 2005 19:05:29 +0100
Message-ID: <158d09629bc9146a1a6dd7aca04d011f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5C7D9235
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 19:05:29 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=437> 
======================================================================
Reported By:                croiset
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   437
Category:                   OTHERS
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.4.7-10
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             08-13-2004 09:56 CEST
Last Modified:              01-31-2005 19:05 CET
======================================================================
Summary:                    Problem with the spec file
Description: 
There is a problem the spec file generated with the configure.

you might replace this line in alsa-driver.spec.in :
/lib/modules/*/kernel/*
by :
/lib/modules/*/misc/*


======================================================================

----------------------------------------------------------------------
 croiset - 12-29-04 12:18 
----------------------------------------------------------------------
Ouups it was a problem due to a misconfiguration. The bug can be closed.
Test made with 1.0.8rc1

----------------------------------------------------------------------
 tiwai - 12-29-04 14:16 
----------------------------------------------------------------------
Ok, resolved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-13-04 09:56 croiset        New Issue                                    
08-13-04 09:56 croiset        Kernel Version            => 2.4.7-10        
08-13-04 10:52 croiset        Note Added: 0001561                          
12-29-04 12:18 croiset        Note Added: 0002995                          
12-29-04 14:16 tiwai          Status                   new => resolved     
12-29-04 14:16 tiwai          Resolution               open => not an issue
12-29-04 14:16 tiwai          Assigned To               => tiwai           
12-29-04 14:16 tiwai          Note Added: 0002997                          
12-29-04 14:16 tiwai          Assigned To              tiwai =>            
01-31-05 19:05 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
