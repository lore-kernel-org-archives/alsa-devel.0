From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] aloop fixes
Date: Fri,  5 Jan 2018 16:54:25 +0100
Message-ID: <20180105155428.14621-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F841267A53
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 16:54:31 +0100 (CET)
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
Cc: Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a set of fixes for aloop bugs that have been revealed recently
by syzkaller.  The first and the last are not directly triggered by
syzkaller but nasty bugs spotted during debugging.

The third patch is the revised one of the previous patch I sent
yesterday.

I'm going to queue these and include to the next pull request, but
it'll likely slip to rc8.
So, Dmitry, if you'd like to suppress the similar errors earlier,
please put these three into syzkaller.


thanks,

Takashi

===

Takashi Iwai (3):
  ALSA: aloop: Release cable upon open error path
  ALSA: aloop: Fix inconsistent format due to incomplete rule
  ALSA: aloop: Fix racy hw constraints adjustment

 sound/drivers/aloop.c | 98 ++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 48 deletions(-)

-- 
2.15.1
