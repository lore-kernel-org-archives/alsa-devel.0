From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/4] better support for bursty DMA usages
Date: Wed,  8 Jul 2015 05:10:32 -0500
Message-ID: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 39D7C260470
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 12:10:56 +0200 (CEST)
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Set of patches to fix issues with hw_ptr fuzziness [1] and increased buffering
 w/ DSPs

1. disable rewinds to allow for new HDaudio SPIB DMA functionality (fetch up to
the application pointer, rewinds not supported)
2. report max in-flight bytes to avoid problems with stale data (late wake-ups,
rewinds)

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093646.html

TODO:
1. fixes and alsa-lib updates (compile-tested only for now)
2. get feedback
3. if supported, set DMA buffering based on negotiation between driver and app (capabilities vs. 
latency needs)

Pierre-Louis Bossart (4):
  ALSA: core: let low-level driver or userspace disable rewinds
  ALSA: core: add .notify callback for pcm ops
  ALSA: core: add report of max dma burst
  ALSA: hda: add default value for max_dma_burst

 include/sound/pcm.h            |  5 +++++
 include/uapi/sound/asound.h    |  6 ++++--
 sound/core/pcm_lib.c           | 19 +++++++++++++++++++
 sound/core/pcm_native.c        | 33 ++++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_controller.c |  1 +
 5 files changed, 61 insertions(+), 3 deletions(-)

-- 
1.9.1
