From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001410]: Request: please enable 44.1khz playback on Audigy 2 NX
Date: Sat, 10 Sep 2005 06:41:36 +0200
Message-ID: <000705ded6bfdb13e44fdc9ce9e50335@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C1FBC183
	for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2005 06:41:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1410> 
======================================================================
Reported By:                wshtb
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1410
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-10-2005 06:41 CEST
Last Modified:              09-10-2005 06:41 CEST
======================================================================
Summary:                    Request: please enable 44.1khz playback on Audigy 2
NX
Description: 
It saw somewhere in the changelog that 44.1khz playback on Audigy 2 NX is
buggy so it is disabled in the latest source. However it seems that
44.1khz playback in digital-output-only mode is working perfectly.

I have used a Audigy 2 NX to send 44.1khz signal to external DAC for
several month in my home theater setup (with kernel 2.6.12.x). The driver
has been rock solid (thank you guys!). Although I do need to set the
output frequency to 44.1khz using a Windows laptop, that is necessary only
after the sound card lost its power, i.e. unplugging the power adapter. 

In kernel 2.6.13 or the latest alsa-driver, 44.1khz playback is disabled.
I'd like to know if it is possible to re-enable it? It is a nice feature
that the hardware is capable and the driver is available. Maybe something
similar to Windows can be done: user must select digital-only mode before
44.1khz output becomes an option; once in digital-only mode, all analog
channels are muted. 

What do you think? Maybe the output frequency can be fixed by user intead
of by the music source being played. Is it hard to implement?
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-10-05 06:41 wshtb          New Issue                                    
09-10-05 06:41 wshtb          Distribution              => Fedora Core 4   
09-10-05 06:41 wshtb          Kernel Version            => 2.6.13          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
