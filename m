From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] Yet another fixes for ALSA timer info leaks
Date: Tue,  6 Jun 2017 17:00:39 +0200
Message-ID: <20170606150043.10525-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 95064266F30
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 17:00:51 +0200 (CEST)
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
Cc: Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Dmitriy Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@google.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patchset to paper over a bug in ALSA timer core code about
the race between read and ioctl.  As a side-effect of the race, it may
allow to read some uninitialized kmalloced memory.  The first two
patches cover the issue, so marked as stable, while the rest two
patches are rather cleanups and more hardening. 

I'm going to queue the first to for-linus for 4.12-rc, and the latter
two to for-next, for 4.13.


thanks,

Takashi

===

Takashi Iwai (4):
  ALSA: timer: Fix race between read and ioctl
  ALSA: timer: Fix missing queue indices reset at
    SNDRV_TIMER_IOCTL_SELECT
  ALSA: timer: Improve user queue reallocation
  ALSA: timer: Wrap with spinlock for queue access

 sound/core/timer.c | 103 ++++++++++++++++++++++++++---------------------------
 1 file changed, 51 insertions(+), 52 deletions(-)

-- 
2.13.0
