From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001532]: Mute controls are gone, therefore unmuting impossible and no sound: NM256,AC97
Date: Tue, 8 Nov 2005 18:29:05 +0100
Message-ID: <3183d79b4c9155d04da0d68ea8e91912@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 229171BB
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 18:29:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1532> 
======================================================================
Reported By:                sstefan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1532
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.13
======================================================================
Date Submitted:             11-06-2005 19:32 CET
Last Modified:              11-08-2005 18:29 CET
======================================================================
Summary:                    Mute controls are gone, therefore unmuting
impossible and no sound: NM256,AC97
Description: 
Upgrading from Linux 2.6.10 to 2.6.13, I was no longer able to use the alsa
nm256 driver, because the mute controls (e.g. for Master and PCM output)
disappeared from alsamixer or kmix. The chip is muted by default, so upon
playing nothing is output to the speakers, and there's no way to unmute
the channels.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-08-05 18:29 
----------------------------------------------------------------------
Any changes with the latest ALSA 1.0.10rc3?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-06-05 19:32 sstefan        New Issue                                    
11-06-05 19:32 sstefan        Distribution              => Debian          
11-06-05 19:32 sstefan        Kernel Version            => 2.6.13          
11-08-05 18:29 tiwai          Note Added: 0006632                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
