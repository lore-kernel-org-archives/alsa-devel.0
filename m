From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002296]: AV710 - Only 2 channels on
	Optical Out
Date: Fri, 21 Jul 2006 06:35:45 +0200
Message-ID: <42100869bdcec41f6869633b0964cb00@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A3A4C1AC
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Jul 2006 06:35:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2296> 
======================================================================
Reported By:                Mobian
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2296
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.15-gentoo-r7
======================================================================
Date Submitted:             07-21-2006 06:35 CEST
Last Modified:              07-21-2006 06:35 CEST
======================================================================
Summary:                    AV710 - Only 2 channels on Optical Out
Description: 
Despite having tried every asound.conf file I could find on the Internet
that is supposed to work with this card, I can only get 2 channels (front
left and front right) on the optical output of this card.

I tested this with a simple call to speaker-test -c5 in hopes of testing
5.1 features, but I only hear sound on the front left and front right
speakers.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-21-06 06:35 Mobian         New Issue                                    
07-21-06 06:35 Mobian         Distribution              => Gentoo          
07-21-06 06:35 Mobian         Kernel Version            => 2.6.15-gentoo-r7
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
