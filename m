From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 00/12] ASoC: Intel: Skylake: Add support for
	library load
Date: Tue, 26 Jul 2016 18:06:38 +0530
Message-ID: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CC6BC266990
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 14:29:43 +0200 (CEST)
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

This patch series adds support for library loading. A module maybe part
of base firmware or in a different library. A library may have one or
more modules. The names of library to be loaded are passed as topology
manifest data. The library list is loaded after base FW during dsp init.
So we add support library load IPC and the usage in broxton ops for
loading libs.

To load a list of lib(s) coming from topology, we need to split DSP
init, into object creation and fw_init. The fw_init is invoked from
soc-probe after topology is initialized. Now fw is initialized later,
so module UUID query was move to runtime as the firmware is not available
at topology initialization.

While at it, also fix the parsing UUIDs only once for SKL and BXT ops
and one comment code style.

Lastly this series adds support for specifying processing domain for
modules.

Kranthi G (1):
  ASoC: Intel: Skylake: add support for tplg manifest load

Ramesh Babu (2):
  ASoC: Intel: Skylake: Add library loading IPCs
  ASoC: Intel: Skylake: Add library loading support

Senthilnathan Veppur (2):
  ASoC: Intel: Skylake: add additional args to module parsing
  ASoC: Intel: Skylake: Add module processing domain support

Vinod Koul (7):
  ASoC: Intel: Skylake: Check list empty while getting module info
  ASoC: Intel: Skylake: Move modules query to runtime
  ASoC: Intel: Skylake: modify skl_get_dsp_ops()
  ASoC: Intel: Skylake: split fw and dsp initialization
  ASoC: Intel: Skylake: Parse UUIDs once
  ASoC: Intel: Bxt: Parse UUIDs once
  ASoC: Intel: Skylake: Fix a comment style

 sound/soc/intel/skylake/bxt-sst.c            | 114 ++++++++++++++++++++++++---
 sound/soc/intel/skylake/skl-messages.c       |  39 +++++----
 sound/soc/intel/skylake/skl-pcm.c            |  20 +++++
 sound/soc/intel/skylake/skl-sst-dsp.h        |   7 +-
 sound/soc/intel/skylake/skl-sst-ipc.c        |  29 +++++++
 sound/soc/intel/skylake/skl-sst-ipc.h        |  12 ++-
 sound/soc/intel/skylake/skl-sst-utils.c      |  14 +++-
 sound/soc/intel/skylake/skl-sst.c            |  43 ++++++----
 sound/soc/intel/skylake/skl-topology.c       |  55 +++++++++++--
 sound/soc/intel/skylake/skl-topology.h       |   2 +-
 sound/soc/intel/skylake/skl-tplg-interface.h |  15 +++-
 sound/soc/intel/skylake/skl.h                |   2 +
 12 files changed, 297 insertions(+), 55 deletions(-)

-- 
1.9.1
