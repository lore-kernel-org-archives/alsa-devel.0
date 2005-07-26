From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001279]: Audigy2 NX produces crackles on USB2, fine on USB1
Date: Tue, 26 Jul 2005 10:19:54 +0200
Message-ID: <25cf6096b2e81f40cdb5882fbfb06cf5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1CBB11BB
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2005 10:19:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1279> 
======================================================================
Reported By:                bluebottle
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1279
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.12.2
======================================================================
Date Submitted:             07-24-2005 07:03 CEST
Last Modified:              07-26-2005 10:19 CEST
======================================================================
Summary:                    Audigy2 NX produces crackles on USB2, fine on USB1
Description: 
I recently upgraded to a 2.6.12.2 kernel (from 2.6.12) and now the Audigy2
NX is detected as a fully-fledged USB2 device. :)

But... it produces crackles in the sound that fade in and out over about a
two second period, continuously, upon trying to play any sound. The sound
does play, but has all those crackles in it. :(

If I go into BIOS and disable USB2, making my Audigy a USB1 device again,
it works very well indeed. :)
======================================================================

----------------------------------------------------------------------
 bluebottle - 07-26-05 09:52 
----------------------------------------------------------------------
OK, I compiled the CVS drivers (libraries won't compile - error 1) and now
it works again but in USB1 mode despite me enabling USB2 in the BIOS. At
least my other devices are USB2 again. :)

----------------------------------------------------------------------
 Clemens Ladisch - 07-26-05 10:19 
----------------------------------------------------------------------
The new driver doesn't enable the NX's USB2 mode with kernels before 2.6.13
because those kernels have a bug in the EHCI driver that corrupts memory
and eventually leads to a crash.

To get USB2 with 2.6.12, apply the patch in itd.patch, and replace the
version number in the line containing "KERNEL_VERSION(2, 6, 13)" in
alsa-driver/usb/usbaudio.patch before compiling ALSA.

What is the error when compiling the lib?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-24-05 07:03 bluebottle     New Issue                                    
07-24-05 07:03 bluebottle     Distribution              => Ubuntu          
07-24-05 07:03 bluebottle     Kernel Version            => 2.6.12.2        
07-24-05 09:58 bluebottle     Note Added: 0005557                          
07-25-05 11:03 Clemens LadischNote Added: 0005561                          
07-26-05 09:52 bluebottle     Note Added: 0005569                          
07-26-05 10:16 Clemens LadischFile Added: itd.patch                        
07-26-05 10:19 Clemens LadischNote Added: 0005570                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
