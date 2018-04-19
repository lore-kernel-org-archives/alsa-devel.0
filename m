From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 0/3] ASoC: Add Multi CPU DAI support
Date: Thu, 19 Apr 2018 15:19:16 +0530
Message-ID: <1524131359-24387-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DBAE267079
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 11:44:50 +0200 (CEST)
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

As discussed in [1], ASoC core supports multi codec DAIs
on a DAI link. However it does not do so for CPU DAIs.

So, add support for multi CPU DAIs on a DAI Link by adding
multi CPU DAI in Card instantiation, suspend and resume
functions, PCM ops, stream handling functions and DAPM.

[1]: https://www.spinics.net/lists/alsa-devel/msg71369.html

Changes in v3:
 - Rebased on asoc for-next

Shreyas NC (3):
  ASoC: Add initial support for multiple CPU DAIs
  ASoC: Add Multi CPU DAI support for PCM ops
  ASoC: Add Multi CPU DAI support in DAPM

 include/sound/soc.h  |   6 +
 sound/soc/soc-core.c | 283 ++++++++++++++++++++----------
 sound/soc/soc-dapm.c |  71 +++++---
 sound/soc/soc-pcm.c  | 483 +++++++++++++++++++++++++++++++++------------------
 4 files changed, 565 insertions(+), 278 deletions(-)

-- 
2.7.4
