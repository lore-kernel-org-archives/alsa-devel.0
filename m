From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 0/2] ASoC: Intel: Export Baytrail PCM streams
	under one DAI
Date: Wed, 14 May 2014 17:20:52 +0300
Message-ID: <1400077254-31465-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D117261B03
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 16:21:04 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

It wasn't necessary to export Baytrail SST PCM streams under separate
DAI links and complicated needlessly basic ALSA command usage (for
instance arecord).

This set exports PCM playback/capture streams under one DAI. Change
should be safe now since known users are already converted and to my
understanding no other distribution is using this yet (mainly due
missing firmware).

Liam Girdwood (2):
  ASoC: Intel: Make Baytrail PCM data per stream rather than per DAI
    device
  ASoC: Intel: Only export one Baytrail DAI

 sound/soc/intel/byt-rt5640.c       | 14 +-------------
 sound/soc/intel/sst-baytrail-pcm.c | 23 ++++++++++-------------
 2 files changed, 11 insertions(+), 26 deletions(-)

-- 
2.0.0.rc0
