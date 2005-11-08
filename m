From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001514]: Actually disable NLS support when --disable-nls is passed
Date: Tue, 8 Nov 2005 17:43:43 +0100
Message-ID: <59e3b4610e24931220d92b0a8e75e187@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 389D71A8
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 17:43:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1514> 
======================================================================
Reported By:                Flameeyes
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1514
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-30-2005 13:25 CET
Last Modified:              11-08-2005 17:43 CET
======================================================================
Summary:                    Actually disable NLS support when --disable-nls is
passed
Description: 
The attached patch makes sure that when passing --disable-nls to configure
script NLS support is actually disabled.
This is needed to build alsa-utils on uClibc systems, where NLS function
are not provided by the system library (and needs gettext).

======================================================================

----------------------------------------------------------------------
 Flameeyes - 11-08-05 16:15 
----------------------------------------------------------------------
This still apply to rc3

----------------------------------------------------------------------
 tiwai - 11-08-05 17:43 
----------------------------------------------------------------------
Applied to CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-30-05 13:25 Flameeyes      New Issue                                    
10-30-05 13:25 Flameeyes      File Added: alsa-utils-1.0.10_rc1-nls.patch       
            
11-08-05 16:15 Flameeyes      Note Added: 0006622                          
11-08-05 17:43 tiwai          Status                   new => resolved     
11-08-05 17:43 tiwai          Resolution               open => fixed       
11-08-05 17:43 tiwai          Assigned To               => tiwai           
11-08-05 17:43 tiwai          Note Added: 0006625                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
