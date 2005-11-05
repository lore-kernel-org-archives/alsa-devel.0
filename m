From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001530]: Fix for ali5451 driver taking 10 seconds to load
Date: Sat, 5 Nov 2005 20:29:46 +0100
Message-ID: <5e7348be937cda40741a24b502a506bb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EBDF6134
	for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2005 20:29:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1530> 
======================================================================
Reported By:                Vince
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1530
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10 & Fedora Core 4
Kernel Version:             2.6.12-9-k7 & 2.6.13-1.1526_FC4
======================================================================
Date Submitted:             11-05-2005 20:29 CET
Last Modified:              11-05-2005 20:29 CET
======================================================================
Summary:                    Fix for ali5451 driver taking 10 seconds to load
Description: 
On bootup on my laptop, the ali5451 driver takes 10 seconds to load, which
is quite annoying.  Changing the wait time in snd_ali_codec_ready improves
this dramatically.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-05-05 20:29 Vince          New Issue                                    
11-05-05 20:29 Vince          File Added: ali5451-init.patch                    
11-05-05 20:29 Vince          Distribution              => Ubuntu 5.10 & Fedora
Core 4
11-05-05 20:29 Vince          Kernel Version            => 2.6.12-9-k7 &
2.6.13-1.1526_FC4
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
