From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000739]: Invalid "AutoSync Reference" value reported using controlers
Date: Fri, 21 Jan 2005 21:03:17 +0100
Message-ID: <4f6aec855d4a52ed1d575b602cd362b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CB49C21B
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 21:03:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=739> 
======================================================================
Reported By:                remy
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - driver
Issue ID:                   739
Category:                   PCI - RME HDSP
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-21-2004 18:41 CET
Last Modified:              01-21-2005 21:03 CET
======================================================================
Summary:                    Invalid "AutoSync Reference" value reported using
controlers
Description: 
The value returned by controllers for control number 14 ("AutoSync
Reference") is incorrect and different from that reported by doing a cat
/proc/asound/card0/hdsp.
The value reported is not "AutoSync Reference" but "Preferred Sync
Reference" instead.
======================================================================

----------------------------------------------------------------------
 remy - 12-21-04 18:54 
----------------------------------------------------------------------
Ok, sorry
Signed-off-by: Rémy Bruno <remy.bruno@trinnov.com>

----------------------------------------------------------------------
 tiwai - 12-21-04 19:00 
----------------------------------------------------------------------
Thanks, applied to CVS.  Perhaps the change appears in 1.0.8rc2.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-21-04 18:41 remy           New Issue                                    
12-21-04 18:41 remy           File Added: hdsp.c.diff                      
12-21-04 18:46 tiwai          Note Added: 0002902                          
12-21-04 18:54 remy           Note Added: 0002903                          
12-21-04 19:00 tiwai          Status                   assigned => resolved
12-21-04 19:00 tiwai          Resolution               open => fixed       
12-21-04 19:00 tiwai          Note Added: 0002904                          
01-21-05 21:03 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
