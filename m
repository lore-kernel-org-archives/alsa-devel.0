From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/6] ASoC: Add HDA HDMI codec driver
Date: Mon, 26 Oct 2015 10:07:47 +0900
Message-ID: <1445821673-4947-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id F00E0260453
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 02:08:27 +0100 (CET)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Jyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Yakir Yang <ykk@rock-chips.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


Hi all,

This is second series of the HDA HDMI patches. This attempts to add HDA
based HDMI driver and uses i915 component framework to interact with
display for power up/down. The communication to codec is over HDA link

If at all we need a change in interface, we can i915 interface which can be
made transparent to users

Due to dependency on already merged patches in ALSA tree, it would be best
if this get merged thru ALSA tree

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
 sound/soc/codecs/hdac_hdmi.c | 659 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 672 insertions(+)
 create mode 100644 sound/soc/codecs/hdac_hdmi.c

-- 
2.4.3
