From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002308]: SB 5.1: No sound on front
	channels
Date: Fri, 28 Jul 2006 17:39:24 +0200
Message-ID: <46c663a2809cb2ef0ee5311544bcbbac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CE4AB153
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Jul 2006 17:39:24 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2308> 
======================================================================
Reported By:                kuschelkriterium
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2308
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             2.6.17-gentoo (alsa installed via ebuild - NOT
compiled into kernel)
======================================================================
Date Submitted:             07-28-2006 17:39 CEST
Last Modified:              07-28-2006 17:39 CEST
======================================================================
Summary:                    SB 5.1: No sound on front channels
Description: 
Same as in #1624 and #1648, I have no sound on my front channels - only
that it is not resolved as of yet.

My hardware (as in alsamixer):

Card: SB Live 5.1 [SB0220]
Chip: SigmaTel STAC9758,59

dopefish dopefish # lspci -vn | grep -A1 0401
01:0a.0 0401: 1102:0002 (rev 0a)
        Subsystem: 1102:100a


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-28-06 17:39 kuschelkriteriumNew Issue                                    
07-28-06 17:39 kuschelkriteriumDistribution              => Gentoo Linux    
07-28-06 17:39 kuschelkriteriumKernel Version            => 2.6.17-gentoo (alsa
installed via ebuild - NOT compiled into kernel)
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
