From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] ALSA: Add the explicit appl_ptr sync
	support
Date: Tue, 20 Jun 2017 17:33:49 +0200
Message-ID: <20170620153352.27775-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 154DC26732C
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 17:33:56 +0200 (CEST)
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

this is a patchset for the issues we've discussed recently lengthily,
the explicit sync of appl_ptr by disabling the control mmap.
The first patch achieves it for a driver setting the new INFO flag.

The second patch is for a generic ABI extension I wanted to implement
for long time.  It allows user-space reporting its supporting protocol
version, so that the kernel can behave differently.  It's especially
useful for extending the ABI struct to use the reserved bits.

The third patch is the optimization by the second patch; it simply
skips the previous workaround when the user-space declares itself
being new enough to support the feature.

The corresponding alsa-lib patchset will follow in another thread.


thanks,

Takashi

===

Takashi Iwai (3):
  ALSA: pcm: Add the explicit appl_ptr sync support
  ALSA: pcm: Add an ioctl to specify the supported protocol version
  ALSA: pcm: Limit the appl_ptr sync workaround only for old user-space

 include/sound/pcm.h         |  1 +
 include/uapi/sound/asound.h |  4 +++-
 sound/core/pcm_compat.c     |  1 +
 sound/core/pcm_native.c     | 28 ++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.13.1
