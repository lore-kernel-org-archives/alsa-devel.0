From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH 0/3] line6 locking and segfault fixes
Date: Thu, 18 Aug 2016 23:52:09 +0200
Message-ID: <1471557132-10206-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 72287266199
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 23:52:47 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id q128so1220794wma.1
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 14:52:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, stefanha@gmail.com, grabner@icg.tugraz.at, alsa-devel@alsa-project.org
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

These are already seen patches fixing a few locking issues, now split out of the
POD-X3 patchset.

In addition, pod sysfs attributes touched something else than they thought,
causing segfaults - fixed it (tested with the same code in podhd)...

Andrej Krutak (3):
  ALSA: line6: Remove double line6_pcm_release() after failed acquire.
  ALSA: line6: Give up on the lock while URBs are released.
  ALSA: line6: Fix POD sysfs attributes segfault

 sound/usb/line6/pcm.c |  3 ++-
 sound/usb/line6/pod.c | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
1.9.1
