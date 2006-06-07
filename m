From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002190]: System crash on unplugging
	Audigy 2 ZS Notebook CardBus card
Date: Wed, 7 Jun 2006 19:47:46 +0200
Message-ID: <5d90099c4f21a1c7a2e73ac259586de1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D4E39106
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 19:47:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2190> 
======================================================================
Reported By:                tsmithe
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2190
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Dapper 6.06
Kernel Version:             2.6.15
======================================================================
Date Submitted:             06-07-2006 19:47 CEST
Last Modified:              06-07-2006 19:47 CEST
======================================================================
Summary:                    System crash on unplugging Audigy 2 ZS Notebook
CardBus card
Description: 
 System crash on unplugging Audigy 2 ZS Notebook CardBus card
I am running Ubuntu Dapper 6.06, with the 2.6.15 kernel
(including this driver). The driver works pretty well
with my Audigy 2 ZS Notebook card, except that it
doesn't seem to support hotplug. When I plug it in, the
module is installed, and the card functions. However,
the module continues to access the card when it is
unplugged (nor does the module unload), and the kernel
cannot handle this. The system falls over as it cannot
run with a non-functioning kernel. All of my other
devices that use hotplug work fine (CardBus, USB,
whatever), so I can only deduce that this situation is
a result of poor driver support.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-06 19:47 tsmithe        New Issue                                    
06-07-06 19:47 tsmithe        Distribution              => Ubuntu Dapper 6.06
06-07-06 19:47 tsmithe        Kernel Version            => 2.6.15          
======================================================================
