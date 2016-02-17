From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v7 0/9] ASoC: hdac_hdmi: Update to HDMI driver
Date: Wed, 17 Feb 2016 21:33:58 +0530
Message-ID: <1455725047-7303-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DADD260686
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 17:03:37 +0100 (CET)
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

This is remaining patches of v6 and appended platform changes for
enumerating HDMI codec

Jeeja KP (1):
  ASoC: hdac_hdmi: Add PM support

Ramesh Babu (1):
  ASoC: hdac_hdmi: Fix to keep codec power active during enumeration.

Subhransu S. Prusty (6):
  ASoC: hdac_hdmi: Fix possible memory leak in hw_params
  ASoC: hdac_hdmi: Don't fail in dai startup to make userland happy
  ASoC: hdac_hdmi: Fix to reconfigure registers in runtime resume
  ASoC: hdac_hdmi: Fix to wait for D3 before powering off codec
  ASoC: Intel: Skylake: Fix possible memory corruption in codec dai dma
    params
  ASoC: Intel: Skylake: Add HDMI FE and BE cpu dais

Vinod Koul (1):
  ASoC: Intel: Skylake: Add i915 enabling in skl probe

 sound/soc/codecs/hdac_hdmi.c      | 178 +++++++++++++++++++++++++++++++-------
 sound/soc/intel/Kconfig           |   1 +
 sound/soc/intel/skylake/skl-pcm.c |  84 ++++++++++++++++--
 sound/soc/intel/skylake/skl.c     |  51 +++++++++++
 4 files changed, 275 insertions(+), 39 deletions(-)

-- 
1.9.1
