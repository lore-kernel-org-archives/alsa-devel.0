From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000863]: Feature request: Mixing channels in software
Date: Sun, 30 Jan 2005 22:02:17 +0100
Message-ID: <a0a2765a052b81b695eac2d2d87a640a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7C9C41E5
	for <alsa-devel@alsa-project.org>; Sun, 30 Jan 2005 22:02:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=863> 
======================================================================
Reported By:                rounin
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   863
Category:                   mixer
Reproducibility:            N/A
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-30-2005 22:02 CET
Last Modified:              01-30-2005 22:02 CET
======================================================================
Summary:                    Feature request: Mixing channels in software
Description: 
One of the major drawbacks of ALSA versus OSS/esd is that ALSA is unable to
provide access to an audio channel to more than one application at once,
meaning that users with cheap sound cards (most users) are unable to hear
sound in more than application at any one time, or even start more than
one application that absolutely requires sound.

It would make ALSA really interesting if an option were added to give each
program one or more virtual sound devices, all of which were really mixed
together in software, and then output to the actual sound device by a
layer at a lower level. Whether this is possible with regards to latency
and complexity is beyond me, but it seems to be working in Windows.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-30-05 22:02 rounin         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
