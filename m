From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] Replace with alloc_pages_exact(), take#2
Date: Wed, 27 Mar 2019 10:29:57 +0100
Message-ID: <20190327092959.30382-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93AA7F8963E
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 10:30:01 +0100 (CET)
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
Cc: Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a renewed attempt to replace __get_free_pages() usages with
alloc_pages_exact() in sound tree.  At this time, the incorrectly
leftover of __GFP_COMP flag is removed altogether.


thanks,

Takashi

===

Takashi Iwai (2):
  ALSA: Replace snd_malloc_pages() and snd_free_pages() with standard
    helpers, take#2
  ALSA: us122l: Use alloc_pages_exact()

 include/sound/memalloc.h        |  4 ----
 sound/core/memalloc.c           | 53 +++--------------------------------------
 sound/core/pcm.c                | 14 +++++------
 sound/usb/usx2y/usX2Yhwdep.c    |  3 ++-
 sound/usb/usx2y/usb_stream.c    | 20 +++++++---------
 sound/usb/usx2y/usbusx2y.c      |  3 ++-
 sound/usb/usx2y/usx2yhwdeppcm.c |  6 +++--
 7 files changed, 26 insertions(+), 77 deletions(-)

-- 
2.16.4
