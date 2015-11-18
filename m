From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ASoC: remove SND_SOC_BYTES_EXT
Date: Wed, 18 Nov 2015 19:09:09 +0530
Message-ID: <1447853952-6414-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6747E260A5D
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 14:35:59 +0100 (CET)
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

The SND_SOC_BYTES_TLV and SND_SOC_BYTES_EXT provide similar functionality,
with only difference that SND_SOC_BYTES_EXT have limitations of 512 bytes
as parameters whereas no such restrictions on SND_SOC_BYTES_TLV

So remove SND_SOC_BYTES_EXT and update users to use SND_SOC_BYTES_TLV

Vinod Koul (3):
  ASoC: Intel: Hsw: Move driver to use SND_SOC_BYTES_TLV
  ASoC: wm5102: Move driver to use SND_SOC_BYTES_TLV
  ASoC: core: remove SND_SOC_BYTES_EXT

 include/sound/soc.h                       |  6 ----
 sound/soc/codecs/wm5102.c                 | 35 ++++++++++++++++------
 sound/soc/intel/haswell/sst-haswell-pcm.c | 50 ++++++++++++++++++++++++-------
 3 files changed, 66 insertions(+), 25 deletions(-)

-- 
1.9.1
