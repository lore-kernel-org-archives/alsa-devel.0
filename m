From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/9] ASoC: Intel: Skylake: Stability fixes
Date: Fri, 13 Nov 2015 19:22:04 +0530
Message-ID: <1447422733-2484-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 56C922612DF
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2015 14:48:45 +0100 (CET)
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

The QA reported few issues while doing extensive on driver and esp in area of
suspend and doing suspend while audio is active.
This path series fixes those issues

Changes in v2:
- update 1st patch and remove driver pm calls as core takes care of it
- fix minor code style nit in cldma patch(5)

Jeeja KP (8):
  ASoC: Intel: Skylake: remove pm_runtime_get/put calls
  ASoC: Intel: Skylake: Don't enable WAKEENABLE on suspend
  ASoC: Intel: Skylake: Remove redundant init in resume
  ASoC: Intel: Skylake: Fix cleanup of dma buffer
  ASoC: Intel: Skylake: Reset the DSP when set D3 fails
  ASoC: Intel: Skylake: Fix CLDMA buffer wrap case
  ASoC: Intel: Skylake: Fix null ptr dereferenced in skl_tplg_bind_sinks
  ASoC: Intel: Skylake: Add pm ops for skl_rt286 machine

Vinod Koul (1):
  ASoC: Intel: Skylake: Constrain the audio devices

 sound/soc/intel/boards/skl_rt286.c      | 50 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-pcm.c       | 25 -----------------
 sound/soc/intel/skylake/skl-sst-cldma.c | 20 +++++++++++++
 sound/soc/intel/skylake/skl-sst.c       | 30 ++++++++++----------
 sound/soc/intel/skylake/skl-topology.c  |  6 ++--
 sound/soc/intel/skylake/skl.c           | 13 ---------
 6 files changed, 88 insertions(+), 56 deletions(-)

-- 
1.9.1
