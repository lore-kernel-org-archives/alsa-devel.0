From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001254]: "invalid argument" error when pressing tab
Date: Tue, 12 Jul 2005 15:31:21 +0200
Message-ID: <ee4b0bc200db5e2959863cd25d8d4a14@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 19DC3199
	for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2005 15:31:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1254> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1254
Category:                   alsamixer
Reproducibility:            have not tried
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-12-2005 15:31 CEST
Last Modified:              07-12-2005 15:31 CEST
======================================================================
Summary:                    "invalid argument" error when pressing tab
Description: 
when pressing <Tab> in alsamixer, the program exits with:

$ alsamixer
alsamixer: function snd_mixer_find_selem() failed: Invalid argument

$ echo $?
2

Pressing <F4> instead, the program stays in playback mode.

trying to run in capture mode:
$ alsamixer -V capture
No mixer elems found


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-12-05 15:31 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
