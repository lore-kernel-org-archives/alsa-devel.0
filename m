From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] Make the audio component binding more
	generic
Date: Mon, 16 Jul 2018 15:48:12 +0200
Message-ID: <20180716134815.21365-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A0E92267727
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 15:48:19 +0200 (CEST)
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
Cc: Jim Qu <Jim.Qu@amd.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a preliminiary patch set to convert the existing i915 /
HD-audio component binding to be applicable to other drivers like
radeon / amdgpu.  This patchset itself doesn't change the
functionality but only renames and split to a new drm_audio_component
stuff from i915_audio_component.

The actual usage of the new API will follow once after this one gets
reviewed / accepted.  The whole patches (including this patchset) are
found in topic/hda-acomp branch of sound.git tree.

BTW, since the whole stuff is about the audio binding, I suppose these
will go through sound git tree.  Let me know if anyone has concerns.


Thanks!

Takashi

===

Takashi Iwai (3):
  drm/i915: Split audio component to a generic type
  ALSA: hda/i915: Associate audio component with devres
  ALSA: hda: Make audio component support more generic

 drivers/gpu/drm/i915/Kconfig       |   1 +
 drivers/gpu/drm/i915/intel_audio.c |  22 +-
 include/drm/drm_audio_component.h  | 138 ++++++++++++
 include/drm/i915_component.h       |  85 +-------
 include/sound/hda_component.h      |  61 ++++++
 include/sound/hda_i915.h           |  37 +---
 include/sound/hdaudio.h            |   6 +-
 sound/hda/Kconfig                  |   7 +-
 sound/hda/Makefile                 |   1 +
 sound/hda/hdac_component.c         | 332 ++++++++++++++++++++++++++++
 sound/hda/hdac_i915.c              | 335 ++---------------------------
 sound/pci/hda/patch_hdmi.c         |  57 +++--
 sound/soc/codecs/hdac_hdmi.c       |  10 +-
 13 files changed, 624 insertions(+), 468 deletions(-)
 create mode 100644 include/drm/drm_audio_component.h
 create mode 100644 include/sound/hda_component.h
 create mode 100644 sound/hda/hdac_component.c

-- 
2.18.0
