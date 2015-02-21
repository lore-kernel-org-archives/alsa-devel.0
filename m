From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 0/5] alsa-lib: audio timestamping evolutions
Date: Fri, 20 Feb 2015 18:28:09 -0600
Message-ID: <1424478494-5135-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B167D26147D
 for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2015 01:28:27 +0100 (CET)
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

alsa-lib side of kernel patches already merged on topic/timestamp.

Pierre-Louis Bossart (5):
  sync asound.h with kernel version
  add support for get/set_audio_htstamp_config
  pcm: add helper functions to query timestamping capabilities
  pcm: add support for new STATUS_EXT ioctl
  test: fix audio_time with new get/set audio_tstamp_config

 include/pcm.h          |  47 ++++-
 include/sound/asound.h |  37 +++-
 src/pcm/pcm.c          |  73 +++++++-
 src/pcm/pcm_hw.c       |  16 +-
 test/audio_time.c      | 491 +++++++++++++++++++++++++++++++------------------
 5 files changed, 475 insertions(+), 189 deletions(-)

-- 
1.9.1
