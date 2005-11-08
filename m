From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001513]: Add largefile support to alsa-utils
Date: Tue, 8 Nov 2005 16:22:11 +0100
Message-ID: <04ab38a4376174627c090e6ecd3f6adc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 22C511AC
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 16:22:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1513> 
======================================================================
Reported By:                Flameeyes
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1513
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-30-2005 13:21 CET
Last Modified:              11-08-2005 16:22 CET
======================================================================
Summary:                    Add largefile support to alsa-utils
Description: 
The attached patch allows to play/record and in general open large files
(>=2GB) with 32-bit systems (like x86).

It's just a matter of checking largefile support in libc and then enable
it.
======================================================================

----------------------------------------------------------------------
 Flameeyes - 11-08-05 16:22 
----------------------------------------------------------------------
This still applies to rc3.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-30-05 13:21 Flameeyes      New Issue                                    
10-30-05 13:21 Flameeyes      File Added: alsa-utils-1.0.10_rc1-largefile.patch 
                  
11-08-05 16:22 Flameeyes      Note Added: 0006623                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
