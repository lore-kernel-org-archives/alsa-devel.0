From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/2] ASoC: Change the PCM runtime array to a
	list
Date: Tue,  3 Nov 2015 13:03:03 +0800
Message-ID: <cover.1446521493.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id F2768264F3F
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 05:47:40 +0100 (CET)
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
Cc: Lin Mengdong <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Lin Mengdong <mengdong.lin@linux.intel.com>

The 2 patches are a preparation to allow the topology core to create
PCM devices dyanmically. Probing a compoent may load its topology and
come up with new DAI links and thus new runtimes. So impmenting the 
PCM runtimes in a list make it easier to add new runtimes.

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
