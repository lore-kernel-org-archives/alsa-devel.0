From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 0/5] rt5651: Enable jack detection
Date: Fri, 20 Oct 2017 12:18:54 +0100
Message-ID: <20171020111859.2448-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, albertchen@realtek.com, edgar_shen@realtek.com
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

Patchset to support jack detection for the rt5651 codec on the JD* pins
and enable it on the KIANO cherry-trail laptop.

Changelog:
v2:
 - Added quirks for the KIANO laptop
 - Extended support to JD1_2 and JD2 pins
 - Reworked quirk logic in the codec driver
 - Codec driver can now differentiate between headphone and headset
   (thank you Bard Liao)

Carlo Caione (5):
  ASoC: rt5651: Enable jack detection on JD* pins
  ASoC: intel: byt: Add headset jack
  ASoC: intel: byt: Enable IN2 map quirk for a KIANO laptop
  ASoC: rt5651: Rework quirk logic
  ASoC: rt5651: Enable JD1_1 quirk for KIANO laptopt

 include/sound/rt5651.h                |   8 ++
 sound/soc/codecs/rt5651.c             | 215 +++++++++++++++++++++++++++++++++-
 sound/soc/codecs/rt5651.h             |   4 +
 sound/soc/intel/boards/bytcr_rt5651.c |  31 +++++
 4 files changed, 252 insertions(+), 6 deletions(-)

-- 
2.14.2
