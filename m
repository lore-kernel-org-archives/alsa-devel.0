From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/14] Revised patchset for PCM in-kernel copy
	support
Date: Thu, 25 May 2017 21:17:21 +0200
Message-ID: <20170525191735.13787-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 841EB266D63
 for <alsa-devel@alsa-project.org>; Thu, 25 May 2017 21:17:40 +0200 (CEST)
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
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a sort of RFC, a revised patchset of the previous two patches
for killing set_fs() usages in PCM.  Instead of converting to the
merged copy_silence ops, this adds a new copy_kernel ops instead.
At the same time, copy/silence are changed to receive the position and
size in bytes instead of frames.  This allows us to simplify the PCM
core code.  As a result, a good amount of code could be removed from
pcm_lib.c.

Note that this patchset isn't complete, containing only two driver
conversions (nm256 for interleaved and rme9652 for non-interleaved) as
a demonstration.


Takashi

===

Takashi Iwai (14):
  ALSA: pcm: Introduce copy_user, copy_kernel and fill_silence ops
  ALSA: nm256: Convert to new PCM copy ops
  ALSA: rme9652: Convert to the new PCM ops
  ALSA: pcm: Drop the old copy and silence ops
  ALSA: pcm: Check PCM state by a common helper function
  ALSA: pcm: Shuffle codes
  ALSA: pcm: Call directly the common read/write helpers
  ALSA: pcm: More unification of PCM transfer codes
  ALSA: pcm: Unify read/write loop
  ALSA: pcm: Simplify snd_pcm_playback_silence()
  ALSA: pcm: Direct in-kernel read/write support
  usb: gadget: u_uac1: Kill set_fs() usage
  ALSA: pcm: Kill set_fs() in PCM OSS layer
  ALSA: pcm: Build OSS writev/readv helpers conditionally

 drivers/usb/gadget/function/u_uac1.c |   7 +-
 include/sound/pcm.h                  |  80 ++++-
 sound/core/oss/io.c                  |   4 +-
 sound/core/oss/pcm_oss.c             |  81 +----
 sound/core/oss/pcm_plugin.h          |   6 +-
 sound/core/pcm_lib.c                 | 551 +++++++++++++----------------------
 sound/pci/nm256/nm256.c              |  57 ++--
 sound/pci/rme9652/rme9652.c          |  71 +++--
 sound/soc/soc-pcm.c                  |   5 +-
 9 files changed, 386 insertions(+), 476 deletions(-)

-- 
2.13.0
