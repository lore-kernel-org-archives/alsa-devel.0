From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 0/6] ASoC: Intel: Skylake: Add loadable module
	support for
Date: Fri, 21 Apr 2017 20:28:07 +0530
Message-ID: <1492786693-24167-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 23B79267101
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 17:11:14 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Module loading (which are not part of base firmware) is different for
kbl platform compared to skl or bxtn. In kabylake library manifest
contains the module information, so load the library to get the module
information.

As a pre-work, common code which can be used for kabylake are moved to
helper and arguments to few functions are modified to support module
load for kabylake.

Separate dsp_fw_ops is registered and load library ops is added for
kabylake.

G Kranthi (2):
  ASoC: Intel: Skylake: Move sst common initialization to a helper
    function
  ASoC: Intel: Skylake: Modify arguments to reuse module transfer
    function

Sodhi, VunnyX (1):
  ASoC: Intel: Skylake: Add loadable module support on KBL platform

Subhransu S. Prusty (3):
  ASoC: Intel: Skylake: Commonize library load
  ASoC: Intel: Skylake: Register dsp_fw_ops for kabylake
  ASoC: Intel: Skylake: Modify load_lib_ipc arguments for a nowait
    version

 sound/soc/intel/skylake/bxt-sst.c       |  68 +++---------------
 sound/soc/intel/skylake/skl-messages.c  |   2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h   |  13 +++-
 sound/soc/intel/skylake/skl-sst-ipc.c   |  10 ++-
 sound/soc/intel/skylake/skl-sst-ipc.h   |   2 +-
 sound/soc/intel/skylake/skl-sst-utils.c |  80 +++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst.c       | 124 ++++++++++++++++++++++++--------
 7 files changed, 207 insertions(+), 92 deletions(-)

-- 
1.9.1
