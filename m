From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ASoC: Intel: Skylake: Refine manifest
	module info
Date: Wed, 10 Aug 2016 09:40:47 +0530
Message-ID: <1470802250-9232-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BA874265906
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 06:03:14 +0200 (CEST)
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

The module query uses a local structure dfw_config and then populates
module skl_module_cfg. Instead we can pass skl_module_cfg as argument
and get it updated in snd_skl_get_module_info()

Also we can optimize runtime processing by using driver list to populate
module info after init. That makes runtime query introduced earlier
redundant so remove that while keeping error messages.

Dharageswari R (1):
  ASoC: Intel: Skylake: modify snd_skl_get_module_info args

Vinod Koul (2):
  ASoC: Intel: Skylake: Populate modules after loading
  ASoC: Intel: Skylake: remove module id query at runtime

 sound/soc/intel/skylake/skl-pcm.c       | 27 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-dsp.h   |  7 ++++---
 sound/soc/intel/skylake/skl-sst-utils.c | 10 +++++-----
 sound/soc/intel/skylake/skl-topology.c  | 22 ++++------------------
 4 files changed, 40 insertions(+), 26 deletions(-)

-- 
1.9.1
