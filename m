From: jeeja.kp@intel.com
Subject: [PATCH 00/10] ASoC: Intel: Skylake: Driver updates
Date: Tue,  7 Mar 2017 23:43:56 +0530
Message-ID: <1488910446-26415-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E7C61266FA0
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 19:02:04 +0100 (CET)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This patch series provides updates and fixes on the following:
 Fix parameter overwrite for KPB DSP Module.
 To handle module download with size > dma buffer size.
 Fix to handle dsp pipes correctly.
 Disable notification after dsp boot.
 Remove get dsp_ops in cleanup routine.
 Disable interrupt when DSP is in D3.
 Update DSP core state in D0.
 Reload the firmware in case of D3 failure.

Dharageswari R (1):
  ASoC: Intel: Skylake: Fix parameter overwrite for KPB Module

G Kranthi (2):
  ASoC: Intel: Skylake: Disable notifications at boot after DSP FW init
  ASoC: Intel: Skylake: Remove get dsp_ops in cleanup routine

Guneshwor Singh (1):
  ASoC: Intel: Skylake: Fix not to stop src pipe in pre pmd event
    handler

Jeeja KP (6):
  ASoC: Intel: Skylake: Fix to delete DSP pipe after stopping pipe
  ASoC: Intel: bxtn: Disable interrupt when DSP is in D3
  ASoC: Intel: bxtn: Update DSP core state in D0
  ASoC: Intel: bxtn: Reload the firmware in case of D3 failure
  ASoC: Intel: Skylake: Remove BE prepare ops
  ASoC: Intel: Skylake: Fix module load when module size > DMA buffer
    size

 sound/soc/intel/skylake/bxt-sst.c       | 14 ++++++-
 sound/soc/intel/skylake/skl-messages.c  | 12 ++----
 sound/soc/intel/skylake/skl-pcm.c       | 19 +---------
 sound/soc/intel/skylake/skl-sst-cldma.c | 26 ++++++++-----
 sound/soc/intel/skylake/skl-sst-cldma.h |  2 +-
 sound/soc/intel/skylake/skl-sst-dsp.c   |  6 ++-
 sound/soc/intel/skylake/skl-sst-dsp.h   |  3 ++
 sound/soc/intel/skylake/skl-sst-ipc.c   | 67 ++++++++++++++++++++++-----------
 sound/soc/intel/skylake/skl-sst-ipc.h   |  7 ++++
 sound/soc/intel/skylake/skl-sst.c       | 49 ++++++++++++++++++------
 sound/soc/intel/skylake/skl-topology.c  | 56 ++++++++++++++-------------
 11 files changed, 162 insertions(+), 99 deletions(-)

-- 
2.5.0
