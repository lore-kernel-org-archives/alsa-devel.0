From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 0/3] ALSA: Add the explicit appl_ptr sync
	support
Date: Wed, 21 Jun 2017 17:31:11 +0200
Message-ID: <20170621153114.6207-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 638982673B5
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 17:31:17 +0200 (CEST)
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

this is a revised patchset for supporting the explicit appl_ptr
update.  Since the protocol version from user-space needs to be stored
locally for each opened file, the check of status/control mmap was
slightly changed as well.  But the basic strategy is same as the
previous patchset.

Note that this patchset doesn't solve the issue that appl_ptr update
isn't properly notified to ack ops as Sakamoto-san pointed out
previously.  We'll still need to sort it out.  But the hack I
introduced here doesn't basically conflict with it, and it'll even
make it easier to solve later, by the new USER_PVERSION ioctl.


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
 sound/core/pcm_native.c     | 34 ++++++++++++++++++++++++++++++++--
 4 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.13.1
