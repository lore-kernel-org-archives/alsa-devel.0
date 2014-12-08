From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 0/9] audio timestamping evolutions
Date: Mon,  8 Dec 2014 16:23:37 -0600
Message-ID: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E9BE52604E9
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 23:24:13 +0100 (CET)
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

This series of patches was inspired by recent threads on the alsa
mailing list, as well issues detected with existing and upcoming
hardware:

1. there was a request from the PulseAudio community to get more
information from drivers to make rewinds safer. While the conclusion
was that it's nearly impossible for a driver developer to provide this
information, there are however ways to assess the granularity of the
hw_ptr updates using timestamping capabilities, and indirectly
understand how safe rewinds might be.

2. There was also a request to add a start_at capability based either
on system hr timers or a wall clock, which requires a means to expose
both types of information to applications. Rather than adding new sets
of timestamps, it is suggested the new start_at functionality relies
on the new audio_timestamp definitions provided here.

3. For new hardware, there is a neeed to let low-level drivers handle
timestamping instead of having the ALSA core do it. Similarly there is
a need to let the low-level driver update the initial estimate for the
trigger timestamp if there are delays to start a stream (eg. with USB)

These patches try to provide an answer to these multiple needs by
building on the work done two years ago to expose wall clock
information to applications. The evolution is to let application
select which audio timestamp they are interested in, track the delay
and drifts between recurring measurements and get, when possible, an
idea of the accuracy of the underlying hardware.

The first 4 patches are corrections for misses in the way the system
and trigger timestamps are handled, and the last 5 provide the
additional audio timestamping selection. A second batch is planned to
enable hardware capabilities in a low-level drivers.

A corresponding set of patches is available for alsa-lib.

TODO: for start_at, need to take audio tstamp snapshots even if stream
is not running.

Pierre-Louis Bossart (9):
  ALSA: core: don't override timestamp unconditionally
  ALSA: core: allow for trigger_tstamp snapshot in .trigger
  ALSA: hda: read trigger_timestamp immediately after starting DMA
  ALSA: usb: update trigger timestamp on first non-zero URB submitted
  ALSA: core: selection of audio_tstamp type and accuracy reports
  ALSA: core: pass audio tstamp config from userspace
  ALSA: core: pass audio tstamp config from userspace in compat mode
  ALSA: core: replace .wall_clock by .get_time_info
  ALSA: hda: replace .wallclock by .get_time_info

 Documentation/sound/alsa/timestamping.txt | 171 ++++++++++++++++++++++++++++++
 include/sound/pcm.h                       |  52 ++++++++-
 include/uapi/sound/asound.h               |  20 +++-
 sound/core/pcm_compat.c                   |   7 +-
 sound/core/pcm_lib.c                      |  81 +++++++++-----
 sound/core/pcm_native.c                   |  22 +++-
 sound/pci/hda/hda_controller.c            |  41 +++++--
 sound/usb/pcm.c                           |   9 ++
 8 files changed, 355 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/sound/alsa/timestamping.txt

-- 
2.1.0
