From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/4] ASoC: core: Update for DSP systems
Date: Mon,  9 Nov 2015 23:19:57 +0530
Message-ID: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id F244D26060E
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 18:46:37 +0100 (CET)
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

This patch series tried to do two things

1. Add support to have cpu based loopback dai_links supported, so the CPU
based DSPs can have non hostless streams

2. Add kcontrol to bytes tlv callbacks and fix the topology core info
callback for TLV byte controls

Comments welcome...

Jeeja KP (1):
  ASoC: core: Adds support for cpu loopback dai_link

Mythri P K (1):
  ASoC: core: Pass kcontrol to bytes tlv callbacks

Omair M Abdullah (1):
  ASoC: topology: fix info callback for TLV byte control

Vinod Koul (1):
  ASoC: core: refactor soc_link_dai_widgets()

 include/sound/soc-topology.h |  6 ++++--
 include/sound/soc.h          |  9 +++++++--
 sound/soc/soc-core.c         | 38 +++++++++++++++++++++++++-------------
 sound/soc/soc-ops.c          |  4 ++--
 sound/soc/soc-topology.c     |  2 +-
 5 files changed, 39 insertions(+), 20 deletions(-)

-- 
1.9.1
