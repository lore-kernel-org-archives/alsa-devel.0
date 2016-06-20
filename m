From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ASoC: Intel: Skylake: Add DSP muti-core
	support
Date: Mon, 20 Jun 2016 19:40:09 +0530
Message-ID: <1466431812-9046-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id C73FC26546B
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 16:04:21 +0200 (CEST)
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

This series adds support for managing multiple DSP cores. SW is
responsible for powering up/down cores in DSP and we do that using
refcount.  1st patch introduces core infrastructure change in driver and
then adds support in SKL and BXT

Jayachandran B (3):
  ASoC: Intel: Skylake: Add DSP muti-core infrastructure
  ASoC: Intel: Skylake: Support multi-core in Skylake
  ASoC: Intel: Skylake: Support multi-core in Broxton

 sound/soc/intel/skylake/bxt-sst.c     | 160 ++++++++++++++-------
 sound/soc/intel/skylake/skl-sst-dsp.c | 252 ++++++++++++++++++++++++----------
 sound/soc/intel/skylake/skl-sst-dsp.h |  96 ++++++++-----
 sound/soc/intel/skylake/skl-sst-ipc.h |  11 ++
 sound/soc/intel/skylake/skl-sst.c     |  91 +++++++-----
 5 files changed, 424 insertions(+), 186 deletions(-)

-- 
1.9.1
