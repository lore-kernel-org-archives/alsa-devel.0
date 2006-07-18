From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000655]: E-MU 1010 (1212m/1820m)
Date: Tue, 18 Jul 2006 20:22:21 +0200
Message-ID: <ef31481d7624f378f3a457560a27c557@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 273C51A3
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 20:22:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=655> 
======================================================================
Reported By:                gaburici
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   655
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-19-2004 00:45 CET
Last Modified:              07-18-2006 20:22 CEST
======================================================================
Summary:                    E-MU 1010 (1212m/1820m)
Description: 
It would be nice if the E-MU systems based on the 1010 PCI card (1212m and
1820m) could work with alsa. I have the 1212m, which is a 1010 with an
add-on card (0202) for two analog stero channels. The add-on is not a real
PCI card, it connects to the 1010 with a floppy cable.

The 1010 card gets detected as the (older) E-MU APS, but no sound comes
out of the 0202, even with the volume at max.
I haven't tried the ADAT or SPDIF outputs of the 1010.

======================================================================

----------------------------------------------------------------------
 rlrevell - 05-04-05 00:24 
----------------------------------------------------------------------
Please try the attached patch.  The 1010 appears to be emu10k2 (Audigy)
based, while the APS was emu10k1 (SBLive!) based.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-19-04 00:45 gaburici       New Issue                                    
12-27-04 12:36 morriscet      Issue Monitored: morriscet                    
12-27-04 12:36 morriscet      Issue End Monitor: morriscet                    
05-04-05 00:23 rlrevell       File Added: emu-1212m.patch                    
05-04-05 00:24 rlrevell       Note Added: 0004586                          
07-18-06 20:22 pzad           Assigned To              pzad =>             
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
