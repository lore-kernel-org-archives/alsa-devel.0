From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000863]: Feature request: Mixing channels in software
Date: Sun, 30 Jan 2005 23:11:05 +0100
Message-ID: <9e0fc356173a3533fbbadea697da6daf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 113C11C4
	for <alsa-devel@alsa-project.org>; Sun, 30 Jan 2005 23:11:05 +0100 (MET)
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
Last Modified:              01-30-2005 23:11 CET
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

----------------------------------------------------------------------
 rlrevell - 01-30-05 22:47 
----------------------------------------------------------------------
You're right, it absolutely should work out of the box.  But the ALSA
developers have no control over the default config on your system.

File a bug report with your distro.

----------------------------------------------------------------------
 rounin - 01-30-05 23:11 
----------------------------------------------------------------------
Ah, thanks for the clarification. I really should have done more research;
I just didn't know where to start.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-30-05 22:02 rounin         New Issue                                    
01-30-05 22:16 rlrevell       Note Added: 0003443                          
01-30-05 22:31 rounin         Note Added: 0003444                          
01-30-05 22:47 rlrevell       Note Added: 0003445                          
01-30-05 23:11 rounin         Note Added: 0003446                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
