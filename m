From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002058]: Audigy 2 ZS Notebook lacks
	record capability
Date: Sun, 23 Jul 2006 19:02:17 +0200
Message-ID: <1adb9c6f304edbdc4ea37d37df08d9ed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F36A8187
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Jul 2006 19:02:17 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2058> 
======================================================================
Reported By:                artdent
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2058
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     acknowledged
Distribution:               Debian unstable
Kernel Version:             2.6.15
======================================================================
Date Submitted:             04-22-2006 21:11 CEST
Last Modified:              07-23-2006 19:02 CEST
======================================================================
Summary:                    Audigy 2 ZS Notebook lacks record capability
Description: 
According to bug #927, the emu10k1 driver now works with the Audigy 2 ZS
PCMCIA card for playback, but not capture. The most current is "untested,
might already work". Are there any plans to figure out recording with this
card? It would be greatly appreciated.

Even with an untested patch to enable recording, I would be willing to
test it to see if it works.

Thanks,
Jacob Lee

======================================================================

----------------------------------------------------------------------
 jcdutton - 07-23-06 19:02 
----------------------------------------------------------------------
Not currently implemented.
No timescale set for fix due to not enough developer time available.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-22-06 21:11 artdent        New Issue                                    
04-22-06 21:11 artdent        Distribution              => Debian unstable 
04-22-06 21:11 artdent        Kernel Version            => 2.6.15          
04-24-06 16:48 lwelyn         Issue Monitored: lwelyn                      
07-18-06 14:38 jcdutton       Status                   new => assigned     
07-18-06 14:38 jcdutton       Assigned To               => jcdutton        
07-23-06 19:02 jcdutton       Note Added: 0011200                          
07-23-06 19:02 jcdutton       Status                   assigned => acknowledged
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
