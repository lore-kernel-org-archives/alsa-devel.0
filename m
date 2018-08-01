From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 00/11] ASoC: codecs: Mark expected switch fall-throughs
Date: Wed, 1 Aug 2018 14:47:01 -0500
Message-ID: <cover.1533151956.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, patches@opensource.cirrus.com, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

In preparation to enabling -Wimplicit-fallthrough, this patchset aims
to add some annotations in order to mark switch cases where we are
expecting to fall through.

Thanks

Gustavo A. R. Silva (11):
  ASoC: wm8961: Mark expected switch fall-through
  ASoC: rt5640: Mark expected switch fall-through
  ASoC: rt5677: Mark expected switch fall-through
  ASoC: wm8955: Mark expected switch fall-through
  ASoC: wm8960: Mark expected switch fall-through
  ASoC: wm8904: Mark expected switch fall-through
  ASoC: wm8996: Mark expected switch fall-through
  ASoC: wm8962: Mark expected switch fall-through
  ASoC: wm8995: Mark expected switch fall-through
  ASoC: wm9081: Mark expected switch fall-through
  ASoC: wm8994: Mark expected switch fall-through

 sound/soc/codecs/rt5640.c | 2 ++
 sound/soc/codecs/rt5677.c | 1 +
 sound/soc/codecs/wm8904.c | 1 +
 sound/soc/codecs/wm8955.c | 1 +
 sound/soc/codecs/wm8960.c | 1 +
 sound/soc/codecs/wm8961.c | 1 +
 sound/soc/codecs/wm8962.c | 1 +
 sound/soc/codecs/wm8994.c | 1 +
 sound/soc/codecs/wm8995.c | 1 +
 sound/soc/codecs/wm8996.c | 1 +
 sound/soc/codecs/wm9081.c | 1 +
 11 files changed, 12 insertions(+)

-- 
2.7.4
