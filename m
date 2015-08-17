From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/9] Add DSP topology management for SKL
Date: Mon, 17 Aug 2015 22:56:35 +0530
Message-ID: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AC5F426007E
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 19:24:45 +0200 (CEST)
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

Jeeja KP (9):
  ASoC: Intel: Skylake: Add pipe and modules handlers
  ASoC: Intel: Skylake: Add module configuration helpers
  ASoC: Intel: Skylake: add DSP platform widget event handlers
  ASoC: Intel: Skylake: Add FE and BE hw_params handling
  ASoC: Intel: Skylake: Add topology core init and handlers
  ASoC: Intel: Skylake: Initialize and load DSP controls
  ASoC: Intel: Skylake: Add DSP support and enable it
  ASoC: Intel: Skylake: Initialize NHLT table
  ASoC: Intel: Skylake: Remove unused CPU dai's

 sound/soc/intel/skylake/Makefile             |    3 +-
 sound/soc/intel/skylake/skl-pcm.c            |  171 ++--
 sound/soc/intel/skylake/skl-topology.c       | 1262 ++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h       |   21 +
 sound/soc/intel/skylake/skl-tplg-interface.h |   78 ++
 sound/soc/intel/skylake/skl.c                |   29 +-
 sound/soc/intel/skylake/skl.h                |   11 +
 7 files changed, 1507 insertions(+), 68 deletions(-)
 create mode 100644 sound/soc/intel/skylake/skl-topology.c

-- 
1.9.1
