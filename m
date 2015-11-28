From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 00/16] ASoC: Intel: Skylake: Add support for
	loadable modules
Date: Sat, 28 Nov 2015 15:01:45 +0530
Message-ID: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DF56D2651E6
 for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2015 10:32:11 +0100 (CET)
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
modules.


Dharageswari R (2):
  ASoC: Intel: Skylake: Add support for Load/Unload IPCs
  ASoC: Intel: Skylake: Add support for Loadable modules

Dharageswari.R (1):
  ASoC: Intel: Skylake: Add support for Mic Select module

Jeeja KP (8):
  ASoC: Intel: Skylake: Update DMIC DAIs and capabilities
  ASoC: Intel: Skylake: Add helper routines to handle module params
  ASoC: Intel: Skylake: Add helper routine to handle Algo parameter
  ASoC: Intel: Skylake: Add support to configure module params
  ASoC: Intel: Skylake: Add tlv byte kcontrols
  ASoC: Intel: Skylake: Add memory pages to widget data.
  ASoC: Intel: Skylake: Fix module init data correctly
  ASoC: Intel: Skylake: Add dai link for DMIC capture

Mousami Jana (1):
  ASoC: Intel: Skylake: add LARGE_CONFIG_GET IPC support

Omair M Abdullah (2):
  ASoC: Intel: Skylake: update mailbox uplink window offset and size
  ASoC: Intel: Skylake: read params from DSP if module is on

Vinod Koul (2):
  ASoC: Intel: Skylake: add wov as int sink
  ASoc: Intel: Skylake: Fix the dapm machine map

 sound/soc/intel/boards/skl_rt286.c           |  58 ++++++-
 sound/soc/intel/skylake/skl-messages.c       | 105 +++++++++++-
 sound/soc/intel/skylake/skl-pcm.c            |  23 ++-
 sound/soc/intel/skylake/skl-sst-dsp.h        |  18 +-
 sound/soc/intel/skylake/skl-sst-ipc.c        | 100 +++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h        |   9 +
 sound/soc/intel/skylake/skl-sst.c            | 175 +++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.c       | 242 ++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl-topology.h       |  32 +++-
 sound/soc/intel/skylake/skl-tplg-interface.h |  23 ++-
 10 files changed, 761 insertions(+), 24 deletions(-)

-- 
2.4.3
