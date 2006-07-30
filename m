From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002317]: High frequency noise or
	static from sound
Date: Sun, 30 Jul 2006 04:38:26 +0200
Message-ID: <6aab0ba646dc33b57d18a5835a91c36b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A4DDD16E
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 04:38:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2317> 
======================================================================
Reported By:                jmctavish
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2317
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.17
======================================================================
Date Submitted:             07-30-2006 04:38 CEST
Last Modified:              07-30-2006 04:38 CEST
======================================================================
Summary:                    High frequency noise or static from sound
Description: 
This appears to be similar to bugs:

0001596: No sound or High pitched noise, dissapears if change made on
mixer 
0002291: AD1986A produces a high fequency noise

both of which are resolved, but none of what is mentioned fixes the
problem.  No matter what model or position_fix parameters are used,
speaker-check always produces static.

combinations tried:
1) options snd_hda_intel position_fix=1
2) options snd_hda_intel model=3stack
3) options snd_hda_intel model=laptop
4) options snd_hda_intel model=3stack position_fix=1
5) options snd_hda_intel model=laptop position_fix=1  

using alsa-1.0.12rc1

If anyone needs to know more information, feel free to contact me.  I'll
help out any way I can.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-30-06 04:38 jmctavish      New Issue                                    
07-30-06 04:38 jmctavish      Distribution              => Gentoo          
07-30-06 04:38 jmctavish      Kernel Version            => 2.6.17          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
