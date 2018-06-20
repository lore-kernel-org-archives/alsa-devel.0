From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v6 0/3] ASoC: Add Multi CPU DAI support
Date: Wed, 20 Jun 2018 16:24:14 +0530
Message-ID: <1529492057-32627-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id AF414266D4C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 12:55:58 +0200 (CEST)
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
Cc: ckeepax@opensource.cirrus.com, patches.audio@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

As discussed in [1], ASoC core supports multi codec DAIs
on a DAI link. However it does not do so for CPU DAIs.

So, add support for multi CPU DAIs on a DAI Link by adding
multi CPU DAI in Card instantiation, suspend and resume
functions, PCM ops, stream handling functions and DAPM.

[1]: https://www.spinics.net/lists/alsa-devel/msg71369.html

changes in v6:
 - Addressed review comments from Pierre in calculating delay
for CPU DAI, add check for compress DAIs and other nits
 - add proper exit check in dpcm_prune_path() for CPU DAIs
 - rebased on latest for-next branch

Shreyas NC (3):
  ASoC: Add initial support for multiple CPU DAIs
  ASoC: Add multiple CPU DAI support for PCM ops
  ASoC: Add multiple CPU DAI support in DAPM

 include/sound/soc.h  |   6 +
 sound/soc/soc-core.c | 290 +++++++++++++++++++++---------
 sound/soc/soc-dapm.c |  71 +++++---
 sound/soc/soc-pcm.c  | 491 ++++++++++++++++++++++++++++++++++-----------------
 4 files changed, 589 insertions(+), 269 deletions(-)

-- 
2.7.4
