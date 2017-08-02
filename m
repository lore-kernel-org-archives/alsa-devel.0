From: Naveen M <naveen.m@intel.com>
Subject: [PATCH 0/3] ASoC: Intel: kbl: Add Multi-endpoint
	Playback & Echo Ref support
Date: Wed,  2 Aug 2017 11:43:32 +0530
Message-ID: <1501654415-24590-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 56070266A8A
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 08:13:22 +0200 (CEST)
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

1. Add new FE capabilities to support:
  a. Parallel playback on 2 ports simultaneously
     Define new frontends to enable additional playback port.
     This will be used when platform needs to support multi-playback
     on different ports. Ex: Headset and Speaker simultaneously
  b. Echo reference capture capability
     Certain platforms need reference stream of playback to supplement
     User-space post-processing algorithms. This pin enables platform
     driver to provide such a FE.
2. Add DAI links for parallel playback and echo ref
3. Add map for new DAIs for parallel playback and echo ref

Naveen M (3):
  ASoC: Intel: kbl: Add new FEs for Multi-Playback & Echo-Reference
  ASoC: Intel: kbl: Add DAI links for Multi-Playback & Echo-reference
  ASoC: Intel: kbl: Add map for new DAIs for Multi-Playback & Echo Ref

 sound/soc/intel/boards/kbl_rt5663_max98927.c       | 30 +++++++++++++++++++---
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 30 +++++++++++++++++++---
 sound/soc/intel/skylake/skl-pcm.c                  | 26 +++++++++++++++++++
 3 files changed, 80 insertions(+), 6 deletions(-)

-- 
1.9.1
