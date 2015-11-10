From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 0/6] ASoC: Add HDA HDMI codec driver
Date: Tue, 10 Nov 2015 18:42:04 +0530
Message-ID: <1447161130-24889-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0011E265083
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 14:08:49 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

This is 4th series of the HDA HDMI patches. This attempts to add HDA
based HDMI driver and uses i915 component framework to interact with
display for power up/down. The communication to codec is over HDA link

If at all we need a change in interface, we can i915 interface which can be
made transparent to users

Due to dependency on already merged patches in ALSA tree, it would be best
if this get merged thru ALSA tree

Changes in v4:
- fix the err log and remove some debug prints
- add more comments
- add Takash's ACK on 1st patch

Changes in v3:
- add comment in hdmi driver and changlog on basic support and eventual
  addition of features

Changes in v2:
- remove infoframe open code and use video one
- add pm on/off i915 triggers
- add ext_dma_params struct


Subhransu S. Prusty (6):
  ALSA: hdac: structure definition for ext_dma_params
  ASoC: hdac-hdmi: Add hdmi driver
  ASoC: hdac_hdmi: Add PM support for HDMI
  ASoC: hdac_hdmi: Add hdac hdmi dai ops
  ASoC: hdac_hdmi: Setup and start infoframe
  ASoC: hdac_hdmi: Use i915 component framework for PM

 include/sound/hdaudio_ext.h  |   6 +
 sound/soc/codecs/Kconfig     |   5 +
 sound/soc/codecs/Makefile    |   2 +
 sound/soc/codecs/hdac_hdmi.c | 656 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 669 insertions(+)
 create mode 100644 sound/soc/codecs/hdac_hdmi.c

-- 
1.9.1
