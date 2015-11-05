From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 0/2] ASoC: Change the PCM runtime array to a
	list
Date: Thu,  5 Nov 2015 11:30:34 +0800
Message-ID: <cover.1446692512.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E4E5026048C
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 04:15:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

The 2 patches are a preparation to allow the topology core to create
PCM devices dynamically. Probing a component may load its topology and
come up with new DAI links and thus new runtimes. So implementing the
PCM runtimes in a list makes it easier to add new runtimes.

History:
  v2: Rebase the patches to ASoC for-next v4.3 kernel.

Mengdong Lin (2):
  ASoC: Vendor drivers get a link's runtime by snd_soc_get_pcm_runtime()
  ASoC: Change the PCM runtime array to a list

 include/sound/soc.h                          |   5 +-
 sound/soc/fsl/fsl-asoc-card.c                |   5 +-
 sound/soc/fsl/imx-wm8962.c                   |  10 +-
 sound/soc/generic/simple-card.c              |  12 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  12 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |   7 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c      |   7 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c      |   7 +-
 sound/soc/pxa/mioa701_wm9713.c               |   6 +-
 sound/soc/samsung/bells.c                    |  40 +++-
 sound/soc/samsung/littlemill.c               |  32 +++-
 sound/soc/samsung/odroidx2_max98090.c        |   9 +-
 sound/soc/samsung/snow.c                     |   9 +-
 sound/soc/samsung/speyside.c                 |  12 +-
 sound/soc/samsung/tobermory.c                |  21 ++-
 sound/soc/sh/rcar/core.c                     |   2 +-
 sound/soc/sh/rcar/rsrc-card.c                |   6 +-
 sound/soc/soc-core.c                         | 263 ++++++++++++++++-----------
 sound/soc/soc-dapm.c                         |   7 +-
 sound/soc/soc-pcm.c                          |  22 +--
 sound/soc/tegra/tegra_wm8903.c               |   3 +-
 21 files changed, 307 insertions(+), 190 deletions(-)

-- 
1.9.1
