From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002299]: no manual volume control for
	Delta 1010 device (using ice1712)
Date: Mon, 31 Jul 2006 10:52:52 +0200
Message-ID: <9b731ab66c21a0ce360ee8f3b5b0c5ed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D67FA181
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Jul 2006 10:52:52 +0200 (MEST)
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
Last Modified:              07-31-2006 10:52 CEST
======================================================================
Summary:                    no manual volume control for Delta 1010 device
(using ice1712)
Description: 
Using an M-audio delta 1010 device under Fedora Core 4 I am unable to
manually control the volume levels (individually or as a whole).
======================================================================

----------------------------------------------------------------------
 johnrigg - 07-31-06 10:31 
----------------------------------------------------------------------
You need to get rid of your existing .asoundrc. The Delta 1010 has a
hardware mixer, which is controlled digitally by envy24control. You should
not use dmix with this card. A single Delta 1010 should work perfectly
without any .asoundrc.

----------------------------------------------------------------------
 johnrigg - 07-31-06 10:52 
----------------------------------------------------------------------
Another thing, it's possible the FC4 init scripts are doing something
strange, so if removing .asoundrc doesn't fix it you could try disabling
any alsa init scripts. Not sure how to do that on FC, but on my old Red
Hat 8 setup you could turn init scripts off selectively using the `ntsysv'
program then rebooting. On my current Debian system I keep the alsa init
script switched off permanently, which always starts the Delta 1010s with
default driver settings (and all channel volumes can be controlled
individually with envy24control).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-24-06 07:02 Jarad          New Issue                                    
07-24-06 07:02 Jarad          Kernel Version            => 2.6.11-1.1369_FC
07-24-06 20:01 johnrigg       Note Added: 0011213                          
07-27-06 12:58 tiwai          Note Added: 0011269                          
07-27-06 20:32 johnrigg       Note Added: 0011278                          
07-31-06 02:57 Jarad          Note Added: 0011335                          
07-31-06 10:31 johnrigg       Note Added: 0011339                          
07-31-06 10:52 johnrigg       Note Added: 0011340                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
