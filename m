From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002280]: nforce 570 with AD1988A no
	sound
Date: Sun, 6 Aug 2006 11:15:17 +0200
Message-ID: <b56af73bb343d5ae4e7bf344faf03440@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F147513A
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 11:15:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2280> 
======================================================================
Reported By:                Tobias Diedrich
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2280
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian/GNU Linux testing
Kernel Version:             2.6.18-rc1
======================================================================
Date Submitted:             07-14-2006 14:40 CEST
Last Modified:              08-06-2006 11:15 CEST
======================================================================
Summary:                    nforce 570 with AD1988A no sound
Description: 
I just bought a new mainboard, an Asus M2N with nforce 570 chipset (mcp55)
and snd-hda-intel loads fine, but complains about an unknown chip version
and tries to get some configuration values from the BIOS. Apparently this
does not work, since while it loads fine I have so far been unable to get
any sound from it.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-19-06 20:33 
----------------------------------------------------------------------
Try the latest HG version.  The codec might be AD1988B, not AD1988A.

----------------------------------------------------------------------
 Tobias Diedrich - 08-06-06 11:15 
----------------------------------------------------------------------
Ok, I got around to testing it again and it is working now since 2.6.18-rc2
AFAICS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-14-06 14:40 Tobias DiedrichNew Issue                                    
07-14-06 14:40 Tobias DiedrichDistribution              => Debian/GNU Linux
testing
07-14-06 14:40 Tobias DiedrichKernel Version            => 2.6.18-rc1      
07-19-06 20:33 tiwai          Note Added: 0011098                          
08-06-06 11:15 Tobias DiedrichNote Added: 0011465                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
