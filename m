From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ASoC: Intel: Skylake: Some more fixes
Date: Fri, 30 Oct 2015 20:34:21 +0530
Message-ID: <1446217461-2106-5-git-send-email-vinod.koul@intel.com>
References: <1446217461-2106-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 733F92612D7
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 16:01:27 +0100 (CET)
In-Reply-To: <1446217461-2106-1-git-send-email-vinod.koul@intel.com>
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

This would hopefully be last round of fixes required to have SKL completely
functional on upstream.

First patch is actually only one required for that which adds misisng
mahcine entry for SKL boards with RT286.
Rest of the two are fixes for static checker warnings reported by folks.

Jeeja KP (1):
  ASoC: Intel: Skylake: fix missing machine device creation

Subhransu S. Prusty (1):
  ASoC: Intel: Skylake: Fix to cleanup if skl_sst_dsp_init fails

Vinod Koul (1):
  ASoC: Intel: Skylake: Fix substream dereference before check

 sound/soc/intel/skylake/skl-pcm.c |  3 +-
 sound/soc/intel/skylake/skl-sst.c |  7 ++--
 sound/soc/intel/skylake/skl.c     | 79 ++++++++++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl.h     |  1 +
 4 files changed, 84 insertions(+), 6 deletions(-)

-- 
1.9.1
