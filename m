From: jeeja.kp@intel.com
Subject: [PATCH 00/10] ASoC: Intel: Skylake: Improvements in
	Skylake driver
Date: Fri,  3 Jun 2016 18:29:33 +0530
Message-ID: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E4D822606F8
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 14:53:23 +0200 (CEST)
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
Cc: patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This series has the below changes:
o Modify the sequence when deleting the pipeline
o Disable SRAM retention feature
o Cleanup of driver resource in suspend
o Reset the pipe in case of XRUN
o Enable simultaneous HDMI and DP playback
o Instead of modifying the runtime->delay in pointer query,
  just report position in pointer query

Dharageswari R (4):
  ASoC: Intel: Skylake: Don't pause stopped pipeline while deleting
  ASoC: Intel: Skylake: Disable SRAM Retention before D3
  ASoC: Intel: Skylake: Avoid freeing up of unallocated memory/mcps
  ASoC: Intel: Skylake: Clean up of driver resources in suspend

Jeeja KP (6):
  ASoC: Intel: Skylake: Reset DSP pipe when host/link DMA is reset
  ASoC: Intel: Skylake: Set the pipe state to paused when paused
  ASoC: Intel: Skylake: Create Pipe to widget list in soc probe
  ASoC: Intel: Skylake: Set the DSP pipe type
  ASoC: Intel: Skylake: Copy the pipe parameter by pipe type
  ASoC: Intel: Skylake: Report position in pointer query

 sound/soc/intel/skylake/skl-messages.c |  45 +++++--
 sound/soc/intel/skylake/skl-pcm.c      |  93 +++++---------
 sound/soc/intel/skylake/skl-sst-ipc.h  |   1 +
 sound/soc/intel/skylake/skl-sst.c      |  10 ++
 sound/soc/intel/skylake/skl-topology.c | 213 +++++++++++++++++++++++----------
 sound/soc/intel/skylake/skl-topology.h |   6 +-
 sound/soc/intel/skylake/skl.c          |   4 +
 sound/soc/intel/skylake/skl.h          |   4 +
 8 files changed, 243 insertions(+), 133 deletions(-)

-- 
2.5.0
