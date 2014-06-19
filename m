From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/5] ASoC: Fix trival sparse warnings
Date: Thu, 19 Jun 2014 09:40:26 +0200
Message-ID: <1403163631-26215-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 6803026525F
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 09:40:45 +0200 (CEST)
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
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This series fixes a couple of trivial issues that are reported when running
the sparse codechecker on the ASoC tree.

- Lars

Lars-Peter Clausen (5):
  ASoC: tlv320aic31xx: Remove duplicate const
  ASoC: cs42xx8: Make of match table static
  ASoC: omap-pcm: Include omap-pcm.h
  ASoC: rcar: Fix dma direction type
  ASoC: sh/fsi: Make one-bit bitfields unsigned

 sound/soc/codecs/cs42xx8.c       |  2 +-
 sound/soc/codecs/tlv320aic31xx.c | 21 ++++++++++-----------
 sound/soc/omap/omap-pcm.c        |  1 +
 sound/soc/sh/fsi.c               | 12 ++++++------
 sound/soc/sh/rcar/core.c         |  2 +-
 sound/soc/sh/rcar/rsnd.h         |  2 +-
 6 files changed, 20 insertions(+), 20 deletions(-)

-- 
1.8.0
