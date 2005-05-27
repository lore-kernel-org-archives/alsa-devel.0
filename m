From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001127]: kernel panic while accessing midi
Date: Fri, 27 May 2005 12:32:28 +0200
Message-ID: <b610ed7a9a6f0d38dccc35c622fedb36@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DA4AC20D
	for <alsa-devel@alsa-project.org>; Fri, 27 May 2005 12:32:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1127> 
======================================================================
Reported By:                ulrichmoehrke
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1127
Category:                   PCI - als4000
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               debian sarge (kernel from sid)
Kernel Version:             2.6.11 (2.6.11-1-k7)
======================================================================
Date Submitted:             05-26-2005 09:48 CEST
Last Modified:              05-27-2005 12:32 CEST
======================================================================
Summary:                    kernel panic while accessing midi
Description: 
When I try to play a midi file the system freezes/kernel panic.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-27-05 12:32 
----------------------------------------------------------------------
Try the attached patch.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-26-05 09:48 ulrichmoehrke  New Issue                                    
05-26-05 09:48 ulrichmoehrke  File Added: aadebug.out                      
05-26-05 09:48 ulrichmoehrke  Distribution              => debian sarge (kernel
from sid)
05-26-05 09:48 ulrichmoehrke  Kernel Version            => 2.6.11 (2.6.11-1-k7)
05-27-05 12:32 tiwai          Note Added: 0004749                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
