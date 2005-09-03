From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001396]: Unable to set capture source
Date: Sun, 4 Sep 2005 00:35:04 +0200
Message-ID: <a933e6c423e851f1cc05cec40e8e8221@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6F0AF11B
	for <alsa-devel@alsa-project.org>; Sun,  4 Sep 2005 00:35:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1396> 
======================================================================
Reported By:                keirlawson
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1396
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.12
======================================================================
Date Submitted:             09-03-2005 22:53 CEST
Last Modified:              09-04-2005 00:35 CEST
======================================================================
Summary:                    Unable to set capture source
Description: 
using amixer, alsamixer or gnome-volume-control it seems to be impossible
to capture from microphone on my audigy 2 value.  alsamixer does nothign
when i attempt to select a capture device, the amixer error is below,
gnome-volume-manager displays only playback volume sliders, no capture
ones
======================================================================

----------------------------------------------------------------------
 rlrevell - 09-04-05 00:33 
----------------------------------------------------------------------
Your ALSA version is too old.  Try kernel 2.6.13.

----------------------------------------------------------------------
 rlrevell - 09-04-05 00:35 
----------------------------------------------------------------------
Also you forgot the attachment containing the amixer error.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-03-05 22:53 keirlawson     New Issue                                    
09-03-05 22:53 keirlawson     Kernel Version            => 2.6.12          
09-04-05 00:33 rlrevell       Note Added: 0006032                          
09-04-05 00:35 rlrevell       Note Added: 0006033                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
