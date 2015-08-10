From: mengdong.lin@intel.com
Subject: [RFC PATCH 00/10] ASoC: support adding PCM dynamically
	from topology
Date: Mon, 10 Aug 2015 14:09:33 +0800
Message-ID: <1439186973-913-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A25A0265171
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 07:57:57 +0200 (CEST)
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
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch set allows the topology core to create PCM devices dynamically.
The user can define different DAIs in the topology files for different
versions of firmware, but share a generic platform and machine driver.

A dummy DAI and DAI link can be used to register the soc card and specify
the platform with topology. Then real DAIs are created in platform probing
phase by the topology core, and the machine driver will be notified to create
relavant DAI links.

We tested using topology to create FE DAI/DAI links on Broadwell.

Mengdong Lin (10):
  ASoC: change the PCM runtime array to a list
  ASoC: Define soc_init_dai_link() to wrap link intialization.
  ASoC: soc_bind_dai_link() change 2nd argument to DAI link pointer
  ASoC: implement DAI links in a list.
  ASoC: Add support for dummy DAI links and PCM runtimes
  ASoC: bind new DAI links after probing components.
  ASoC: support adding a DAI dynamically
  ASoC: topology: change pass number of DAI smaller than graph
  ASoC: Topology: change stream formats to bitwise flag
  ASOC: topology: Add PCM DAIs dynamically when loading them

 include/sound/soc-dai.h                      |   1 +
 include/sound/soc-topology.h                 |   1 -
 include/sound/soc.h                          |  28 +-
 include/uapi/sound/asoc.h                    |   2 +-
 sound/soc/fsl/fsl-asoc-card.c                |  10 +-
 sound/soc/fsl/imx-wm8962.c                   |  10 +-
 sound/soc/generic/simple-card.c              |  12 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  12 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c      |   7 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c      |   7 +-
 sound/soc/pxa/mioa701_wm9713.c               |   6 +-
 sound/soc/samsung/bells.c                    |  40 +-
 sound/soc/samsung/littlemill.c               |  32 +-
 sound/soc/samsung/odroidx2_max98090.c        |   9 +-
 sound/soc/samsung/snow.c                     |   9 +-
 sound/soc/samsung/speyside.c                 |  12 +-
 sound/soc/samsung/tobermory.c                |  21 +-
 sound/soc/soc-core.c                         | 642 +++++++++++++++++++--------
 sound/soc/soc-dapm.c                         |   7 +-
 sound/soc/soc-pcm.c                          |  22 +-
 sound/soc/soc-topology.c                     |  99 ++++-
 sound/soc/tegra/tegra_wm8903.c               |   3 +-
 22 files changed, 701 insertions(+), 291 deletions(-)

-- 
1.9.1
