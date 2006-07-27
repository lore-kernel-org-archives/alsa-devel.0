From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002299]: no manual volume control for
	Delta 1010 device (using ice1712)
Date: Thu, 27 Jul 2006 12:58:09 +0200
Message-ID: <42c68ed9d9fd2feb4f65cb6bbf5cee6c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 22D3216C
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Jul 2006 12:58:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2299> 
======================================================================
Reported By:                Jarad
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2299
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11-1.1369_FC
======================================================================
Date Submitted:             07-24-2006 07:02 CEST
Last Modified:              07-27-2006 12:58 CEST
======================================================================
Summary:                    no manual volume control for Delta 1010 device
(using ice1712)
Description: 
Using an M-audio delta 1010 device under Fedora Core 4 I am unable to
manually control the volume levels (individually or as a whole).
======================================================================

----------------------------------------------------------------------
 johnrigg - 07-24-06 20:01 
----------------------------------------------------------------------
Have you tried envy24control? If FC4 doesn't include it you'll have to
compile it from whichever version of alsa-tools source matches your
kernel.

There's some stuff about using Delta 1010 on Linux (mostly about multiple
cards, but some of it applies to single card) here:

http://www.sound-man.co.uk/linuxaudio/ice1712multi.html

----------------------------------------------------------------------
 tiwai - 07-27-06 12:58 
----------------------------------------------------------------------
It's not implemented in the driver intentionally.
I have no hardware information about delta1010.  Does it have any analog
volume control on hardware?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-24-06 07:02 Jarad          New Issue                                    
07-24-06 07:02 Jarad          Kernel Version            => 2.6.11-1.1369_FC
07-24-06 20:01 johnrigg       Note Added: 0011213                          
07-27-06 12:58 tiwai          Note Added: 0011269                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
