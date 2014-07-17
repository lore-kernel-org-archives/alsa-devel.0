From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/4] More componentization preparation
Date: Thu, 17 Jul 2014 22:01:04 +0200
Message-ID: <1405627268-23939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id CC875265328
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 22:01:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

Now that the multi-CODEC patches have been merged we can continue with the
componentization. Since it is already rather late in the development cycle again
this series only has a small set of cleanup and preparation patches so we have
that out of the way. The first patch removes the unused snd_soc_card
platform_list, the other three patches move the card field from the
snd_soc_platform and snd_soc_codec struct and consolidates the registration of
controls on top of that.

Series depends on topic/multi

- Lars

Lars-Peter Clausen (4):
  ASoC: Remove per card platform list
  ASoC: tegra: Replace instances of rtd->codec->card with rtd->card
  ASoC: Move card field form platform/codec to component
  ASoC: Add function to register component controls

 include/sound/soc.h              | 12 ++++------
 sound/soc/codecs/ac97.c          |  4 ++--
 sound/soc/codecs/cx20442.c       |  6 ++---
 sound/soc/codecs/uda134x.c       |  2 +-
 sound/soc/codecs/wm8960.c        |  2 +-
 sound/soc/codecs/wm_adsp.c       |  4 ++--
 sound/soc/omap/ams-delta.c       |  2 +-
 sound/soc/soc-core.c             | 52 +++++++++++++++++++++++++---------------
 sound/soc/soc-dapm.c             |  2 +-
 sound/soc/soc-jack.c             |  4 ++--
 sound/soc/tegra/tegra_alc5632.c  |  5 ++--
 sound/soc/tegra/tegra_max98090.c |  5 ++--
 sound/soc/tegra/tegra_rt5640.c   |  5 ++--
 sound/soc/tegra/tegra_wm8753.c   |  3 +--
 sound/soc/tegra/tegra_wm8903.c   |  5 ++--
 sound/soc/tegra/trimslice.c      |  3 +--
 16 files changed, 61 insertions(+), 55 deletions(-)

-- 
1.8.0
