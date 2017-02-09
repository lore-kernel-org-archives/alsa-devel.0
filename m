From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 0/4] ASoC: Intel: Skylake: Enable Geminilake
	support
Date: Thu,  9 Feb 2017 16:44:00 +0530
Message-ID: <1486638844-17975-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E64426684C
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 12:24:48 +0100 (CET)
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


Geminilake is next gen SoC, enable audio for Geminilake.

Geminilake has two different devices connected to the same SSP, so use
device_type check to get correct device configuration.

Senthilnathan Veppur (1):
  ASoC: Intel: Skylake: Check device type to get endpoint configuration

Vinod Koul (3):
  ASoC: rt298: Add DMI match for Geminilake reference platform
  ASoC: Intel: Skylake: Add Geminlake IDs
  ASoC: hdac_hdmi: Add device id for Geminilake

 sound/soc/codecs/hdac_hdmi.c           |  1 +
 sound/soc/codecs/rt298.c               |  7 +++++++
 sound/soc/intel/skylake/skl-messages.c |  7 +++++++
 sound/soc/intel/skylake/skl-nhlt.c     | 16 ++++++++++------
 sound/soc/intel/skylake/skl-topology.c | 32 ++++++++++++++++++++++++++++++--
 sound/soc/intel/skylake/skl.c          |  7 +++++++
 sound/soc/intel/skylake/skl.h          |  3 ++-
 7 files changed, 64 insertions(+), 9 deletions(-)

-- 
1.9.1
