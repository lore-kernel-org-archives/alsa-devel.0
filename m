From: Harsha Priya <harshapriya.n@intel.com>
Subject: [v2 0/3] ASoC: Intel: Fixes in Kabylake machine driver
	for clear playback and recording
Date: Wed, 26 Jul 2017 13:47:42 -0700
Message-ID: <1501102065-11083-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 98C73266D12
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 22:47:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch series includes fixes for clean playback and recording in kabylake machine driver.
It fixes the below issues in the corresponding patches and the details of each fix
is provided in the patch's commit message.

1. Fix cracking noise in rt5663 headphones

2. Fix pop noise of dmic recording 

3. Enable 4 slot IV feedback for maxim amps

Harsha Priya (3):
  ASoC: Intel: Fix cracking noise in rt5663 headphones for kabylake
    platform
  ASoC: Intel: Fix pop noise of dmic recording in kabylake platform
    using rt5514
  ASoC: Intel: Enabling 4 slot IV feedback for max98927 on Kabylake
    platform

 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
1.9.1
