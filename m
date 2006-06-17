From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002156]: Geode support still not
	ported from OSS
Date: Sat, 17 Jun 2006 22:01:50 +0200
Message-ID: <993ffbd392d45633f2379242394d71b7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B885615A
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jun 2006 22:01:50 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2156> 
======================================================================
Reported By:                Quietti
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2156
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-24-2006 09:50 CEST
Last Modified:              06-17-2006 22:01 CEST
======================================================================
Summary:                    Geode support still not ported from OSS
Description: 
According to http://www.ussg.iu.edu/hypermail/linux/kernel/0601.2/1636.html
the Geode series all provide a sb16-compatible card. Yet, I notice that
the OSS "sb" module works, while the ALSA "snd-sb16" module doesn't.

Meanwhle, documentation for the more recent Geode SCx200 hardware suggests
an AC97-compatible chip. I notice that e.g. the snd-via82xx driver offer
both AC97 support and a Soundblaster compatibility mode, but that doesn't
work with this Geode either.

Feel free to reassing this to the appropriate driver, if this has been
ported already, or if a documented solution exists.
======================================================================

----------------------------------------------------------------------
 Quietti - 05-24-06 12:56 
----------------------------------------------------------------------
AMD publishes complete specs for the whole Geode series at: 
http://www.amd.com/us-en/ConnectivitySolutions/ProductInformation/0,,50_2330_9863_9919,00.html

They also offer OSS drivers that could be ported to ALSA and merged:
http://www.amd.com/us-en/ConnectivitySolutions/TechnicalResources/0,,50_2334_2452_11363,00.html

Unless I misunderstood, at this time, ALSA only supports current Geodes
based on the CS5535 and CS5536 companion chips. What is missing is support
for the original CS5530 that was on early Geodes and for the subsequent
SCx200 products.

----------------------------------------------------------------------
 Quietti - 06-17-06 22:01 
----------------------------------------------------------------------
I have found what might be an ALSA port for some older ALSA release at
http://www.jumptec.de/SW_DB/PAGES/Board80.htm (look for alsa-geode.zip at
the bottom of the page).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 09:50 Quietti        New Issue                                    
05-24-06 12:56 Quietti        Note Added: 0009954                          
06-17-06 22:01 Quietti        Note Added: 0010290                          
======================================================================
