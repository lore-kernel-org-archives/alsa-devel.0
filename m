From: jeeja.kp@intel.com
Subject: [PATCH v3 0/2] ASoC: Intel: Skylake: Driver updates on
	DSP firmware
Date: Fri, 17 Feb 2017 22:48:55 +0530
Message-ID: <1487351937-20517-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id CC4B12671DB
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 18:07:13 +0100 (CET)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This patch series provides update on DSP firmware download by optimizing
o updating the dsp register poll method to use accurate timeout.
o optimizing ROM init retries.
o saving the firmware/library context at boot and use this ctx for
downloading the firmware to DSP memory.
o cleanup to store the library manifest data
o release the firmware in cleanup routine.

Changes in v2:
 - fixed the title to reflect the change as this is optimization.
 - removed already merged 4 patchs

Changes in v3:
 - rebased on branch topic/intel latest

Jeeja KP (2):
  ASoC: Intel: bxtn: Store the FW/Library context at boot
  ASoC: Intel: bxtn: optimize ROM init retries

 sound/soc/intel/skylake/bxt-sst.c | 82 +++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 30 deletions(-)

-- 
2.5.0
