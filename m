From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002291]: AD1986A produces a high
	fequency noise
Date: Thu, 20 Jul 2006 05:07:29 +0200
Message-ID: <fde92b30d3413d6b693df7ae411f7424@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A383D13D
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 05:07:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2291> 
======================================================================
Reported By:                michaeleekk
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2291
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.17-1.2145_FC5
======================================================================
Date Submitted:             07-18-2006 07:12 CEST
Last Modified:              07-20-2006 05:07 CEST
======================================================================
Summary:                    AD1986A produces a high fequency noise
Description: 
Some noise, just like "weeeeee", produced when playing a sound files or
music files.
No exception. It always produced.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-19-06 20:18 
----------------------------------------------------------------------
Try model=3stack module option.

----------------------------------------------------------------------
 michaeleekk - 07-20-06 05:07 
----------------------------------------------------------------------
Where should I put the model=3stack ??

I put in the /etc/modprobe.conf:

alias snd-card-0 snd-hda-intel
options snd-hda-intel model=auto
alias sound-slot-0 snd-hda-intel

But with these settings, I also have the "weeeeeeeeeeee" sound when
playing the music ...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-18-06 07:12 michaeleekk    New Issue                                    
07-18-06 07:12 michaeleekk    Kernel Version            => 2.6.17-1.2145_FC5
07-18-06 11:50 Adrian Bunk    Category                 0_compilation problem_!!!
=> PCI - hda-intel
07-19-06 20:18 tiwai          Note Added: 0011095                          
07-20-06 05:07 michaeleekk    Note Added: 0011108                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
