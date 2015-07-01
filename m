From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 0/5] alsa-lib: audio timestamping evolutions
Date: Wed,  1 Jul 2015 15:40:53 -0500
Message-ID: <1435783258-23730-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 48B4E265068
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 22:41:18 +0200 (CEST)
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

alsa-lib side of kernel patches already merged for 4.1.

V4: added simple log to show timestamp report and accuracy

Pierre-Louis Bossart (5):
  pcm: add helper functions to query timestamping capabilities
  pcm: add support for get/set_audio_htstamp_config
  pcm: add support for new STATUS_EXT ioctl
  test: fix audio_time with new get/set audio_tstamp_config
  test: audio_time: show report validity and accuracy

 include/pcm.h     |  47 ++++-
 src/pcm/pcm.c     |  73 +++++++-
 src/pcm/pcm_hw.c  |  16 +-
 test/audio_time.c | 515 +++++++++++++++++++++++++++++++++++-------------------
 4 files changed, 465 insertions(+), 186 deletions(-)

-- 
1.9.1
