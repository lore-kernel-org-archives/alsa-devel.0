From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000769]: HDSP level meter options saving
Date: Fri, 28 Jan 2005 17:08:06 +0100
Message-ID: <c6b954c983d4a45a88784c0c597287dd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D79AB1CF
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2005 17:08:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=769> 
======================================================================
Reported By:                kme
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - tools
Issue ID:                   769
Category:                   hdsp progs
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             12-31-2004 18:47 CET
Last Modified:              01-28-2005 17:08 CET
======================================================================
Summary:                    HDSP level meter options saving
Description: 
Options from the "Level Meter Setup" are not saved in presets (or at all
across new instances of HDSPmixer).  Ideal behaviour (IMHO) would save
these settings globally regardless of preset.
======================================================================

----------------------------------------------------------------------
 charbonnel - 01-28-05 17:08 
----------------------------------------------------------------------
The options for the "Level Meter Setup" are saved in presets. You can for
example have different presets with exactly the same routing setup but
different "Level Meter Setup" options. If you want this to be persistant,
save the presets to a file and make it the default (from the File menu).
They will automaticaly be loaded on startup.
As a last note, this behaviour (per preset "Level Meter Setup" option) may
not mimic what the windows version does, but it seemed more flexible to
me.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-31-04 18:47 kme            New Issue                                    
01-28-05 17:08 charbonnel     Note Added: 0003427                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
