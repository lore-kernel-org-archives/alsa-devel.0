From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001546]: REGRESSION: rc2 -> rc3 disables optical out when sending PCM
Date: Sat, 12 Nov 2005 01:27:49 +0100
Message-ID: <0a7454c6c28b4bcf414f3a712a050ebc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7C451BD
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2005 01:27:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1546> 
======================================================================
Reported By:                mactalla
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1546
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             
======================================================================
Date Submitted:             11-12-2005 01:27 CET
Last Modified:              11-12-2005 01:27 CET
======================================================================
Summary:                    REGRESSION: rc2 -> rc3 disables optical out when
sending PCM
Description: 
Using Turtle Beach Audio Advantage Micro, the 1.0.10_rc2 driver would
output to the minijack and optical when sending PCM, passthrough would
also work to send a digital signal through optical.  After upgrading to
rc3, only digital signals are sent through the optical.  PCM signals are
sent to the minijack (confirmed with earphones) but the speakers report
"No Data" coming from the optical.  Downgrading to rc2 fixed the issue.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-05 01:27 mactalla       New Issue                                    
11-12-05 01:27 mactalla       Distribution              => Gentoo          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
