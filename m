From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001556]: Fortissimo 4: No Volume Control
Date: Mon, 14 Nov 2005 11:02:50 +0100
Message-ID: <2a52dd7195ec69858829405f48e55a1f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 29FCD143
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 11:02:51 +0100 (MET)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1556> 
======================================================================
Reported By:                bladus
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1556
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Gentoo Linux 2005.1
Kernel Version:             2.6.14-ck1
======================================================================
Date Submitted:             11-13-2005 22:06 CET
Last Modified:              11-14-2005 11:02 CET
======================================================================
Summary:                    Fortissimo 4: No Volume Control
Description: 
With the Hercules Fortissimo 4 (Envy24HT) there's no posibillity to control
the volume.
It's always at max.

Under Windows the card uses the reference drivers from VIA, so maybe you
can fix that issue.
I would be very happy if you could send me a response to this issue within
a week, since when it's not possible i can return the card to the
merchant.

Thank you.

======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 11:02 
----------------------------------------------------------------------
Could you try these module options for the snd-ice1724 module?

model="k8x800"
model="sn25p"

Perhaps, one of this configuration might work for you.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 22:06 bladus         New Issue                                    
11-13-05 22:06 bladus         Distribution              => Gentoo Linux 2005.1
11-13-05 22:06 bladus         Kernel Version            => 2.6.14-ck1      
11-14-05 11:02 perex          Note Added: 0006713                          
11-14-05 11:02 perex          Assigned To               => perex           
11-14-05 11:02 perex          Status                   new => feedback     
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
