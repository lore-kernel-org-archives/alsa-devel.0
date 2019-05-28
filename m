From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 0/5] ALSA: line6 fixes and cleanups
Date: Tue, 28 May 2019 09:11:56 +0200
Message-ID: <20190528071201.27400-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8DDEF8072E
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 09:12:09 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 124DAADEC
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 07:12:09 +0000 (UTC)
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

this is a patchset I forgot to merge for fixing and impriving LINE6
drivers.  The v2 is rebased after the latest toneport fix, and
contains a cleanup with container_of(), too.


Takashi

===

Takashi Iwai (5):
  ALSA: line6: pod: Rewrite complex timer & work combo with a delayed
    work
  ALSA: line6: podhd: Rewrite complex timer & work combo with a delayed
    work
  ALSA: line6: variax: Rewrite complex timer & work combo with a delayed
    work
  ALSA: line6: Drop superfluous timer helper function
  ALSA: line6: Use container_of()

 sound/usb/line6/driver.c   |  11 ----
 sound/usb/line6/driver.h   |   9 ---
 sound/usb/line6/pod.c      | 108 +++++++++++------------------------
 sound/usb/line6/podhd.c    |  80 ++++----------------------
 sound/usb/line6/toneport.c |  14 ++---
 sound/usb/line6/variax.c   | 138 ++++++++++++++-------------------------------
 6 files changed, 94 insertions(+), 266 deletions(-)

-- 
2.16.4
