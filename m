From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000490]:  Choppy sound when playing on Acer TravelMate 2000
Date: Wed,  8 Sep 2004 21:16:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040908191652.E0CB113002@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B40A82A6
	for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2004 21:19:08 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000490
======================================================================
Reported By:                feixm
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     490
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               linuxfromscratch, everything compiled from original sources
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             09-08-2004 21:16 CEST
Last Modified:              09-08-2004 21:16 CEST
======================================================================
Summary:                     Choppy sound when playing on Acer TravelMate 2000
Description: 
Hello,

when playing any audio file from my new Acer TravelMate 2000, the sound is
very choppy. I tried playing using xmms, mplayer and others. From lspci I
see, it is an ATI IXP 150. I understand that this bugreport alone won't
help you guys, so if I can give any more info, pls let me know.

When playing movies with mplayer, I see lots of messages like:

alsa-play: xrun of at least 0,131 msecs. resetting stream%  0%  0,0% 1 0
0%
alsa-play: xrun of at least 0,026 msecs. resetting stream 0%  0%  0,0% 7 0
0%

These appear even more where skipping back and forward in the movie.

I found, that playing movies through SDL helps a little, but sound is
still choppy and cannot be listened to.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-08-04 21:16 feixm          New Bug                                      
09-08-04 21:16 feixm          Distribution              => linuxfromscratch, everything compiled from original sources
09-08-04 21:16 feixm          Kernel Version            => 2.6.8.1         
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
