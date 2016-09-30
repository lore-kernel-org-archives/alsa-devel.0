From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 0/7] ALSA: Add rewinds disabled, delays,
	max_inflight_bytes
Date: Fri, 30 Sep 2016 18:13:23 +0530
Message-ID: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CC0C260083
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 14:50:06 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Set of patches to fix issues with delays, hw_ptr fuzziness [1] and
increased buffering w/ DSPs

1. Rewinds can be disabled  when data written in ring buffer will never be
validated. This allow for new HDaudio SPIB DMA functionality(allow fetch up to the
application pointer, no rewind supported)

2. Report max in-flight bytes to avoid problems with stale data (like late
wake-ups, rewinds)

3. add new estimate for USB startup delay.

[1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093646.html


Pierre-Louis Bossart (6):
  ALSA: core: let low-level driver or userspace disable rewinds
  ALSA: core: add .update_appl_ptr callback for pcm ops
  ALSA: core: add report of max inflight bytes
  ALSA: hda: add default value for max_inflight_bytes
  ALSA: usb: no_period_wake and max_inflight_bytes report
  ALSA: usb: take startup delay into account

Ramesh Babu (1):
  ALSA: pcm: avoid mmap of control data if .update_appl_ptr is
    implemented

 include/sound/pcm.h            |  4 +++
 include/uapi/sound/asound.h    |  6 ++--
 sound/core/pcm_lib.c           | 26 ++++++++++++++++++
 sound/core/pcm_native.c        | 51 +++++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_controller.c |  1 +
 sound/usb/card.h               |  1 +
 sound/usb/pcm.c                | 62 +++++++++++++++++++++++++++++++++++++-----
 7 files changed, 141 insertions(+), 10 deletions(-)

-- 
1.9.1
