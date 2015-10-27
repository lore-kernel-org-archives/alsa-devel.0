From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 00/17] ASoC: Intel: Skylake: More fixes and
	updates
Date: Tue, 27 Oct 2015 09:22:43 +0900
Message-ID: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A84FC2651C0
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:23:10 +0100 (CET)
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

Hi all,

This series adds more minor fixes and some enhancements to the driver.
Most of the fixes patches are single line count changes

The enhancements are:
- optimizing code and using module pin info for unbinding
- supporting virtual dsp widgets like switches in topology
- add pin formats and supports multiple heterogeneous pins

Hardik T Shah (3):
  ASoC: Intel: Skylake: Add multiple pin formats
  ASoC: Intel: Skylake: Update the topology interface structure
  ASoC: Intel: Skylake: Add support for module GUIDs

Jeeja KP (14):
  ASoC: Intel: Skylake: Fix to correct check for non DSP widget
  ASoC: Intel: Skylake: Fix not to ignore return value in be hw_params
  ASoC: Intel: Skylake: Fix to add 32 bit in update FE params
  ASoC: Intel: Skylake: Fix to ignore codec_mask check in probe
  ASoC: Intel: Skylake: Fix to ignore blob check if link type is HDA
  ASoC: Intel: Skylake: Fix support for multiple pins in a module
  ASoC: Intel: Skylake: Fix bit depth when querying the NHLT blob
  ASoC: Intel: Skylake: use module_pin info for unbind
  ASoC: Intel: Skylake: Add support for virtual dsp widgets
  ASoC: Intel: Skylake: Fix DSP pipe underrun/overrun issue
  ASoC: Intel: Skylake: Fix to remove be copier widget power check
  ASoC: Intel: Skylake: Ignore rate check for DMIC link
  ASoC: Intel: Skylake: Fix to remove channel_map calculation
  ASoC: Intel: Skylake: Fix PM behaviour

 sound/soc/intel/skylake/skl-messages.c       | 189 +++++--------
 sound/soc/intel/skylake/skl-nhlt.c           |  19 +-
 sound/soc/intel/skylake/skl-pcm.c            | 139 +++++-----
 sound/soc/intel/skylake/skl-topology.c       | 387 ++++++++++++++-------------
 sound/soc/intel/skylake/skl-topology.h       |  35 ++-
 sound/soc/intel/skylake/skl-tplg-interface.h |  90 +++++--
 sound/soc/intel/skylake/skl.c                |  63 +++--
 sound/soc/intel/skylake/skl.h                |   1 -
 8 files changed, 483 insertions(+), 440 deletions(-)

-- 
2.4.3
