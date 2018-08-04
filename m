From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 00/12] ASoC: codecs: use true and false for boolean values
Date: Sat, 4 Aug 2018 16:48:13 -0500
Message-ID: <cover.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org
Cc: patches@opensource.cirrus.com, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

This patchset aims to replace the use of integer values with a
proper true or false in return statements for functions returning
bool.

Thanks

Gustavo A. R. Silva (12):
  ASoC: max9850: use true and false for boolean values
  ASoC: rt5631: use true and false for boolean values
  ASoC: tda7419: use true and false for boolean values
  ASoC: wm8990: use true and false for boolean values
  ASoC: cs4270: use true and false for boolean values
  ASoC: wm8996: use true and false for boolean values
  ASoC: da7219: use true and false for boolean values
  ASoC: twl6040: use true and false for boolean values
  ASoC: da7213: use true and false for boolean values
  ASoC: wm5100-tables: use true and false for boolean values
  ASoC: da9055: use true and false for boolean values
  ASoC: wm8903: use true and false for boolean values

 sound/soc/codecs/cs4270.c        |  2 +-
 sound/soc/codecs/da7213.c        |  4 ++--
 sound/soc/codecs/da7219.c        |  4 ++--
 sound/soc/codecs/da9055.c        |  4 ++--
 sound/soc/codecs/max9850.c       |  4 ++--
 sound/soc/codecs/rt5631.c        |  8 ++++----
 sound/soc/codecs/tda7419.c       |  4 ++--
 sound/soc/codecs/twl6040.c       |  2 +-
 sound/soc/codecs/wm5100-tables.c | 12 ++++++------
 sound/soc/codecs/wm8903.c        |  4 ++--
 sound/soc/codecs/wm8990.c        |  4 ++--
 sound/soc/codecs/wm8996.c        |  8 ++++----
 12 files changed, 30 insertions(+), 30 deletions(-)

-- 
2.7.4
