From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/53] Intel LPE audio driver cleanups
Date: Thu,  2 Feb 2017 18:02:13 +0100
Message-ID: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 38C4A2667E0
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:13 +0100 (CET)
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a fairly largish patchset to fix and clean up Intel LPE audio
driver.  Most of the patches are to clean up and refactoring of the
codes.  As you can see in the diffstat below, quite lots of codes
(over 1600 lines) are reduced.  Now the driver structure is flattened
to a single layer, and it looks much like a normal driver.

Besides the refactoring, there are a few major fixes: e.g. the fix for
the PCM disconnection that confuses PA,. the fix for the possible
sleep-in-atomic at hotplug, the fix for racy chmap accesses.

As new features, the driver supports the runtime PM properly now, it
sets the CA bit for DP, and it exposes the ELD via ALSA control
element.

The current code is available in topic/intel-lpe-audio-cleanup branch,
and it's based on the DP-audio branch, topic/intel-lpe-audio-dp that
I'm going to merge to for-next soon.


Takashi

===

Takashi Iwai (53):
  ALSA: x86: Don't set PCM state to DISCONNECTED
  ALSA: x86: Remove v1 ops and structs
  ALSA: x86: Drop indirect calls of had_ops
  ALSA: x86: Replace indirect register ops with direct calls
  ALSA: x86: Replace indirect query_ops with direct calls
  ALSA: x86: Drop snd_intel_had_interface indirect calls
  ALSA: x86: Pass snd_intelhad object to helpers
  ALSA: x86: Handle the error from hdmi_audio_probe() properly
  ALSA: x86: Drop useless mutex at probe
  ALSA: x86: Call event callback directly
  ALSA: x86: Fix possible stale interrupt calls
  ALSA: x86: Drop unused mid_hdmi_audio_is_busy()
  ALSA: x86: Drop the global platform device reference
  ALSA: x86: Drop global hlpe_state
  ALSA: x86: Drop global ELD copy
  ALSA: x86: Move the global underrun_count to struct snd_intelhad
  ALSA: x86: Drop unused hw_silence field
  ALSA: x86: Move dma_mask debug print into intel_hdmi_lpe_audio.c
  ALSA: x86: Embed snd_intelhad into snd_card
  ALSA: x86: Drop superfluous CHT PCI ID check
  ALSA: x86: Check platform_data earlier
  ALSA: x86: Call snd_card_register() at the end
  ALSA: x86: Drop unused hdmi_audio_query()
  ALSA: x86: Flatten two abstraction layers
  ALSA: x86: Fold intel_hdmi_audio_if.c into main file
  ALSA: x86: Replace pr_xxx() with dev_xxx()
  ALSA: x86: Fix for CONFIG_PM=n
  ALSA: x86: Remove indirect call of snd_pcm_period_elapsed()
  ALSA: x86: Drop unused fields from snd_intelhad struct
  ALSA: x86: Drop superfluous PCM private_free
  ALSA: x86: Fix sleep-in-atomic via i915 notification
  ALSA: x86: Remove superfluous check at resume
  ALSA: x86: Drop had_get_hwstate()
  ALSA: x86: Tidy up codes
  ALSA: x86: Remove _v[12] suffices
  ALSA: x86: Constfy tables
  ALSA: x86: Remove superfluous irqsave flags
  ALSA: x86: Fix racy access to chmap
  ALSA: x86: Drop flag_underrun field
  ALSA: x86: Drop superfluous state field
  ALSA: x86: Drop redundant had_stream_pvt
  ALSA: x86: Drop unused fields from pcm_stream_info
  ALSA: x86: Properly manage PCM substream lifetype
  ALSA: x86: Implement runtime PM
  ALSA: x86: Move stream status into pcm_stream_info
  ALSA: x86: Use the standard ELD bytes definitions
  ALSA: x86: Reduce redundant register field names
  ALSA: x86: Clean up unused defines and inclusions
  ALSA: x86: Create ELD control element
  ALSA: x86: Set CA bits for DisplayPort too
  ALSA: x86: Simplify comments
  ALSA: x86: Yet more tidy-up and clean-ups
  ALSA: x86: Rename drv_status to connected

 sound/x86/Makefile               |    4 +-
 sound/x86/intel_hdmi_audio.c     | 1901 +++++++++++++++++++-------------------
 sound/x86/intel_hdmi_audio.h     |  117 +--
 sound/x86/intel_hdmi_audio_if.c  |  548 -----------
 sound/x86/intel_hdmi_lpe_audio.c |  665 -------------
 sound/x86/intel_hdmi_lpe_audio.h |  470 ++--------
 6 files changed, 1026 insertions(+), 2679 deletions(-)
 delete mode 100644 sound/x86/intel_hdmi_audio_if.c
 delete mode 100644 sound/x86/intel_hdmi_lpe_audio.c

-- 
2.11.0
