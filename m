From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 0/6] ASoC: Intel: Skylake: Add loadable
	module support for Kabylake
Date: Tue, 25 Apr 2017 12:18:18 +0530
Message-ID: <1493102904-12624-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 40E492669D8
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 09:01:33 +0200 (CEST)
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

KBL module load is a bit different than rest as Library manifest
containing module information is required to be loaded first before
loading module.

So common changes are moved to helpers and arguments are modified as a
pre-work for adding module loading support.

Also, separate dsp_fw_ops is registered and load library for kabylake is
added to use code loader dma for library and module load.

changes in v2:
	- Few minor fixes in comments
	- Fixed the cover letter subject

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

 sound/soc/intel/skylake/bxt-sst.c       |  68 +++--------------
 sound/soc/intel/skylake/skl-messages.c  |   2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h   |  13 +++-
 sound/soc/intel/skylake/skl-sst-ipc.c   |  10 ++-
 sound/soc/intel/skylake/skl-sst-ipc.h   |   2 +-
 sound/soc/intel/skylake/skl-sst-utils.c |  80 ++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst.c       | 125 ++++++++++++++++++++++++--------
 7 files changed, 208 insertions(+), 92 deletions(-)

-- 
1.9.1
