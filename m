From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 00/12] ASoC: Intel: Skylake: Add support for
	loadable modules
Date: Thu,  3 Dec 2015 23:29:49 +0530
Message-ID: <1449165601-11226-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 296A7260525
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 18:57:04 +0100 (CET)
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


This series adds first the infrastructure for loadable modules in SKL aDSP.
The loadable modules are loaded using load/unload IPC to aDSP thru code load
DMA and can be configured by user thru TLV byte kcontrols for these modules.

This also adds the implementation of new DAPM sinks for phrase detection
modules, and adds support for keeping controller active while is suspend to
support ignore_suspend DAIs


Changes on v2:
- squash two load module IPCs and load modules usgae patches
- add comments for module loading
- add active suspend two patches

Dharageswari R (2):
  ASoC: Intel: Skylake: Add support for Loadable modules
  ASoC: Intel: Skylake: Add support for Mic Select module

Jeeja KP (4):
  ASoC: Intel: Skylake: Add memory pages to widget data.
  ASoC: Intel: Skylake: Fix module init data correctly
  ASoC: Intel: Skylake: Add dai link for DMIC capture
  ASoC: Intel: Skylake: Add support for active suspend

Mousami Jana (1):
  ASoC: Intel: Skylake: add LARGE_CONFIG_GET IPC support

Omair M Abdullah (2):
  ASoC: Intel: Skylake: update mailbox uplink window offset and size
  ASoC: Intel: Skylake: read params from DSP if module is on

Praveen Diwakar (1):
  ASoC: Intel: Skylake: Update ignore suspend for rt286 machine

Vinod Koul (2):
  ASoC: Intel: Skylake: add wov as int sink
  ASoc: Intel: Skylake: Fix the dapm machine map

 sound/soc/intel/boards/skl_rt286.c           |  73 ++++++++++-
 sound/soc/intel/skylake/skl-messages.c       |  40 ++++++
 sound/soc/intel/skylake/skl-pcm.c            |  27 +++++
 sound/soc/intel/skylake/skl-sst-dsp.h        |  18 ++-
 sound/soc/intel/skylake/skl-sst-ipc.c        | 106 ++++++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h        |   9 ++
 sound/soc/intel/skylake/skl-sst.c            | 175 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.c       |  43 ++++++-
 sound/soc/intel/skylake/skl-topology.h       |  12 +-
 sound/soc/intel/skylake/skl-tplg-interface.h |  19 ++-
 sound/soc/intel/skylake/skl.c                |  28 ++++-
 sound/soc/intel/skylake/skl.h                |   2 +
 12 files changed, 533 insertions(+), 19 deletions(-)

-- 
1.9.1
