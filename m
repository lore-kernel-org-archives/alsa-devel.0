From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000859]: alsactl does not report error status when given an illegal option
Date: Mon, 31 Jan 2005 18:49:14 +0100
Message-ID: <b3fe43d05ac78bc9f501d648da8f211e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6C58121C
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 18:49:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=859> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   859
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-29-2005 17:16 CET
Last Modified:              01-31-2005 18:49 CET
======================================================================
Summary:                    alsactl does not report error status when given an
illegal option
Description: 
$ /usr/sbin/alsactl --foobar > /dev/null/usr/sbin/alsactl: unrecognized
option `--foobar'
$ echo $?
0

======================================================================

----------------------------------------------------------------------
 tiwai - 01-31-05 18:49 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-05 17:16 jdthood        New Issue                                    
01-31-05 18:49 tiwai          Status                   new => resolved     
01-31-05 18:49 tiwai          Resolution               open => fixed       
01-31-05 18:49 tiwai          Assigned To               => tiwai           
01-31-05 18:49 tiwai          Note Added: 0003448                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
