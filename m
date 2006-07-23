From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002190]: System crash on unplugging
	Audigy 2 ZS Notebook CardBus card
Date: Sun, 23 Jul 2006 23:25:45 +0200
Message-ID: <342f003cbc8dca2935ff4876abc941fc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8E7D813C
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Jul 2006 23:25:45 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2190> 
======================================================================
Reported By:                tsmithe
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2190
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu Dapper 6.06
Kernel Version:             2.6.15
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             06-07-2006 19:47 CEST
Last Modified:              07-23-2006 23:25 CEST
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

----------------------------------------------------------------------
 cathectic - 07-23-06 19:53 
----------------------------------------------------------------------
With this patch on 2.6.17.3, I can remove the card, but with snd-emu10k1
built into the kernel, the driver is not reloaded on re-insertion.

----------------------------------------------------------------------
 jcdutton - 07-23-06 23:25 
----------------------------------------------------------------------
User reports that the patch fixes the problem. I.e. The system does not
crash any more.
Patch has been commited into hg alsa repository.
Any new different problems should be entered as a new bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-06 19:47 tsmithe        New Issue                                    
06-07-06 19:47 tsmithe        Distribution              => Ubuntu Dapper 6.06
06-07-06 19:47 tsmithe        Kernel Version            => 2.6.15          
06-10-06 22:08 tsmithe        Issue Monitored: tsmithe                     
07-18-06 14:34 jcdutton       Status                   new => assigned     
07-18-06 14:34 jcdutton       Assigned To               => jcdutton        
07-23-06 14:55 jcdutton       File Added: hotplug-fix.diff                    
07-23-06 14:56 jcdutton       Note Added: 0011188                          
07-23-06 14:56 jcdutton       Status                   assigned => feedback
07-23-06 19:53 cathectic      Note Added: 0011204                          
07-23-06 23:25 jcdutton       Status                   feedback => closed  
07-23-06 23:25 jcdutton       Note Added: 0011205                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
