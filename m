From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/4] Intel/rt5651 updates
Date: Fri,  5 Jan 2018 13:20:17 -0600
Message-ID: <20180105192023.11229-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A42A267AA9
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 20:20:30 +0100 (CET)
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
Cc: tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, Carlo Caione <carlo@caione.org>, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

Fix existing quirks and add new ones, and add support for LineIn

An updated UCM file supporting all possible inputs/outputs is
available at https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
Additional validation of the microphone/LineIn settings is still on-going
with Carlo Caione and Realtek.

Keyon Jie (1):
  ASoC: Intel: bytcr-rt5651: add quirk for IN3P which may also be used

Pierre-Louis Bossart (3):
  ASoC: Intel: bytcr-rt5651: enable MinnowBoard Turbot quirks
  ASoC: Intel: bytcr-rt5651: fix Kiano DMI quirk
  ASoC: Intel: bytcr-rt5651: add support for Line In

 sound/soc/intel/boards/bytcr_rt5651.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

-- 
2.14.1
