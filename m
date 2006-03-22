From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000490]:  Choppy sound when playing on Acer TravelMate 2000
Date: Wed, 22 Mar 2006 03:15:20 +0100
Message-ID: <271bd2824ffd19e995840985e9b6ff81@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1784F1A6
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:15:21 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=490> 
======================================================================
Reported By:                feixm
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   490
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               linuxfromscratch, everything compiled from original
sources
Kernel Version:             2.6.8.1
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-08-2004 21:16 CEST
Last Modified:              03-22-2006 03:15 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000583 xruns when playing audio or video files
======================================================================

----------------------------------------------------------------------
 jdthood - 09-15-05 15:14 
----------------------------------------------------------------------
> alsa-play: xrun of at least 0,019 msecs. resetting stream

See bug #583.

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:15 
----------------------------------------------------------------------
mplayer bug, confirmed fixed in mplayer CVS

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-08-04 21:16 feixm          New Issue                                    
09-08-04 21:16 feixm          Distribution              => linuxfromscratch,
everything compiled from original sources
09-08-04 21:16 feixm          Kernel Version            => 2.6.8.1         
01-18-05 07:56 rounin         Note Added: 0003242                          
01-18-05 07:59 rounin         Issue Monitored: rounin                      
01-18-05 08:09 rounin         Note Added: 0003245                          
01-18-05 11:32 tiwai          Note Added: 0003247                          
01-18-05 21:25 rlrevell       Note Added: 0003260                          
01-18-05 22:47 feixm          Note Added: 0003261                          
01-19-05 15:17 feixm          Note Added: 0003282                          
01-19-05 15:20 tiwai          Note Added: 0003285                          
01-21-05 14:19 feixm          Note Added: 0003347                          
01-21-05 17:30 tiwai          Note Added: 0003350                          
01-21-05 19:13 rlrevell       Note Added: 0003351                          
01-22-05 13:30 feixm          Note Added: 0003376                          
09-15-05 15:13 jdthood        Relationship added       duplicate of 0000583
09-15-05 15:14 jdthood        Note Added: 0006205                          
03-22-06 03:15 rlrevell       Status                   assigned => closed  
03-22-06 03:15 rlrevell       Note Added: 0008805                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
