From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/21] ASoC: codecs: remove warnings with
	Sparse, Coccinelle and W=1
Date: Fri,  4 Jan 2019 20:02:28 -0600
Message-ID: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id EDFAA267AC1
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2019 03:03:32 +0100 (CET)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This patchset contains mostly trivial fixes to make tools happy. I
don't get paid more by sending lots of small patches, my only goal is
to make sure tools don't spit out too many warnings and drown
potential problems.

Thanks for Bard Liao for his help, and Adam Thompson and Oder Chiou
for off-line reviews.

Bard liao (4):
  ASoC: rt5645: remove unused mux define
  ASoC: rt5670: remove unused mux/mixer define
  ASoC: rt5645: store eq kcontrol byte in __be
  ASoC: rl6437a: use __be32 for a __be32 buf

Pierre-Louis Bossart (17):
  ASoC: dmic: declare trigger function as static
  ASoC: max98090: remove unused constant variables
  ASoC: es8316: remove unused constant variables
  ASoC: codecs: fix kernel doc descriptions
  ASoC: max98383: fix boolean assignments to true/false
  ASoC: rt298: fix boolean tests
  ASoC: cs4271: fix boolean assignments
  ASoC: rt274: fix boolean tests
  ASoc: rt286: fix boolean tests
  ASoC: rt5640: fix boolean assignments
  ASoC: max98927: fix boolean assignments
  ASoC: rt5651: fix boolean assignments
  ASoC: nau8824: fix boolean assignment
  ASoC: tscs42xx.c: fix boolean test
  ASoC: mt6351: remove unneeded variable
  ASoC: da7219: fix endianness issues
  ASoC: da7219: use logical AND

 sound/soc/codecs/cs4271.c     |  4 +--
 sound/soc/codecs/da7219-aad.c |  2 +-
 sound/soc/codecs/da7219.c     |  8 ++---
 sound/soc/codecs/dmic.c       |  4 +--
 sound/soc/codecs/es8316.c     |  4 ---
 sound/soc/codecs/max98090.c   | 15 --------
 sound/soc/codecs/max98373.c   |  6 ++--
 sound/soc/codecs/max98927.c   |  8 ++---
 sound/soc/codecs/mt6351.c     |  4 +--
 sound/soc/codecs/nau8824.c    |  2 +-
 sound/soc/codecs/nau8825.c    |  1 +
 sound/soc/codecs/rl6347a.c    |  4 +--
 sound/soc/codecs/rt274.c      |  8 ++---
 sound/soc/codecs/rt286.c      |  8 ++---
 sound/soc/codecs/rt298.c      | 12 +++----
 sound/soc/codecs/rt5514.c     |  1 +
 sound/soc/codecs/rt5640.c     |  6 ++--
 sound/soc/codecs/rt5645.c     | 66 +++++++++--------------------------
 sound/soc/codecs/rt5651.c     |  6 ++--
 sound/soc/codecs/rt5670.c     | 54 ----------------------------
 sound/soc/codecs/rt5677.c     |  8 ++---
 sound/soc/codecs/tscs42xx.c   |  2 +-
 22 files changed, 63 insertions(+), 170 deletions(-)


base-commit: 14f9b94a3274b047126c8c0ff39dc495e8d1acab
-- 
2.17.1
