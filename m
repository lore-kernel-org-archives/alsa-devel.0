From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000055]: Midi in does not work for Hoontech/STAudio DSP2000 C-Port
Date: Tue, 7 Jun 2005 08:24:28 +0200
Message-ID: <0984cc0ed636c8e9f647a7cd5c6317de@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EBD8918D
	for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2005 08:24:28 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0001161.
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
Status:                     resolved
Distribution:               Debian testing
Kernel Version:             linux-2.4.22-debian-preempt-lowlat
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-12-2004 22:13 CET
Last Modified:              06-06-2005 10:59 CEST
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001161 Midi in still does not work for Hoontec...
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

----------------------------------------------------------------------
 perex - 06-06-05 10:59 
----------------------------------------------------------------------
No response from reporter.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-12-04 22:13 lukas          New Issue                                    
02-12-04 22:14 lukas          Issue Monitored: lukas                       
02-21-04 15:36 perex          Status                   new => assigned     
02-21-04 15:36 perex          Assigned To               => perex           
04-07-05 17:05 lukas          Note Added: 0004360                          
04-07-05 17:37 Clemens LadischNote Added: 0004361                          
06-06-05 10:59 perex          Status                   assigned => resolved
06-06-05 10:59 perex          Resolution               open => fixed       
06-06-05 10:59 perex          Note Added: 0004901                          
06-07-05 08:24 perex          Relationship added       related to 0001161  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
