From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000843]: alsactl does not report error status when it can't restore levels for all cards
Date: Sun, 23 Jan 2005 11:23:57 +0100
Message-ID: <2f30de2bc983819f410355964c41d9c1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 28C94199
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2005 11:23:58 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=843> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   843
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-23-2005 11:23 CET
Last Modified:              01-23-2005 11:23 CET
======================================================================
Summary:                    alsactl does not report error status when it can't
restore levels for all cards
Description: 
# modprobe snd-dummy
# alsactl restore Dummy
No state is present for card Dummy
# echo $?
0

It would be helpful if alsactl returned a nonzero status in the event
that it is unable to restore settings for the specified card (or, in
case it's just "alsactl restore", for one of the cards).

It would be especially helpful if this status were other than 1 so
that "No state is present" could be distinguished from "No such
device".

# alsactl restore 2
alsactl: set_controls:1119: snd_ctl_open error: No such device
# echo $?
1
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-23-05 11:23 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
