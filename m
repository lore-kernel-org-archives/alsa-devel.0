From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001050]: Sound Blaster Audigy2 NX does not support 44,1kHz
Date: Mon, 16 May 2005 07:16:25 +0200
Message-ID: <37688202f33f37659a5236b2af533163@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EF6B6236
	for <alsa-devel@alsa-project.org>; Mon, 16 May 2005 07:16:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1050> 
======================================================================
Reported By:                gears
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1050
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     acknowledged
Distribution:               Ubuntu 5.04
Kernel Version:             2.6.10
======================================================================
Date Submitted:             04-13-2005 17:22 CEST
Last Modified:              05-16-2005 07:16 CEST
======================================================================
Summary:                    Sound Blaster Audigy2 NX does not support 44,1kHz
Description: 
For my hardware (Sound Blaster Audigy2 NX) the system also needs to set up
automatic sound conversion to 48000 instead of default 44100 or the sound
gets
badly distorted (at least it does so when using the spdif output). It also
needs
its speaker output unmuted.

the sound distortion is because ALSA claims it supports 44,1 kHz (hw:X),
although it really doesn't
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 04-25-05 10:47 
----------------------------------------------------------------------
The hardware does support 44.1 kHz, but the driver and the device cannot
agree on how to synchronize to each other.

I'm working on this.

----------------------------------------------------------------------
 WMCoolmon - 05-16-05 07:16 
----------------------------------------------------------------------
I'd also be very interested in seeing this fixed. Sound quality on par with
Windows is something I'd love to see in Linux; resampling never really
sounds as good.

It's great to hear someone's working on this. :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-05 17:22 gears          New Issue                                    
04-13-05 17:22 gears          Distribution              => Ubuntu 5.04     
04-13-05 17:22 gears          Kernel Version            => 2.6.10          
04-25-05 10:47 Clemens LadischNote Added: 0004571                          
04-25-05 10:47 Clemens LadischStatus                   assigned => acknowledged
05-16-05 07:16 WMCoolmon      Note Added: 0004675                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
