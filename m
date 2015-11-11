From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/9] ASoC: Intel: Skylake: Stability fixes
Date: Thu, 12 Nov 2015 00:16:40 +0530
Message-ID: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 648902605C0
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 19:43:34 +0100 (CET)
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

Jeeja KP (8):
  ASoC: Intel: Skylake: remove BE startup dai ops
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
 sound/soc/intel/skylake/skl-pcm.c       | 22 ++++++++-------
 sound/soc/intel/skylake/skl-sst-cldma.c | 20 +++++++++++++
 sound/soc/intel/skylake/skl-sst.c       | 29 ++++++++++---------
 sound/soc/intel/skylake/skl-topology.c  |  6 ++--
 sound/soc/intel/skylake/skl.c           | 13 ---------
 6 files changed, 100 insertions(+), 40 deletions(-)

-- 
1.9.1
