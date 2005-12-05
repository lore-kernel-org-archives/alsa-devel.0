From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001599]: ac97 with SiS SI7012 [ALC203 rev 0] doesn't handle master volume, uses headphone channel instead
Date: Mon, 5 Dec 2005 17:46:36 +0100
Message-ID: <cd92f8ca65619826142760c6fcc2c6e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6BA0A161
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2005 17:46:37 +0100 (MET)
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
Last Modified:              12-05-2005 17:46 CET
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

----------------------------------------------------------------------
 wiktorw - 11-27-05 18:47 
----------------------------------------------------------------------
Hmmmmm.

Today I recompiled the 2.6.14-r3 kernel and I've taken the opportunity to
disable ALSA in-kernel drivers. So I've installed out-of-kernel
alsa-driver
instead (1.0.10_rc3) and I must say that the problem has gone.

I don't have the "Headphone" track anymore, and the "Master" track works
exactly as it should. That's a really good puzzle for me...

Anyway, this bug can be closed. I'm sorry that I bothered you for so
long.
I'll let you know on the next kernel upgrade if there is any difference
for me with in- and out-of-kernel alsa-driver.

Please close the bug, resolution INVALID.

----------------------------------------------------------------------
 wiktorw - 12-05-05 17:46 
----------------------------------------------------------------------
Today I've upgraded my kernel to the 2.6.14-r3 and as I promised,
I did a check if the in-kernel driver works correctly w.r.t.
the "Headphone" track.

Exactly as I suspected the problem showed up again.
You can see the offending screenshot here:
http://ics.p.lodz.pl/~wiktorw/alsa-problem/C_After_upgrade_2.6.14-gentoo-r4_Volume_Control.png

Interesting version details of kernel & alsa-driver follows:

# uname -a
Linux widmo 2.6.14-gentoo-r4 #2 PREEMPT Mon Dec 5 15:56:44 CET 2005
i686 AMD Turion(tm) 64 Mobile Technology ML-30 AuthenticAMD GNU/Linux

# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.10rc1
(Mon Sep 12 08:13:09 2005 UTC).

I guess that if the in-kernel alsa-driver was 1.0.10 [final],
I wouldn't have this issue anymore.

OTOH the standalone alsa-driver version I have is:

# emerge -pv alsa-driver

These are the packages that I would merge, in order:

Calculating dependencies ...done!
[ebuild   R   ] media-sound/alsa-driver-1.0.10_rc3  -doc +oss 0 kB

And I have the ability to use the "testing" version:
alsa-driver-1.0.10 as well. But probably I'll wait
for the official "stable" release in my distribution.

I'll let you know what is the status of this issue
for in- and out-of-kernel alsa-driver, when I do the
upgrade to the 2.6.15 kernel.

Regards,
Wiktor Wandachowicz

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-25-05 17:40 wiktorw        New Issue                                    
11-25-05 17:40 wiktorw        Distribution              => Gentoo 2005.1   
11-25-05 17:40 wiktorw        Kernel Version            => 2.6.14-r2 (2.6.14.3)
11-27-05 18:47 wiktorw        Note Added: 0006852                          
12-05-05 17:46 wiktorw        Note Added: 0006913                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
