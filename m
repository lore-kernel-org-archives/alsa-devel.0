From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001706]: Audigy 2 Value [SB0400] AC3
	pass-through does not work
Date: Tue, 18 Jul 2006 14:41:27 +0200
Message-ID: <74995f4edf84c1e6b5c626b7c80ac65d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E14AC19A
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:41:27 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1706> 
======================================================================
Reported By:                simokivimaki
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1706
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.14-gentoo-r5
======================================================================
Date Submitted:             01-03-2006 22:39 CET
Last Modified:              07-18-2006 14:41 CEST
======================================================================
Summary:                    Audigy 2 Value [SB0400] AC3 pass-through does not
work
Description: 
With Audigy 2 Value [SB0400] AC3 pass-through does not work with current
emu10k1 alsa-driver.

I noticed that this is also documented to the emu10k1_main.c:
/* Audigy 2 Value AC3 out does not work yet. Need to find out how to turn
off interpolators.*/

Is there coming a fix for the problem? Please, ask for more information if
needed.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-06 22:39 simokivimaki   New Issue                                    
01-03-06 22:39 simokivimaki   Distribution              => Gentoo          
01-03-06 22:39 simokivimaki   Kernel Version            => 2.6.14-gentoo-r5
01-04-06 00:15 scoobydu       Issue Monitored: scoobydu                    
01-04-06 13:03 simokivimaki   Issue Monitored: simokivimaki                    
07-18-06 14:41 jcdutton       Status                   new => assigned     
07-18-06 14:41 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
