From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002327]: Reinserting/ inserting Audigy
	2 ZS PCMCIA causes oops
Date: Wed, 2 Aug 2006 16:48:19 +0200
Message-ID: <bd42c14d7c357757a11193f3eb59d953@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8ED69174
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Aug 2006 16:48:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2327> 
======================================================================
Reported By:                cathectic
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2327
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Slamd64
Kernel Version:             2.6.17.3 & 2.6.18-rc3
======================================================================
Date Submitted:             08-02-2006 16:48 CEST
Last Modified:              08-02-2006 16:48 CEST
======================================================================
Summary:                    Reinserting/ inserting Audigy 2 ZS PCMCIA causes
oops
Description: 
With the fix from Bug #2190 applied, and snd-emu10k1 built into the kernel,
inserting the card *after* booting Linux, or removing then reinserting the
card, causes an oops.

(It is also possible to lockup the system by reinserting and then removing
the card again after an oops).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-06 16:48 cathectic      New Issue                                    
08-02-06 16:48 cathectic      File Added: post_insert-2.6.17.3                  
 
08-02-06 16:48 cathectic      Distribution              => Slamd64         
08-02-06 16:48 cathectic      Kernel Version            => 2.6.17.3 & 2.6.18-rc3
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
