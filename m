From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3 0/2] ALSA: Add PCM USER_PVERSION ioctl
Date: Tue, 27 Jun 2017 12:29:42 +0200
Message-ID: <20170627102944.6836-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FCC3266B63
 for <alsa-devel@alsa-project.org>; Tue, 27 Jun 2017 12:29:47 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a revised patchset that is applied on top of the current
for-next branch, in order to optimize the appl_ptr sync on x86-64,
adapting the alsa-lib side change by Sakamoto-san's patchset.

Basically it adds a new ioctl for receiving the supported PCM protocol
version from user-space side, and change the mmap code to allow only
disabling the PCM status record depending on the supported protocol
version.  The former patch is identical with the previous version,
only the latter one differs.

The corresponding alsa-lib patch will follow.


thanks,

Takashi

===

Takashi Iwai (2):
  ALSA: pcm: Add an ioctl to specify the supported protocol version
  ALSA: pcm: Disable only control mmap for explicit appl_ptr sync

 include/sound/pcm.h         |  1 +
 include/uapi/sound/asound.h |  3 ++-
 sound/core/pcm_compat.c     |  1 +
 sound/core/pcm_native.c     | 29 ++++++++++++++++++++++++-----
 4 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.13.2
