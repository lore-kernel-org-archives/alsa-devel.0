From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/7] ASoC: Intel: Replace GFP_ATOMIC with
	GFP_KERNEL
Date: Fri, 20 Apr 2018 16:14:25 +0530
Message-ID: <1524221072-11040-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id A18492673D2
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 12:40:02 +0200 (CEST)
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

Jia-Ju Bai recently fixed few Intel drivers which were using GFP_ATOMIC
wrongly, this series fixes the remaining ones.

Vinod Koul (7):
  ASoC: Intel: byt-max98090: Replace GFP_ATOMIC with GFP_KERNEL
  ASoC: Intel: bytcht_es8316: Replace GFP_ATOMIC with GFP_KERNEL
  ASoC: Intel: bytcr_rt5651: Replace GFP_ATOMIC with GFP_KERNEL
  ASoC: Intel: cht_bsw_nau8824: Replace GFP_ATOMIC with GFP_KERNEL
  ASoC: Intel: kbl_da7219_max98357a: Replace GFP_ATOMIC with GFP_KERNEL
  ASoC: Intel: kbl_rt5663_max98927: Replace GFP_ATOMIC with GFP_KERNEL
  ASoC: Intel: kbl_rt5663_rt5514_max98927: Replace GFP_ATOMIC with GFP_KERNEL

 sound/soc/intel/boards/byt-max98090.c               | 2 +-
 sound/soc/intel/boards/bytcht_es8316.c              | 2 +-
 sound/soc/intel/boards/bytcr_rt5651.c               | 2 +-
 sound/soc/intel/boards/cht_bsw_nau8824.c            | 2 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c       | 2 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 2 +-
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.7.4
