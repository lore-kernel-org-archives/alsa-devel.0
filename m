From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000820]: Mic (and probably other inputs) recording does not work
Date: Mon, 19 Sep 2005 10:08:38 +0200
Message-ID: <a195b8f66d329d604198ca51946fc53c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4AA7013A
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2005 10:08:38 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=820> 
======================================================================
Reported By:                gadkadosh
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   820
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo Linux
Kernel Version:             2.6.10
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             01-15-2005 12:49 CET
Last Modified:              09-19-2005 10:08 CEST
======================================================================
Summary:                    Mic (and probably other inputs) recording does not
work
Description: 
I'm running gentoo linux with kernel 2.6.10, though it's the same with
2.6.9 too. The alsa driver is compiled from the official kernel sources,
version 1.0.6 according to /proc/asoumd/version.
I'm trying to use a mic through the mic jack, and use it in GnomeMeeting.
Mic is the Capture device and volume is at max. I can hear the sounds from
the mic trough the sound card's speakers (laptop), but no sound gets
recorded. Tried also with Gnome's Sound Recorder, and with arecord, with
no success. The apps look as though they record and everything is fine,
but the output file is just silence.
I also tried setting Capture to CD, play a cd-audio and record it with
arecord and got the same results. I suppose it's related. 
The important point is that I have had the mic working already some time
ago, with GnomeMeeting, but I can't recall what has changed since then.
Kernel-2.6.9 has the same results. With kernel-2.6.8.1 the atiixp driver
does not work at all. Also had an upgrade of alsa-headers lately to 1.0.8
which I'm not sure is related or not.
======================================================================

----------------------------------------------------------------------
 EPOdata - 02-27-05 01:12 
----------------------------------------------------------------------
I have the same problem with alsa 1.0.6 on Fedora Core 3 with AW320
soundcard. The hardware is OK, I can both record and playback on Windows
2000 on the same HW. wav-files can be played correctly but the wav files
created by arecord are all silent, also when they are played back on
Windows.

----------------------------------------------------------------------
 jdthood - 09-19-05 10:08 
----------------------------------------------------------------------
Presumably a problem with mixer settings.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-15-05 12:49 gadkadosh      New Issue                                    
01-15-05 12:49 gadkadosh      Distribution              => Gentoo Linux    
01-15-05 12:49 gadkadosh      Kernel Version            => 2.6.10          
01-16-05 13:19 gadkadosh      Note Added: 0003215                          
01-17-05 15:10 tiwai          Note Added: 0003237                          
02-27-05 01:12 EPOdata        Note Added: 0003741                          
09-19-05 10:08 jdthood        Status                   assigned => resolved
09-19-05 10:08 jdthood        Resolution               open => not an issue
09-19-05 10:08 jdthood        Note Added: 0006286                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
