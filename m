From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] ALSA: yet more timer cleanup and fixes
Date: Wed, 27 Mar 2019 17:52:13 +0100
Message-ID: <20190327165217.4240-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C4B7F8071D
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 17:52:19 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E4BCEADAA
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 16:52:18 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

while looking at the old syzkaller reports, I noticed that there are
still some possible races around closing the timer object.  Here is a
patch set to cover it as well as some relevant cleanups / fixes.

I haven't set stable to Cc in them since they are really corner
cases, and they haven't been tested much.  But they should be safe
(and easy) to backport, too, if any.


Takashi

===

Takashi Iwai (4):
  ALSA: timer: Unify timer callback process code
  ALSA: timer: Make sure to clear pending ack list
  ALSA: timer: Check ack_list emptiness instead of bit flag
  ALSA: timer: Make snd_timer_close() really kill pending actions

 include/sound/timer.h |   1 -
 sound/core/timer.c    | 123 ++++++++++++++++++++++++++++++--------------------
 2 files changed, 74 insertions(+), 50 deletions(-)

-- 
2.16.4
