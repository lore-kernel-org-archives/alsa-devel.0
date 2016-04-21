From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/2] ASoC: Intel: Skylake: Add support for
	firmware manifest
Date: Thu, 21 Apr 2016 11:45:21 +0530
Message-ID: <1461219323-1036-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 960A1264F22
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 08:10:48 +0200 (CEST)
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

In the DSP firmware, module params like module_id and loadable
flags can be modified. So, it is required to read these
parameters in the driver from the firmware manifest.

Changes in v2:
 - remove strings and use UUID in bin format

Shreyas NC (2):
  ASoC: Intel: Skylake: Use UUID in binary format
  ASoC: Intel: Skylake: Add DSP firmware manifest parsing

 sound/soc/intel/skylake/Makefile             |   2 +-
 sound/soc/intel/skylake/skl-dsp-parse.c      | 105 ++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-dsp-parse.h      | 107 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-dsp.h        |   2 +-
 sound/soc/intel/skylake/skl-sst-ipc.h        |   4 +
 sound/soc/intel/skylake/skl-sst.c            |  20 ++++-
 sound/soc/intel/skylake/skl-topology.c       |  11 ++-
 sound/soc/intel/skylake/skl-topology.h       |   2 +-
 sound/soc/intel/skylake/skl-tplg-interface.h |   2 +-
 9 files changed, 243 insertions(+), 12 deletions(-)
 create mode 100644 sound/soc/intel/skylake/skl-dsp-parse.c
 create mode 100644 sound/soc/intel/skylake/skl-dsp-parse.h

-- 
1.9.1
