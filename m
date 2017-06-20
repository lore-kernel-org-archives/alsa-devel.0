From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 0/4] Add the support for explicit sync
	of appl_ptr
Date: Tue, 20 Jun 2017 17:35:20 +0200
Message-ID: <20170620153524.28099-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D1F2226735E
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 17:35:28 +0200 (CEST)
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

this is a patchset for alsa-lib corresponding to the patchset I've
sent for kernel.  The first two patches do the actual fixes, while the
last two are merely cleanups / optimizations.


thanks,

Takashi

===

Takashi Iwai (4):
  pcm: hw: Add the support for explicit sync of appl_ptr
  pcm: hw: Call USER_PVERSION ioctl at open
  pcm: hw: Remove superfluous call of snd_pcm_set_appl_ptr()
  pcm: hw: Reduce redundant sync_ptr() calls

 include/sound/asound.h |  4 +++-
 src/pcm/pcm_hw.c       | 47 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.13.1
