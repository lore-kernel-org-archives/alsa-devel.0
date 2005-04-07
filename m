From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000055]: Midi in does not work for Hoontech/STAudio DSP2000 C-Port
Date: Thu, 7 Apr 2005 17:37:00 +0200
Message-ID: <01df6503064ce16798bc08c8037cae9b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AF0A723A
	for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2005 17:37:00 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=55> 
======================================================================
Reported By:                lukas
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   55
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian testing
Kernel Version:             linux-2.4.22-debian-preempt-lowlat
======================================================================
Date Submitted:             02-12-2004 22:13 CET
Last Modified:              04-07-2005 17:37 CEST
======================================================================
Summary:                    Midi in does not work for Hoontech/STAudio DSP2000
C-Port
Description: 
aconnect -o says:
 client 64: 'Rawmidi 0 - Hoontech SoundTrack Audio DSP24 MPU-401'
[type=kernel]
    0 'Hoontech SoundTrack Audio DSP24 MPU-401'
   32 'Hoontech SoundTrack Audio DSP24 MPU-401'

aconnect -i says:
client 0: 'System' [type=kernel]
    0 'Timer           '
    1 'Announce        '
client 64: 'Rawmidi 0 - Hoontech SoundTrack Audio DSP24 MPU-401'
[type=kernel]
    0 'Hoontech SoundTrack Audio DSP24 MPU-401'
   32 'Hoontech SoundTrack Audio DSP24 MPU-401'

Midi out does not work, midi in does.
======================================================================

----------------------------------------------------------------------
 lukas - 04-07-05 17:05 
----------------------------------------------------------------------
Just curious... Anything new on this one?

btw, some links on this issue:
http://sourceforge.net/mailarchive/message.php?msg_id=7156168
http://lalists.stanford.edu/lau/2003/06/0031.html
http://music.columbia.edu/pipermail/linux-audio-dev/2004-April/thread.html#7671

I posted a link to this issue on the sta support forum
http://qa.staudio.de/show.asp?db=sta&t=sta2&mode=0&msg=1878

Regards,
--lu

----------------------------------------------------------------------
 Clemens Ladisch - 04-07-05 17:37 
----------------------------------------------------------------------
I changed something in ALSA 1.0.5.
I don't know if it fixes this bug, please test.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-12-04 22:13 lukas          New Issue                                    
02-12-04 22:14 lukas          Issue Monitored: lukas                       
02-21-04 15:36 perex          Status                   new => assigned     
02-21-04 15:36 perex          Assigned To               => perex           
04-07-05 17:05 lukas          Note Added: 0004360                          
04-07-05 17:37 Clemens LadischNote Added: 0004361                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
