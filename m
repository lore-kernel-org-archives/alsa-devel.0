From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [RFC PATCH 0/7] adapt SOF to use snd-hda-codec-hdmi
Date: Thu, 29 Aug 2019 16:53:41 +0300
Message-ID: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26342F8987F
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 15:54:02 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi all,
here's a RFC patch series that adapts SOF (and one example machine
driver) to use snd-hda-codec-hdmi (patch_hdmi.c) codec driver
instead of hdac_hdmi (soc/codecs/hdac_hdmi.c). The primary goal
is unify the HDMI codec implementation between DSP and non-DSP HDA
configurations, offer same interface to user-space and reduce
maintenance load for all.

Main points I'd like your input on:

1) Is the high-level approach ok?
 - SOF already uses pci/hda/ for all others codecs, so HDMI
   has been the sole exception where code has been duplicated.
 - I've tried to keep changes to hda/hdmi minimal.
 - This series implements logic to parse the PCM topology
   in a dynamic fashion, so we do not have to change all
   existing (and future) DSP topologis to use fixed PCM device
   numbers for HDMI, and we avoid need to hardcode PCM
   device numbers in machine driver code.

2) Can we drop hdac_hdmi and its support from machine drivers, or
   do we need to make it optional and keep it around?

 - Current series does not add any Kconfig options, but
   simply switches SOF to use HDA codecs for all, including
   HDMI/DP. This means hdac_hdmi is never used with SOF
   and could be dropped (if SST is ok as well).
 - This may break some usage with SST (input is welcome!)
 - The change is visible to applications. The ALSA mixer
   interface is different (OTOH with the new driver, playback
   works out-of-the-box while with hdac_hdmi you needed to
   set the multiple controls first, to have any audio out).
 - Alternatively I could add a KConfig option and we could
   have a deprecation period for hdac_hdmi, allowing people
   to compile with the old driver during transition time.
   This will require #ifdef'ing in all the machine drivers.

.. once these are addressed, I can proceed to extend the patchset
with all affected machine drivers.

Feature and testing info:

 - Tested on multiple Intel platforms supported by SOF.
 - Tested with ALSA console tools as well as with Pulseaudio.
      - requires Pulseaudio 12.x or newer, see
        https://lists.freedesktop.org/archives/pulseaudio-discuss/2019-August/031358.html
 - HDMI, DP, DP-MST with multi-monitor use-scenarios work ok.
 - New feature for SOF: ELD /proc fs works just like in
   DSP-less mode.
 - New feature for SOF: jack detection works out-of-the-box
   with Pulseaudio (no need for card specific UCM for HDMI)
 - Pre-reviewed at:
   https://github.com/thesofproject/linux/pull/1155

Kai Vehmanen (7):
  ALSA: hda - add mst_no_extra_pcms flag to hda_codec
  ASoC: Intel: skl-hda-dsp-generic: use snd-hda-codec-hdmi
  ASoC: hdac_hda: add support for HDMI/DP as a HDA codec
  ALSA: hda/hdmi - allow control creation without a linked pcm
  ALSA: hda/hdmi - implement mst_no_extra_pcms flag
  ALSA: hda/hdmi - complete pcm_setup_pin without snd_pcm link
  ASoC: SOF: Intel: load hda codec module also for HDMI/DP

 include/sound/hda_codec.h                    |  1 +
 sound/pci/hda/patch_hdmi.c                   | 31 ++++---
 sound/soc/codecs/hdac_hda.c                  | 95 +++++++++++++++++---
 sound/soc/codecs/hdac_hda.h                  | 10 ++-
 sound/soc/intel/boards/skl_hda_dsp_common.c  | 27 ++----
 sound/soc/intel/boards/skl_hda_dsp_common.h  | 61 +++++++++++++
 sound/soc/intel/boards/skl_hda_dsp_generic.c |  7 --
 sound/soc/sof/intel/hda-codec.c              | 11 +--
 sound/soc/sof/intel/hda.h                    |  5 +-
 9 files changed, 189 insertions(+), 59 deletions(-)

-- 
2.17.1
