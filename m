From: Paul Ludwig Konecny <paul@konecny.at>
Subject: [BUG] AMD vga-switcheroo deactivates GPU+soundcard -
 ALSA can't handle this.
Date: Mon, 29 Sep 2014 13:26:17 +0200
Message-ID: <542941D9.4040500@konecny.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bsmtp.bon.at (bsmtp3.bon.at [213.33.87.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 074B82605FD
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 13:26:18 +0200 (CEST)
Received: from [20.0.0.5] (unknown [88.117.150.206])
 by bsmtp.bon.at (Postfix) with ESMTPSA id 3j61dM0Kq3z5tlJ
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 13:26:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm an average user and not a programmer. David Henningsson advised me
to contact this mailing-list to report my issue.
As this is my first post here I hope I'm doing everything right.

I'm having a problem with my HP EliteBook 850 G1.
This machine features Intel(i965, HD4400) / AMD(CIK, mesa-radeonsi,
HD8750M) hybrid-graphics
which is handled by vgaswitcheroo/PRIME and runtime power management.

When the discrete GPU and it's soundchip are deactivated by runtime
power management it seems that it is still reported to ALSA as
available. This "hangs" my entire sound system. I don't get any sound
out of this machine anymore.

As you can see in my alsa-info run it took around 400 seconds to access
HDMI2 which is the radeon soundchip. I believe that alsa-info only
finished because I did a "xrandr --listproviders" which breifly powered
up the AMD GPU. As this corresponds with the timespan I stared alsa-info
and issuing the xrandr command.

[   36.768463] HDMI ATI/AMD: no speaker allocation for ELD
[   36.804442] hda-intel 0000:03:00.1: Disabling via VGA-switcheroo
[   36.836422] hda-intel 0000:03:00.1: Cannot lock devices!
[   37.219319] [drm] Disabling audio 0 support
--
[  464.855900] 	status: r
[  465.620947] hda-intel 0000:03:00.1: Enabling via VGA-switcheroo
[  465.621063] snd_hda_intel 0000:03:00.1: irq 63 for MSI/MSI-X
[  465.623672] HDMI ATI/AMD: no speaker allocation for ELD


At first I believed it to be a pulseaudio problem and after several bug
reports I think I have traced the bug to the ALSA drivers.

This  bug report is the main/original one:
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1310260

David Henningsson pointed out here:
https://bugs.freedesktop.org/show_bug.cgi?id=83446

that he believes the bug to be in the alsa driver used by my machine.
This is why he changed the affected package in launchpad from
"pulseaudio" to "alsa-driver". He is also suggested posting
this issue here as the alsa bug tracker was taken offline.

A workaround that involves disabling the card via etc/modprobe.d (see
ubuntu bugreport) circumvents this issue for the time being but the
problem is that this kills my audio output via the laptop's DisplayPort
(It has no native HDMI Port).

The output of my alsa-info.sh run can be found here:
http://www.alsa-project.org/db/?f=fd4de60706f487ec48e41f7ac451030bbe79a9d7

I hope you can help me!
Thanks in advance!

Paul

P.S.: There is already a message to this list which is awaiting
moderation. David Henningsson told me to subscribe and send it again
this time directly to the list. The message in moderation can therefore
be deleted.
