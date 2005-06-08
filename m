From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001168]: No sound using Yamaha YMF740C on Intel SE440BX-2 motherboard
Date: Wed, 8 Jun 2005 09:10:57 +0200
Message-ID: <8635843d3d2aab37ecc7f4e88980bdae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3AC711E8
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 09:10:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1168> 
======================================================================
Reported By:                mtl
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1168
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               slackware-current
Kernel Version:             2.4.31, as well as 2.4.29 & 2.4.30
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-08-2005 02:04 CEST
Last Modified:              06-08-2005 09:10 CEST
======================================================================
Summary:                    No sound using Yamaha YMF740C on Intel SE440BX-2
motherboard
Description: 
I'm using a system with an Intel SE440BX-2 motherboard, which has the
Yamaha YMF740C sound system built in.

I've taken the alsa-driver source from disc 4 of the Slackware-10.0 CD
set, and after editing the alsa-driver.SlackBuild script to reflect the
current kernel version, rebuilt the alsa-driver-1.0.5a-i486-2.tgz package,
and after installing my own package, all works as it should, so far as I
can tell.  I've done this with kernel versions 2.4.29, 2.4.30, and 2.4.31,
all with the same results.


======================================================================

----------------------------------------------------------------------
 mtl - 06-08-05 04:57 
----------------------------------------------------------------------
Resolved with alsa-driver-1.0.9b.tar.bz2

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-05 02:04 mtl            New Issue                                    
06-08-05 02:04 mtl            Distribution              => slackware-current
06-08-05 02:04 mtl            Kernel Version            => 2.4.31, as well as
2.4.29 & 2.4.30
06-08-05 04:57 mtl            Note Added: 0004915                          
06-08-05 04:57 mtl            Issue Monitored: mtl                         
06-08-05 09:10 perex          Status                   new => resolved     
06-08-05 09:10 perex          Resolution               open => fixed       
06-08-05 09:10 perex          Assigned To               => perex           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
