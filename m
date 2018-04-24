From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 0/3] ASoC: Add multiple CPU DAI support
Date: Tue, 24 Apr 2018 11:35:51 +0530
Message-ID: <1524549954-29144-1-git-send-email-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id EF232266E30
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 08:01:23 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

As discussed in [1], DAI link supports multiple codec DAIs
however it does not do so for CPU DAIs.

So, add support for multiple CPU DAIs on a DAI Link by adding
multiple CPU DAI in Card instantiation, suspend and resume
functions, PCM ops, stream handling functions and DAPM.

[1]: https://www.spinics.net/lists/alsa-devel/msg71369.html

changes in v4:
 - rebase on asoc-next
 - update changelogs to add more description of changes done

Shreyas NC (3):
  ASoC: Add initial support for multiple CPU DAIs
  ASoC: Add multiple CPU DAI support for PCM ops
  ASoC: Add multiple CPU DAI support in DAPM

 include/sound/soc.h  |   6 +
 sound/soc/soc-core.c | 283 ++++++++++++++++++++----------
 sound/soc/soc-dapm.c |  71 +++++---
 sound/soc/soc-pcm.c  | 483 +++++++++++++++++++++++++++++++++------------------
 4 files changed, 565 insertions(+), 278 deletions(-)

-- 
2.7.4
