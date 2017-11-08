From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 0/7] mark expected switch fall-throughs
Date: Wed, 8 Nov 2017 14:03:33 -0600
Message-ID: <cover.1510170034.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, this patchset aims
to mark switch cases where we are expecting to fall through.

Thanks!

Gustavo A. R. Silva (7):
  ASoC: msm8916-wcd-analog: mark expected switch fall-through
  ASoC: tlv320aic23: mark expected switch fall-through
  ASoC: tlv320dac31xx: mark expected switch fall-through
  ASoC: tpa6130a2: mark expected switch fall-through
  ASoC: wm8753: mark expected switch fall-throughs
  ASoC: wm8993: mark expected switch fall-throughs
  ASoC: wm8994: mark expected switch fall-throughs

 sound/soc/codecs/msm8916-wcd-analog.c | 1 +
 sound/soc/codecs/tlv320aic23.c        | 1 +
 sound/soc/codecs/tlv320aic31xx.c      | 2 +-
 sound/soc/codecs/tpa6130a2.c          | 1 +
 sound/soc/codecs/wm8753.c             | 4 ++--
 sound/soc/codecs/wm8993.c             | 2 ++
 sound/soc/codecs/wm8994.c             | 2 ++
 7 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.7.4
