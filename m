From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000804]: asoundlib.h doesn't #include time.h, which is needed for struct timespec
Date: Mon, 10 Jan 2005 22:39:55 +0100
Message-ID: <42fa2707c1438d835758462721ee7bae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E562A2BF
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2005 22:39:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=804> 
======================================================================
Reported By:                yosh
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   804
Category:                   general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-10-2005 22:39 CET
Last Modified:              01-10-2005 22:39 CET
======================================================================
Summary:                    asoundlib.h doesn't #include time.h, which is needed
for struct timespec
Description: 
http://bugzilla.gnome.org/show_bug.cgi?id=163593

This was a build failure from including asoundlib.h, and struct timespec
wasn't defined, which is needed for the snd_htimestamp_t typedef. Simple
fix is to add an #include <time.h> in asoundlib.h.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 22:39 yosh           New Issue                                    
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
