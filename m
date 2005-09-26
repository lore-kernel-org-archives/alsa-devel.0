From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001464]: No digital passthrough for Turtle Beach Audio Advantage Micro
Date: Tue, 27 Sep 2005 00:35:47 +0200
Message-ID: <a2c8c8ece19709bc158b5e5794a5c4dd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ED85B12A
	for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2005 00:35:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1464> 
======================================================================
Reported By:                mactalla
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1464
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.12-gentoo-r4
======================================================================
Date Submitted:             09-27-2005 00:35 CEST
Last Modified:              09-27-2005 00:35 CEST
======================================================================
Summary:                    No digital passthrough for Turtle Beach Audio
Advantage Micro
Description: 
After loading the snd-usb-audio module, alsamixer only displays a single
control (PCM).  This correctly controls the headphone jack on the sound
card, but does not control the S/PDIF output.  The S/PDIF does output
stereo sound.

Bug 0001438 also requests digital passthrough for snd-usb-audio, but since
I have a different lsusb output, this may require attention of its own.

I've included lsusb -v output, but am more than happy to do any additional
poking around to figure out the hardware (just need to be told what).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-27-05 00:35 mactalla       New Issue                                    
09-27-05 00:35 mactalla       Distribution              => Gentoo          
09-27-05 00:35 mactalla       Kernel Version            => 2.6.12-gentoo-r4
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
