From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001450]: SPDIF out is limited with 48KHz
Date: Sat, 24 Sep 2005 15:33:53 +0200
Message-ID: <94275be7bd370bc1128e967c0728ffc4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AB203165
	for <alsa-devel@alsa-project.org>; Sat, 24 Sep 2005 15:33:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1450> 
======================================================================
Reported By:                anli
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1450
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-24-2005 15:33 CEST
Last Modified:              09-24-2005 15:33 CEST
======================================================================
Summary:                    SPDIF out is limited with 48KHz
Description: 
Last the driver version which worked perfectly (i.e. with 96KHz SPDIF out
sample rate) is 1.04. And I was able to use SPDIF out with JACK at
96KHz/32bit mode _without_ any problems.

Now SPDIF out is limited with 48KHz srate. Long time ago developers
argumented 48KHz limit as it is SPDIF standard. On the other hand all
(semi)pro DACs suuport 96KHz. This is true for all ice1724 cards too.
Moreover, we are in the open source world at last :-)

Please, revert this limit back. I'm ready to test the driver from CVS
tree.

Andrew

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-05 15:33 anli           New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
