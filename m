From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v2 0/3] ASoC: Add Multi CPU DAI support
Date: Tue, 27 Mar 2018 16:03:28 +0530
Message-ID: <1522146811-29951-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id D3FB5267076
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 12:36:01 +0200 (CEST)
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
Cc: lars@metafoo.de, ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

As discussed in [1], ASoC core supports multi codec DAIs
on a DAI link. However it does not do so for CPU DAIs.

So, add support for multi CPU DAIs on a DAI Link by adding
multi CPU DAI in Card instantiation, suspend and resume
functions, PCM ops, stream handling functions and DAPM.

[1]: https://www.spinics.net/lists/alsa-devel/msg71369.html

Changes in v2:
 - Addressed review comments by Charles
 - Rebased on latest for-next branch

Shreyas NC (3):
  ASoC: Add initial support for multiple CPU DAIs
  ASoC: Add Multi CPU DAI support for PCM ops
  ASoC: Add Multi CPU DAI support in DAPM

 include/sound/soc.h  |   5 +
 sound/soc/soc-core.c | 283 ++++++++++++++++++++----------
 sound/soc/soc-dapm.c |  71 +++++---
 sound/soc/soc-pcm.c  | 483 +++++++++++++++++++++++++++++++++------------------
 4 files changed, 564 insertions(+), 278 deletions(-)

-- 
2.7.4
