From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH v8 0/3] ASoC: Intel: Skylake: Add a clk driver
	to enable ssp clks early
Date: Mon, 29 Jan 2018 21:45:57 +0530
Message-ID: <1517242560-22157-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D25A266FE0
 for <alsa-devel@alsa-project.org>; Mon, 29 Jan 2018 17:22:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Clock driver patches have been applied. These remaining patches are rebased
on "topic/intel". The first patch enables the mclk and ssp sclk early for
eve machine driver and the remaining two patches are effort to add more
meaning to the DSP replies for easy debugging.

Naveen M (1):
  ASoC: Intel: eve: Enable mclk and ssp sclk early

Subhransu S. Prusty (2):
  ASoC: Intel: Skylake: Make DSP replies more human readable
  ASoC: Intel: Skylake: Add FW reply for MCLK/SCLK IPC

 sound/soc/intel/boards/Kconfig                     |  1 +
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 94 ++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.c              | 50 +++++++++---
 3 files changed, 134 insertions(+), 11 deletions(-)

-- 
2.7.4
