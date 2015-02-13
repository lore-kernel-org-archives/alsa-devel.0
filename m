From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v6 0/7] audio timestamping evolutions
Date: Fri, 13 Feb 2015 15:14:02 -0600
Message-ID: <1423862049-4073-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A9978260654
 for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2015 22:14:21 +0100 (CET)
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
on the new definition provides by these patches

3. For new hardware, there is a neeed to let low-level drivers
handle timestamping instead of having the ALSA core do
it. Similarly there is a need to let the low-level driver update
the initial estimate for the trigger timestamp if there are
delays to start a stream (eg. with USB)

These patches try to provide an answer to these multiple needs by
building on the work done two years ago to expose wall clock
information to applications. The evolution is to let application
select which audio timestamp they are interested in, track the delay
and drifts between recurring measurements and get, when possible, an
idea of the accuracy of the underlying hardware. A backwards compatible mode
is provided in case userspace doesn't provide any timestamp selection (results
based on HDAudio wallclock for playback, hw_ptr in all other cases). 

The first 4 patches are corrections for misses in the way the system
and trigger timestamps are handled, and the last 6 provide the
additional audio timestamping selection. A second batch is planned to
enable hardware capabilities in a low-level drivers.

A corresponding set of patches is available for alsa-lib.

V2 changes:

trigger_tstamp:
trigger_tstamp_latched, pending redefined as bool
trigger_tstamp_latched reset in snd_pcm_pre_start()

audio_ts_config, report:
keep separate structure but use different bitfields for in and out.
use u32 instead of __u32, add comments that these structures are internal
COMPAT backwards compatible mode, uses WALL_CLOCK/LINK for HDAudio
playback and DEFAULT (hw_ptr) everywhere else

INFO bits:
reclaimed 32-bits from hw_params, renamed as info_ext
moved all timestamp info to info_ext

snd_pcm_status:
read only 32-bit audio_tstamp_data, ignore all other fields

V3/4:
Addressed feedback from Jaroslav:
no change to STATUS ioctl, new functionality introduced in STATUS_EXT
ioctl with r/w params.
bumped PCM protocol for detection on STATUS_EXT in userspace
used 32-bit word for accuracy report, no mantissa/exponent packing
rolled back info_ext changes, all INFO fields remain in same word

Merged comments from Liam (code simplifications)
fixed packing

Added driver_tstamp field in case there is a delay in passing the 
tstamp and audio_tstamp over IPC.

v5: no functional change, only addressed Takashi comments on patch 2,3,4
fixed used of bool with true/false and ! in comparisons
move trigger_tstamp_pending_update flag to snd_usb_substream, will be 
used by ALSA core when other devices need it

v6:
rebased on v3.19-rc7 after merge of initial 4 patches
address Takashi's comments: simplified parameter handling, const and zero-clear cleanups in pcm.h, fix git-bisect issue

Pierre-Louis Bossart (7):
  ALSA: core: selection of audio_tstamp type and accuracy reports
  ALSA: core: pass audio tstamp config from userspace
  ALSA: core: pass audio tstamp config from userspace in compat mode
  ALSA: core: add .get_time_info
  ALSA: hda: replace .wallclock by .get_time_info
  ALSA: core: remove .wall_clock
  ALSA: bump PCM protocol to 2.0.13

 Documentation/sound/alsa/timestamping.txt | 200 ++++++++++++++++++++++++++++++
 include/sound/pcm.h                       |  66 +++++++++-
 include/uapi/sound/asound.h               |  36 +++++-
 sound/core/pcm_compat.c                   |  28 ++++-
 sound/core/pcm_lib.c                      |  88 ++++++++-----
 sound/core/pcm_native.c                   |  41 +++++-
 sound/pci/hda/hda_controller.c            |  40 ++++--
 7 files changed, 444 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/sound/alsa/timestamping.txt

-- 
1.9.1
