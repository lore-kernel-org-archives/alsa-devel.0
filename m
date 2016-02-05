From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/7] ASoC: Intel: Skylake: Topology sequence
	changes
Date: Fri,  5 Feb 2016 12:19:03 +0530
Message-ID: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 16FA12605C6
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 07:45:47 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

This series does some minor tweaks to the topology sequences and
supports a little more variety of topologies like a pipe that
does not have mixer at the end and is connected by a switch.

We add some helper functions and then support default params for
internal sinks and sources

Shutdown callback helps to get hardware to a cleaner state

MCLK configuration allows codec to configure and control the mclk
for these systems.

While at it, also fix the delay code to be simple if case

Dharageswari.R (3):
  ASoC: Intel: Skylake: Get node id using helper
  ASoC: Intel: Skylake: Add skl_tplg_be_get_cpr_module() helper
  ASoC: Intel: Skylake: Add MCLK configuration

Jeeja KP (3):
  ASoC: Intel: Skylake: Allow module parameter set after bind
  ASoC: Intel: Skylake: Add shutdown callback
  ASoC: Intel: Skylake: Fill BE blob with default params

Vinod Koul (1):
  ASoC: Intel: Skylake: Update the delay check

 sound/soc/intel/skylake/skl-messages.c       |  62 ++++++++-
 sound/soc/intel/skylake/skl-pcm.c            |  22 ++-
 sound/soc/intel/skylake/skl-topology.c       | 193 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h       |  27 ++++
 sound/soc/intel/skylake/skl-tplg-interface.h |   3 +-
 sound/soc/intel/skylake/skl.c                |  26 ++++
 6 files changed, 325 insertions(+), 8 deletions(-)

-- 
1.9.1
