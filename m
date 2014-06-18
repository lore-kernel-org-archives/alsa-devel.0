From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [v3.13.y][SRU][PATCH 0/1] ALSA: usb-audio: Prevent printk ratelimiting from spamming kernel log while DEBUG not defined
Date: Wed, 18 Jun 2014 13:14:05 -0400
Message-ID: <cover.1400085278.git.joseph.salisbury__15745.0094040998$1403111684$gmane$org@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kamal.mostafa@canonical.com
Cc: perex@perex.cz, tiwai@suse.de, eldad@fogrefinery.com, clemens@ladisch.de, tim.gardner@canonical.com, stern@rowland.harvard.edu, linux@eikelenboom.it, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

BugLink: http://bugs.launchpad.net/bugs/1319457

Hello,

Please consider including upstream commit b7a77235 in the next v3.13.y release.  It was included upstream as of v3.15-rc5.  It has been tested and confirmed to resolve http://bugs.launchpad.net/bugs/1319457 .

commit b7a7723513dc89f83d6df13206df55d4dc26e825
Author: Sander Eikelenboom <linux@eikelenboom.it>
Date:   Fri May 2 15:09:27 2014 +0200

    ALSA: usb-audio: Prevent printk ratelimiting from spamming kernel log while DEBUG not defined


This commit does not apply cleanly to v3.13, so I performed a backport, which is in email 1/1. 


Sander Eikelenboom (1):
  ALSA: usb-audio: Prevent printk ratelimiting from spamming kernel log
    while DEBUG not defined

 sound/usb/pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1
