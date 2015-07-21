From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/6] ASoC: Intel: Skylake: Add DSP management
	routines
Date: Tue, 21 Jul 2015 23:53:54 +0530
Message-ID: <1437503040-7392-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 76528265056
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 20:22:14 +0200 (CEST)
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

This series adds NHLT table support in the driver. This also adds support
for dsp init, modules configuration and messaging support

Hardik T Shah (1):
  ASoC: Intel: Skylake: Add helpers for SRC and converter modules

Jeeja KP (5):
  ASoC: Intel: Skylake: Add NHLT support to get BE config
  ASoC: Intel: Skylake: Add dsp and ipc init helpers
  ASoC: Intel: Skylake: Add functions for DSP module configuration
  ASoC: Intel: Skylake: Add DSP module init and binding routines
  ASoC: Intel: Skylake: Add pipe management helpers

 sound/soc/intel/skylake/Makefile             |   2 +-
 sound/soc/intel/skylake/skl-messages.c       | 828 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-nhlt.c           | 141 +++++
 sound/soc/intel/skylake/skl-nhlt.h           | 116 ++++
 sound/soc/intel/skylake/skl-topology.h       | 276 +++++++++
 sound/soc/intel/skylake/skl-tplg-interface.h |  88 +++
 sound/soc/intel/skylake/skl.h                |  13 +
 7 files changed, 1463 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/skylake/skl-messages.c
 create mode 100644 sound/soc/intel/skylake/skl-nhlt.c
 create mode 100644 sound/soc/intel/skylake/skl-nhlt.h
 create mode 100644 sound/soc/intel/skylake/skl-topology.h
 create mode 100644 sound/soc/intel/skylake/skl-tplg-interface.h

-- 
1.9.1
