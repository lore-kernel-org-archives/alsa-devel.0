From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 0/4] alsa-lib: audio timestamping evolutions
Date: Mon,  8 Dec 2014 16:28:42 -0600
Message-ID: <1418077726-8516-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E883265375
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 23:29:01 +0100 (CET)
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

alsa-lib patches corresponding to the kernel ones just posted.
Tested with HDAudio and USB audio class.

Pierre-Louis Bossart (4):
  sync asound.h with kernel version
  add support for get/set_audio_htstamp_config
  pcm: add helper functions to query timestamping capabilities
  test: fix audio_time with new get/set audio_tstamp_config

 include/pcm.h          |  43 ++++-
 include/sound/asound.h |  20 ++-
 src/pcm/pcm.c          |  82 ++++++++-
 test/audio_time.c      | 473 +++++++++++++++++++++++++++++++------------------
 4 files changed, 436 insertions(+), 182 deletions(-)

-- 
2.1.0
