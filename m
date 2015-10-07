From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 0/8] Add DSP topology management for SKL
Date: Wed,  7 Oct 2015 11:31:51 +0100
Message-ID: <1444213919-32369-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E6AA2265AFC
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 12:32:12 +0200 (CEST)
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

The SKL driver does not code DSP topology in driver. With this series
the ASoC topology framework is used to parse the topology information
to create widgets, controls and route map for the FW topology.

It adds routines for SKL DSP module configuration, compute resources
for modules, initialize and bind the pipe modules. It uses the SKL IPC
library added earlier to send IPC for initialize the module, bind/unbind
modules.
Last patch in this series removes the unused dais.

changes in v4:
- rename resource allocators and add resource deallocator
- remove bind_unbind and add in callng fn
- fix some 80char warns
- some minor cleanup at odd places

changes in v3:
- removeno/less logic wrappers
- remove most of debug prints, few kept
- use asoc widget list macros instead of using list_for_xxx
- fix one instance of no empty line between two functions
- fix tplg event ID > 255
- add more comments for locking, usage of widget list and few other places,
  fixed few error prints, add file name etc

changes in v2:
- add more explanation in changelog and code
- add explanation of MCPS
- fix whitespace issues
- remove skl widget check on event handler as it is redundant
- add switch for depth
- add else for direction based code
- remove cast for NHLT blob query
- make debug prints to error
- remove dump info
- clean some debug prints

Jeeja KP (5):
  ASoC: Intel: Skylake: Add pipe and modules handlers
  ASoC: Intel: Skylake: Add module configuration helpers
  ASoC: Intel: Skylake: Initialize and load DSP controls
  ASoC: Intel: Skylake: Add DSP support and enable it
  ASoC: Intel: Skylake: Initialize NHLT table

Vinod Koul (3):
  ASoC: Intel: Skylake: add DSP platform widget event handlers
  ASoC: Intel: Skylake: Add FE and BE hw_params handling
  ASoC: Intel: Skylake: Add topology core init and handlers

 sound/soc/intel/Kconfig                      |    1 +
 sound/soc/intel/skylake/Makefile             |    3 +-
 sound/soc/intel/skylake/skl-pcm.c            |  141 ++-
 sound/soc/intel/skylake/skl-topology.c       | 1238 ++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h       |   28 +
 sound/soc/intel/skylake/skl-tplg-interface.h |   80 ++
 sound/soc/intel/skylake/skl.c                |   29 +-
 sound/soc/intel/skylake/skl.h                |   11 +
 8 files changed, 1495 insertions(+), 36 deletions(-)
 create mode 100644 sound/soc/intel/skylake/skl-topology.c

-- 
2.4.3
