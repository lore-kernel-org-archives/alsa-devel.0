From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001538]: Latency was better on earlier version
Date: Wed, 9 Nov 2005 21:01:02 +0100
Message-ID: <192a3810c1efdf47e8a73d06c065b822@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ABA081D0
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2005 21:01:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1538> 
======================================================================
Reported By:                pesalomo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1538
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             2.6.14
======================================================================
Date Submitted:             11-09-2005 21:01 CET
Last Modified:              11-09-2005 21:01 CET
======================================================================
Summary:                    Latency was better on earlier version
Description: 
I don't know what category which is best for this - but I'm comparing Linux
kernel 2.6.10 and 2.6.14. 

Using I82801DBICH4, version 1.0.10rc1, which is bundled with Linux 2.6.14
- the performance is much weaker than when using kernel 2.6.10 (don't
remember the driver version there).

On 2.6.10 I was able to use a buffer size down to 128 bytes, but now the
lowest I can go is 512. And the sound is still crispy.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-09-05 21:01 pesalomo       New Issue                                    
11-09-05 21:01 pesalomo       Distribution              => Gentoo Linux    
11-09-05 21:01 pesalomo       Kernel Version            => 2.6.14          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
