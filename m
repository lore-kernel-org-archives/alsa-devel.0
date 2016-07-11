From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/4]  ASoC: Intel: Add support for KBL
Date: Mon, 11 Jul 2016 22:02:07 +0530
Message-ID: <1468254731-15394-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CB7B26573C
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 18:25:09 +0200 (CEST)
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

Kabylake is next generation Intel SoC which also sports a DSP. This
controller is quite similar to Skylake.

This patch series add KBL IDs to SKL driver, hdmi driver, sets combo jack
for rt286 codec and finally adds entry to skl machine driver

Shreyas NC (1):
  ASoC: hdac_hdmi: Add device id for Kabylake

Vinod Koul (3):
  ASoC: Intel: add kablake device IDs
  ASoC: rt286: set combo jack for Kabylake
  ASoC: Intel: board: add kabylake machine id

 sound/soc/codecs/hdac_hdmi.c           | 1 +
 sound/soc/codecs/rt286.c               | 7 +++++++
 sound/soc/intel/boards/skl_rt286.c     | 9 +++++++++
 sound/soc/intel/skylake/skl-messages.c | 6 ++++++
 sound/soc/intel/skylake/skl.c          | 8 ++++++++
 5 files changed, 31 insertions(+)

-- 
1.9.1
