From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001328]: Surround51 and surround40 don't work for Terratec Aureon USB 5.1 Mk II
Date: Thu, 11 Aug 2005 19:07:00 +0200
Message-ID: <0072a3448249285d0c146859b4166c72@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F3B4F207
	for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2005 19:07:00 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1328> 
======================================================================
Reported By:                matthew_m
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1328
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.11.4-21.8-smp
======================================================================
Date Submitted:             08-11-2005 19:07 CEST
Last Modified:              08-11-2005 19:07 CEST
======================================================================
Summary:                    Surround51 and surround40 don't work for Terratec
Aureon USB 5.1 Mk II
Description: 
Trying to use mplayer to play back a 6-channel wav file (it needs the
-channels option or it will use the default device and only play back the
first two channels despite reporting the file as containing 6 - I guess
this is a bug in mplayer):

mplayer -ao alsa -channels 6 123456.wav

...
alsa-init: 1 soundcard found, using: surround51
ALSA lib pcm.c:1959:(snd_pcm_open_conf) Invalid type for PCM surround51
definition (id: surround51, value: cards.pcm.surround51)
...

...and the equivalent for 4 channels.

BUT, if I override the surround51 device with a .asoundrc as follows:

pcm.!surround51 {
        type route
        slave.pcm "hw:0"
        slave.channels 6
        ttable.0.0 1
        ttable.1.1 1
        ttable.2.2 1
        ttable.3.3 1
        ttable.4.4 1
        ttable.5.5 1
}

then it works - as does an override for surround40.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-11-05 19:07 matthew_m      New Issue                                    
08-11-05 19:07 matthew_m      Kernel Version            => 2.6.11.4-21.8-smp
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
