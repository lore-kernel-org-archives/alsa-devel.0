From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001599]: ac97 with SiS SI7012 [ALC203 rev 0] doesn't handle master volume, uses headphone channel instead
Date: Fri, 25 Nov 2005 17:40:23 +0100
Message-ID: <0046986569ab95ffe3b68f081b777363@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 22C88196
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2005 17:40:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1599> 
======================================================================
Reported By:                wiktorw
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1599
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo 2005.1
Kernel Version:             2.6.14-r2 (2.6.14.3)
======================================================================
Date Submitted:             11-25-2005 17:40 CET
Last Modified:              11-25-2005 17:40 CET
======================================================================
Summary:                    ac97 with SiS SI7012 [ALC203 rev 0] doesn't handle
master volume, uses headphone channel instead
Description: 
In the Issue #1510 tiwai wrote:

> Closing this bug since the original reporter found a solution.

Sorry but the mentioned solution to the problem is not optimal.
In fact, this would only hide the original problem.


There is some quirk in the handling of SiS SI7012 by ALSA drivers and/or
ALSA libs. The master channel never changes the volume level. But somehow
the "Headphone" channel does similar work.

I know that there were some serious changes and tweaks wrt headphones
handling on this chipset. They are described in the following issues:

* https://bugtrack.alsa-project.org/alsa-bug/view.php?id=664
* https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1486
* https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14
* https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1162



I managed to run Windows XP on this machine in order to test if the
problem
manifests itself there. In short: no. I took some screenshots to document
what I've done. You can find them here:

http://ics.p.lodz.pl/~wiktorw/alsa-problem/

Comments to the pictures:

1) I turned on all possible playback volume controls
2) That's how the full volume panel looks like

   NOTE: there is no headphone volume control

3a) If I slide the master volume control, the volume in the internal
speakers
    changes, the same is with the wave volume control.

   NOTE: if I plug the headphones, the volume also changes
   NOTE: looks like the internat speakers and headphones might be
         connected / linked by the manufacturer, inside the machine


I tested my volume problem under Ubuntu 5.04 and Knoppix 4.02.
Can't tell the driver/kernel versions (haven't written them down),
but from simple tests (including "alsamixer") the problem is the same.
At least it's consistent :-/


I also upgraded the kernel in my Gentoo installation to the 2.6.14-r2
(the official 2.6.14.3) version, and also upgraded the following
packages:

media-sound/alsa-headers-1.0.10_rc3
media-libs/alsa-lib-1.0.10_rc3
media-sound/alsa-utils-1.0.10_rc3

IIRC, this kernel contains alsa-drivers-1.0.10_rc3 so everything should
be
in sync. However, the problem remains.

The following screenshots demonstrates my Linux settings:

4) I turned on all possible volume tracks
5) That's how the full volume control applet looks like
6a) If I slide the Headphone or PCM track, volume changes.
    Master track does nothing.

7) I have to set the PCM as a default track for the volume applet, in
order
   to get any volume change using the speaker applet in the system tray. 

8) Changing the volume using the speaker slider (in the lower right
corner)
9a) One can see that PCM and a speaker slider are the same.
    If I select the Master track for the applet, the volume doesn't
change.

A) The same issue hits the console alsamixer.
B) If I change the Headphone or PCM track, volume changes.
   Master track still does nothing.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-25-05 17:40 wiktorw        New Issue                                    
11-25-05 17:40 wiktorw        Distribution              => Gentoo 2005.1   
11-25-05 17:40 wiktorw        Kernel Version            => 2.6.14-r2 (2.6.14.3)
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
