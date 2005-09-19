From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000895]: Es1968 driver seems not to support "skype" in full duplex mode
Date: Mon, 19 Sep 2005 10:05:11 +0200
Message-ID: <1097abe800b138bf43dfd7c2cb445d3a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 90E7A13A
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2005 10:05:11 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=895> 
======================================================================
Reported By:                woweil
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   895
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.9
======================================================================
Date Submitted:             02-09-2005 13:00 CET
Last Modified:              09-19-2005 10:05 CEST
======================================================================
Summary:                    Es1968 driver seems not to support "skype" in full
duplex mode
Description: 
When I tried a talk with the application "skype", I recognized that the
soundcard solo-1 was not in full duplex mode. Every time when I have
connection, there is a gread banging. The other part of the talk hears the
banging too. A conversation is impossible, because no word can be
recognized.

After that I tried an installation with Windows 2000. The software worked
well and a conversation is possible without problems. So I suppose, that
the duplexmode is not possible with the driver.

I use a Thinkpad 390X
======================================================================

----------------------------------------------------------------------
 tiwai - 02-14-05 19:49 
----------------------------------------------------------------------
I guess it's an OSS app?
A small testcase is necessary for debugging.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-05 13:00 woweil         New Issue                                    
02-09-05 13:00 woweil         Distribution              => Debian          
02-09-05 13:00 woweil         Kernel Version            => 2.6.9           
02-14-05 19:49 tiwai          Note Added: 0003607                          
09-19-05 10:05 jdthood        Summary                  Es1968 driver seems not
to support full duplex mode => Es1968 driver seems not to support "skype" in
full duplex mode
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
