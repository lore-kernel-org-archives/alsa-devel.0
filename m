From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001539]: alsa-lib make check: omixer does not build
Date: Thu, 10 Nov 2005 12:37:33 +0100
Message-ID: <1b0837f4710142fa64c312821609b252@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF0DB1CA
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2005 12:37:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1539> 
======================================================================
Reported By:                Flameeyes
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1539
Category:                   aconnect
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-10-2005 12:37 CET
Last Modified:              11-10-2005 12:37 CET
======================================================================
Summary:                    alsa-lib make check: omixer does not build
Description: 
make check for alsa-lib does not complete correctly, as the omixer.c source
file does not build at all.

It tries to include mixer_ordinary.h header that is not present on alsa
1.0.10_rc3 (but it's present on 1.0.9), and then tries to use sndo_*
functions that are in that file). If that is gone, the test should go
away, too. I've worked this around on Portage by removing omixer test
entirely.

HTH,
Diego
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-10-05 12:37 Flameeyes      New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
