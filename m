From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] ALSA: line6: Cleanup startup sequences
Date: Wed,  8 May 2019 16:49:39 +0200
Message-ID: <20190508144943.8139-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8B9CF896E6
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 16:49:44 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id EEF8EAE9D
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 14:49:43 +0000 (UTC)
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

while debugging line6 toneport driver bug, I noticed that other line6
drivers have too complex and fragile startup sequences.  This is the
result of the rewrites with a single delayed work.  Maybe for 5.3, as
these are no critical fixes.


Takashi

===

Takashi Iwai (4):
  ALSA: line6: pod: Rewrite complex timer & work combo with a delayed
    work
  ALSA: line6: podhd: Rewrite complex timer & work combo with a delayed
    work
  ALSA: line6: variax: Rewrite complex timer & work combo with a delayed
    work
  ALSA: line6: Drop superfluous timer helper function

 sound/usb/line6/driver.c |  11 -----
 sound/usb/line6/driver.h |   9 ----
 sound/usb/line6/pod.c    |  85 ++++++++++++--------------------
 sound/usb/line6/podhd.c  |  73 +++++----------------------
 sound/usb/line6/variax.c | 125 ++++++++++++++---------------------------------
 5 files changed, 78 insertions(+), 225 deletions(-)

-- 
2.16.4
