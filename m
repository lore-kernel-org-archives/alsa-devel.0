From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 0/6] ALSA core X32 ABI fixes
Date: Mon, 29 Feb 2016 17:16:39 +0100
Message-ID: <1456762605-2451-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 554D6260535
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:16:50 +0100 (CET)
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
Cc: Steven Newbury <steve@snewbury.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

this is the revised patchset for fixing the incompatible ioctls in
ALSA core with X32 ABI.  Too bad that we have to deal in this way, but
it's life...


Takashi

===

Takashi Iwai (6):
  ALSA: ctl: Fix ioctls for X32 ABI
  ALSA: pcm: Fix ioctls for X32 ABI
  ALSA: rawmidi: Use comapt_put_timespec()
  ALSA: rawmidi: Fix ioctls X32 ABI
  ALSA: timer: Fix broken compat timer user status ioctl
  ALSA: timer: Fix ioctls for X32 ABI

 sound/core/control_compat.c |  90 ++++++++++++++++++----
 sound/core/pcm_compat.c     | 177 +++++++++++++++++++++++++++++++++++++++++++-
 sound/core/rawmidi_compat.c |  56 +++++++++++++-
 sound/core/timer_compat.c   |  18 ++++-
 4 files changed, 320 insertions(+), 21 deletions(-)

-- 
2.7.2
