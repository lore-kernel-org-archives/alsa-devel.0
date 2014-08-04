From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 0/3] ASoC: Intel: mfld-pcm: Fix to remove ioctls
Date: Mon,  4 Aug 2014 15:04:18 +0530
Message-ID: <1407144861-30475-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CFFBC26072A
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 11:55:44 +0200 (CEST)
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch series removes the ioctl type interface and uses dedicated ops. 

Subhransu S. Prusty (2):
  ASoC: Intel: mfld-pcm: Use function instead of ioctl
  ASoC: Intel: mfld-pcm: Change sst_ops prototypes to take dev parameter

Vinod Koul (1):
  ASoC: Intel: Fix to use byte control interface

 sound/soc/intel/sst-mfld-platform-pcm.c | 26 +++++++++++---------------
 sound/soc/intel/sst-mfld-platform.h     | 27 +++++++++------------------
 2 files changed, 20 insertions(+), 33 deletions(-)

-- 
1.9.0
