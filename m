From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 0/9] Add DSP topology management for SKL
Date: Sat,  8 Aug 2015 01:06:15 +0530
Message-ID: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 38E2C2610A6
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 21:36:59 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

[RESEND of the series after removing the extra patches]

The SKL driver does not code DSP topology in driver. With this series
the soc topology framework is used to parse the topology information
to create widgets, controls and route map for the FW topology.

It adds routines for SKL DSP module configuration, compute resources
for modules, initialize and bind the pipe modules. It uses the SKL IPC
library added earlier to send IPC for initialize the module, bind/unbind
modules.

Last patch in this series removes the unused dais.

Jeeja KP (9):
  ASoC: Intel: Skylake: Add pipe and modules handlers
  ASoC: Intel: Skylake: Add module configuration helpers
  ASoC: Intel: Skylake: add DSP platform widget event handlers
  ASoC: Intel: Skylake: Add FE and BE hw_params handling
  ASoC: Intel: Skylake: Add topology core init and handlers
  ASoC: Intel: Skylake: Initialize and load DSP controls
  ASoC: Intel: Skylake: Add DSP support and enable it
  ASoC: Intel: Skylake: Initialize NHLT table
  ASoC: Intel: Skylake: Remove CPU dai that is not used

 sound/soc/intel/skylake/Makefile             |    3 +-
 sound/soc/intel/skylake/skl-pcm.c            |  173 ++--
 sound/soc/intel/skylake/skl-topology.c       | 1264 ++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h       |   21 +
 sound/soc/intel/skylake/skl-tplg-interface.h |   78 ++
 sound/soc/intel/skylake/skl.c                |   29 +-
 sound/soc/intel/skylake/skl.h                |   11 +
 7 files changed, 1511 insertions(+), 68 deletions(-)
 create mode 100644 sound/soc/intel/skylake/skl-topology.c

-- 
2.4.3
