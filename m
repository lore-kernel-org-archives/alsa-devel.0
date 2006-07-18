From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002020]: Rear output should be useable
	as normal output (not just sourround)
Date: Tue, 18 Jul 2006 14:39:01 +0200
Message-ID: <1d7b496e6deae47e301155249d061ba5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0EE68176
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:39:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2020> 
======================================================================
Reported By:                shina
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2020
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             
======================================================================
Date Submitted:             04-14-2006 16:34 CEST
Last Modified:              07-18-2006 14:39 CEST
======================================================================
Summary:                    Rear output should be useable as normal output (not
just sourround)
Description: 
The one thing that keeps me from using ALSA's snd-emu10k1 instead OSS's
emu10k1 is that I cannot really use the rear output.
Yes, there is a mixer control named "Wave Sourround", but it outputs only
PCM (not Line/Wavetable/..). Also I have to change Wave Sourround and PCM
Volume seperately. The way it works with the OSS driver is more logical.
I tried to figure out how to make things work with ld10k1, but I really
don't understand this program. emu-dspmgr is "easier" to understand.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-14-06 16:34 shina          New Issue                                    
04-14-06 16:34 shina          Distribution              => Gentoo Linux    
04-14-06 16:34 shina          Issue Monitored: shina                       
07-18-06 14:39 jcdutton       Status                   new => assigned     
07-18-06 14:39 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
