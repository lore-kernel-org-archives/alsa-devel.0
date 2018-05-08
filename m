From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v4 0/3] ASoC: Add Multi CPU DAI support
Date: Tue,  8 May 2018 16:15:32 +0530
Message-ID: <1525776335-26259-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D172A2676A9
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 12:48:13 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, ckeepax@opensource.cirrus.com, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

As discussed in [1], ASoC core supports multi codec DAIs
on a DAI link. However it does not do so for CPU DAIs.

So, add support for multi CPU DAIs on a DAI Link by adding
multi CPU DAI in Card instantiation, suspend and resume
functions, PCM ops, stream handling functions and DAPM.

[1]: https://www.spinics.net/lists/alsa-devel/msg71369.html

changes in v4:
 - Addressed review comments from Charles regarding error
   handling in PCM operations and other nits
 - Rebased on the latest for-next branch

Shreyas NC (3):
  ASoC: Add initial support for multiple CPU DAIs
  ASoC: Add multiple CPU DAI support for PCM ops
  ASoC: Add multiple CPU DAI support in DAPM

 include/sound/soc.h  |   6 +
 sound/soc/soc-core.c | 283 ++++++++++++++++++++----------
 sound/soc/soc-dapm.c |  71 +++++---
 sound/soc/soc-pcm.c  | 487 ++++++++++++++++++++++++++++++++++-----------------
 4 files changed, 573 insertions(+), 274 deletions(-)

-- 
2.7.4
