From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 0/4] new fix for broadwell module removing
	failed issue
Date: Sat, 30 May 2015 22:33:55 +0800
Message-ID: <1432996439-8052-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BC8E26048D
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2015 16:29:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This patch series are based on broonie/sound.git for-next branch, commit
01a4d5083562fcdeab99d42b0873aabc5fcca018.

The broadwell platform driver had module removing failed issue, and the
two commits("ASoC: Intel: remove unused function hsw_pcm_free_modules()"
and "ASoC: Intel: fix broadwell module removing failed issue") workaround
it.

But at the same time, we shouldn't leave the device as suspended state
after module freed, it is not good to do runtime suspend at driver free
either, so the fix was workaround only and not good enough.

Here revert the old fix, and replace it with new unified procedure for
runtime modules freeing:
suspends firmware ==> frees runtime modules ==> unloads firmware.

With this new procedure, we remove the runtime modules at both runtime
suspend(D0->D3) and module(snd_soc_sst_haswell_pcm) removing, but make
sure we do it only once.

Jie Yang (4):
  Revert "ASoC: Intel: remove unused function hsw_pcm_free_modules()"
  Revert "ASoC: Intel: fix broadwell module removing failed issue"
  ASoC: Intel: check and clear runtime module pointer
  ASoC: Intel: handle haswell pcm suspend including runtime modules
    freeing

 sound/soc/intel/haswell/sst-haswell-pcm.c | 46 +++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 9 deletions(-)

-- 
1.9.1
