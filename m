From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH 0/3] ASoC: Add Multi CPU DAI support
Date: Tue,  6 Mar 2018 16:30:27 +0530
Message-ID: <1520334030-8018-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 354C02670A1
 for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2018 12:02:56 +0100 (CET)
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
Cc: lars@metafoo.de, kuninori.morimoto.gx@renesas.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

As discussed in [1], ASoC core supports multi codec DAIs
on a DAI link. However it does not do so for CPU DAIs.

So, add support for multi CPU DAIs on a DAI Link by adding
multi CPU DAI in Card instantiation, suspend and resume
functions, PCM ops, stream handling functions and DAPM.

[1]: https://www.spinics.net/lists/alsa-devel/msg71369.html

Shreyas NC (3):
  ASoC: Add initial support for multiple CPU DAIs
  ASoC: Add Multi CPU DAI support for PCM ops
  ASoC: Add Multi CPU DAI support in DAPM

 include/sound/soc.h  |   5 +
 sound/soc/soc-core.c | 195 ++++++++++++++++------
 sound/soc/soc-dapm.c |  71 +++++---
 sound/soc/soc-pcm.c  | 460 +++++++++++++++++++++++++++++++++------------------
 4 files changed, 495 insertions(+), 236 deletions(-)

-- 
2.7.4
