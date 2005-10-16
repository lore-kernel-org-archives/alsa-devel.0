From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001464]: No digital passthrough for Turtle Beach Audio Advantage Micro
Date: Sun, 16 Oct 2005 03:50:29 +0200
Message-ID: <ac95db54e48fc13239fe9d84230d192f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EA7C2191
	for <alsa-devel@alsa-project.org>; Sun, 16 Oct 2005 03:50:29 +0200 (MEST)
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
Last Modified:              10-16-2005 03:50 CEST
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

----------------------------------------------------------------------
 mactalla - 10-16-05 03:50 
----------------------------------------------------------------------
UPDATE

I was looking in all the wrong places.  Links on the internet indicate
digital outputs must be "enabled".  So I thought it was harder than it
was.  As it turns out, the S/PDIF output is identical to the headphones
jack, and passthrough works just fine.

True the only volume control in alsamixer doesn't affect the optical out
(even when playing stereo), but I have enough volume dials that I don't
care.  As far as I'm concerned, this bug can be marked RESOLVE - NOTABUG
but I don't seem to have control to do that myself.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-27-05 00:35 mactalla       New Issue                                    
09-27-05 00:35 mactalla       Distribution              => Gentoo          
09-27-05 00:35 mactalla       Kernel Version            => 2.6.12-gentoo-r4
10-16-05 03:50 mactalla       Note Added: 0006481                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
