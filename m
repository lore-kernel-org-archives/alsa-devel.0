From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/4] ASoC: topology: configure more on DAI &
	DAI links
Date: Tue, 19 Apr 2016 13:12:03 +0800
Message-ID: <cover.1461042239.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 61B582651DB
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 07:09:24 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

There is no ABI change in this series.

Two patches are small changes in ASoC core, to allow topology to further
configure DAI and DAI links.

In the other two patches, topology will configure more on FE DAI links.

Guneshwor Singh (1):
  ASoC: topology: Set CPU DAI name and enable DPCM by default for FE
    link

Mengdong Lin (3):
  ASoC: Export snd_soc_find_dai()
  ASoC: Change DAI link's be_id to a generic id
  ASoC: topology: Set the link ID when creating a FE DAI link

 include/sound/soc.h                             |  5 ++++-
 include/uapi/sound/asoc.h                       |  2 +-
 sound/soc/intel/boards/broadwell.c              |  2 +-
 sound/soc/intel/boards/bytcr_rt5640.c           |  2 +-
 sound/soc/intel/boards/bytcr_rt5651.c           |  2 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c    |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c         |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c         |  2 +-
 sound/soc/intel/boards/haswell.c                |  2 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 12 ++++++------
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 12 ++++++------
 sound/soc/intel/boards/skl_rt286.c              | 10 +++++-----
 sound/soc/soc-core.c                            |  3 ++-
 sound/soc/soc-topology.c                        | 11 +++++++++++
 14 files changed, 42 insertions(+), 27 deletions(-)

-- 
2.5.0
