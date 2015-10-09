From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/4] ASoC: Intel: Skylake: Enable runtime pm
Date: Fri,  9 Oct 2015 09:01:47 +0100
Message-ID: <1444377711-9720-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A3D412617C6
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 10:02:05 +0200 (CEST)
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

Although driver already has runtime pm handlers, some of things
were missing to have it properly functional, so add the fixes and
correct handling

Jeeja KP (4):
  ASoC: Intel: Skylake: Check CPA bit in DSP core power down
  ASoC: Intel: Skylake: Verify the status bit before handling interrupt
  ASoC: Intel: Skylake: Correct the runtime handler behaviour
  ASoC: Intel: Skylake: power down all link in suspend

 sound/soc/intel/common/sst-dsp-priv.h |  1 +
 sound/soc/intel/skylake/skl-sst-dsp.c |  7 ++++-
 sound/soc/intel/skylake/skl-sst-ipc.c | 12 ++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h |  1 +
 sound/soc/intel/skylake/skl-sst.c     | 56 +++++++++++++++++++----------------
 sound/soc/intel/skylake/skl.c         |  3 ++
 6 files changed, 53 insertions(+), 27 deletions(-)

-- 
2.4.3
