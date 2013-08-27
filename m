From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/9] ALSA: compress offfload fixes
Date: Tue, 27 Aug 2013 12:10:30 +0530
Message-ID: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id DDFAE264F1E
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 09:25:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Here is the patch series which fixes various issues being reported by users (out
of tree sadly)

The first three and and last one are marked to stable as would like these to be
fixed in older kernels as well. It would be good if you can send them as fixes
to linus for 3.11.

Rest can go in the merge window

Fixes:
 - using lock for all operation was a very bad idead. This is bad as some of the
   ioctls like drain, partial drain can be time consuming and thus prevent any
other operation while these are ongoing like Pause, Stop or timestamp query, so
fix this be removing bunch of ioctls not to use device lock.
 - Now we dont have lock for pointer updates so this maybe racy, so use lock
   for doing lowest level calculation. 
 - As disscused on our sample rate problem, lets move to use rate values and I
   will fix the lib too. Since the driver are not upstream the impact of this
change wont be huge.
 - Plus few fix like use snprintf, state chacks for pause, write etc..


Vinod Koul (9):
  ALSA: Compress - dont use lock for all ioctls
  ALSA: compress: use mutex in drain
  ASoC: compress: dont aquire lock for draining states
  ALSA: compress: use snprint instread of sprintf
  ALSA: compres: wakeup the poll thread on pause
  ALSA: compress: dont write when stream is paused
  ALSA: compress: allow write when stream is setup
  ALSA: compress: call pointer callback and updates under a lock
  ALSA: compress: use rate values for passing sampling rates

 include/sound/compress_driver.h       |    2 +
 include/uapi/sound/compress_offload.h |    2 +-
 sound/core/compress_offload.c         |  140 +++++++++++++++++++++++++-------
 sound/soc/soc-compress.c              |   10 +++
 4 files changed, 122 insertions(+), 32 deletions(-)

Thanks
~Vinod
