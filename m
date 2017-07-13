From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 00/12] constify snd_soc_dai_ops structures
Date: Thu, 13 Jul 2017 15:37:08 -0500
Message-ID: <cover.1499974826.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com
 [192.185.143.234])
 by alsa0.perex.cz (Postfix) with ESMTP id BF72126727D
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 22:37:10 +0200 (CEST)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id 35D1021A48
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 15:37:09 -0500 (CDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

This patchset aims to constify all snd_soc_dai_ops structures that
are only stored in the ops field of a snd_soc_dai_driver structure.
That field is declared const, so snd_soc_dai_ops structures that have
this property can be declared as const also.

Thanks!

Gustavo A. R. Silva (12):
  ASoC: cs42l42: constify snd_soc_dai_ops structure
  ASoC: rt5663: constify snd_soc_dai_ops structure
  ASoC: rt5616: constify snd_soc_dai_ops structure
  ASoC: msm8916-wcd-analog: constify snd_soc_dai_ops structure
  ASoC: max98926: constify snd_soc_dai_ops structure
  ASoC: rt5514: constify snd_soc_dai_ops structure
  ASoC: codecs: msm8916-wcd-digital: constify snd_soc_dai_ops structure
  ASoC: max9867: constify snd_soc_dai_ops structure
  ASoC: rk3036: constify snd_soc_dai_ops structure
  ASoC: hdac_hdmi: constify snd_soc_dai_ops structure
  ASoC: dwc: constify snd_soc_dai_ops structure
  ASoC: tas5720: constify snd_soc_dai_ops structure

 sound/soc/codecs/cs42l42.c             | 2 +-
 sound/soc/codecs/hdac_hdmi.c           | 2 +-
 sound/soc/codecs/inno_rk3036.c         | 2 +-
 sound/soc/codecs/max9867.c             | 2 +-
 sound/soc/codecs/max98926.c            | 2 +-
 sound/soc/codecs/msm8916-wcd-analog.c  | 2 +-
 sound/soc/codecs/msm8916-wcd-digital.c | 2 +-
 sound/soc/codecs/rt5514.c              | 2 +-
 sound/soc/codecs/rt5616.c              | 2 +-
 sound/soc/codecs/rt5663.c              | 2 +-
 sound/soc/codecs/tas5720.c             | 2 +-
 sound/soc/dwc/dwc-i2s.c                | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.5.0
