From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001139]: alsa-lib-1.0.9 breaks WINE and icc
Date: Sun, 29 May 2005 16:25:14 +0200
Message-ID: <94c5801db841b1db63716b344a4568cc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 15E38137
	for <alsa-devel@alsa-project.org>; Sun, 29 May 2005 16:25:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1139> 
======================================================================
Reported By:                canal
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1139
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-29-2005 02:17 CEST
Last Modified:              05-29-2005 16:25 CEST
======================================================================
Summary:                    alsa-lib-1.0.9 breaks WINE and icc
Description: 
alsa-lib uses identifier "interface". It's used as keyword in icc and WINE
(in case of WINE - via #define interface struct).

======================================================================

----------------------------------------------------------------------
 perex - 05-29-05 16:25 
----------------------------------------------------------------------
Fixed in CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-05 02:17 canal          New Issue                                    
05-29-05 16:25 perex          Status                   new => resolved     
05-29-05 16:25 perex          Resolution               open => fixed       
05-29-05 16:25 perex          Assigned To               => perex           
05-29-05 16:25 perex          Note Added: 0004789                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
