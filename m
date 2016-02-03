From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 00/11] ASoC: Intel: Skylake: Driver fixes
Date: Wed,  3 Feb 2016 17:59:43 +0530
Message-ID: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E844F260515
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 13:26:26 +0100 (CET)
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

Now that 4.5-rc1 has audio functional with driver, time to fix some corner
cases in driver.

This series tries to fix:
o resource leakage on error cases while allocation and freeup
o wrap of delay reporting
o fix of various corner cases in topology and support of multiple
sinks/source ona pipe and without a mixer termination
o tlv buffer overwrite as suggested by Takashi
o removal of autosuspend delay
o 2 ch support on rt286 machine

Although patches are 11, the diffstat is only +59, -29

Dharageswari.R (1):
  ASoC: Intel: Skylake: Fix pipe memory allocation leak

Guneshwor Singh (2):
  ASoC: Intel: Skylake: Fix delay wrap condition
  ASoC: Intel: Skylake: Fix mcps freeup after module unbind failure

Jeeja KP (6):
  ASoC: Intel: Skylake: Fix return of skl_get_queue_index
  ASoC: Intel: Skylake: Fix the module state check condition
  ASoC: Intel: Skylake: Fix not to stop sink pipe in pga pmd event
  ASoC: Intel: Skylake: Fix bind of source with multiple sinks
  ASoC: Intel: Skylake: Add missing PRE/POST_PMU handlers for vmixer
  ASoC: Intel: Skylake: Fix stereo DMIC record

Vinod Koul (2):
  ASoC: Intel: Skylake: Fix the memory overwrite of tlv buffer
  ASoC: Intel: Skylake: Remove autosuspend delay

 sound/soc/intel/boards/skl_rt286.c     |  5 ++-
 sound/soc/intel/skylake/skl-messages.c |  6 +--
 sound/soc/intel/skylake/skl-pcm.c      |  1 +
 sound/soc/intel/skylake/skl-topology.c | 74 +++++++++++++++++++++++-----------
 sound/soc/intel/skylake/skl.c          |  2 -
 5 files changed, 59 insertions(+), 29 deletions(-)

-- 
1.9.1
