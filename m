From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 0/4] ASoC: Add HDA HDMI codec driver
Date: Fri,  9 Oct 2015 13:28:45 +0100
Message-ID: <1444393729-19745-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E8DD926514B
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 14:34:01 +0200 (CEST)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Yakir Yang <ykk@rock-chips.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Yes, this patch series attempts to add yet another HDMI driver to
ASoC. This codec appears as HDA codec over HDA link. Although
the codec reside in display we have a HDA link from audio block
to this codec. The communication to codec is over HDA link

Thanks to i915 component infrastructure, we do not need to worry
about keeping the codec on, this is done by i915 for us.

Based on discussion with Mark here at ELCE and other attempts by
various folks on HDMI, I wanted to show on list the stuff we have
done and discuss and try to see how we converge various attempts

The driver here only supports stereo and doesn't do multichannel
just yet, will add later once we converge here. The support for
using i915 component notification by David will be added later
on.

Question/Comments welcome...

Subhransu S. Prusty (4):
  ASoC: hdac-hdmi: Add hdmi driver
  ASoC: hdac_hdmi: Add PM support for HDMI
  ASoC: hdac_hdmi: Add hdac hdmi dai ops
  ASoC: hdac_hdmi: Setup and start infoframe

 sound/soc/codecs/Kconfig     |   4 +
 sound/soc/codecs/Makefile    |   2 +
 sound/soc/codecs/hdac_hdmi.c | 694 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 700 insertions(+)
 create mode 100644 sound/soc/codecs/hdac_hdmi.c

-- 
2.4.3
