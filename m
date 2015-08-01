From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/6] ASoC: Intel: Skylake: Add DSP
	management routines
Date: Sat,  1 Aug 2015 19:40:38 +0530
Message-ID: <1438438244-17974-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B8F7261569
 for <alsa-devel@alsa-project.org>; Sat,  1 Aug 2015 16:08:58 +0200 (CEST)
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

This is second rev of series to add DSP management routines for SKL driver

The first two patches are fixes to use ACPI header and size fix on NHLT
query

Then we add DSP module configuration calculation helpers followed by SRC and
updown calculation. These are used by next patch which adds module creation,
and binding routines. Lastly modules are used by pipes so we add pipelines
creation, destroy and scheduling helpers

Hardik T Shah (1):
  ASoC: Intel: Skylake: Add helpers for SRC and converter modules

Jeeja KP (5):
  ASoC: Intel: Skylake: Fix the NHLT rate size
  ASoC: Intel: Skylake: Use acpi header for NHLT header
  ASoC: Intel: Skylake: Add helpers for DSP module configuration
  ASoC: Intel: Skylake: Add DSP module init and binding routines
  ASoC: Intel: Skylake: Add pipe management helpers

 sound/soc/intel/skylake/skl-messages.c       | 751 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-nhlt.c           |   3 +-
 sound/soc/intel/skylake/skl-nhlt.h           |  14 +-
 sound/soc/intel/skylake/skl-topology.h       | 286 ++++++++++
 sound/soc/intel/skylake/skl-tplg-interface.h |  88 ++++
 5 files changed, 1128 insertions(+), 14 deletions(-)
 create mode 100644 sound/soc/intel/skylake/skl-topology.h
 create mode 100644 sound/soc/intel/skylake/skl-tplg-interface.h

-- 
1.9.1
