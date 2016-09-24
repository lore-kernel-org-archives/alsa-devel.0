From: Danny Milosavljevic <dannym@scratchpost.org>
Subject: [PATCH v6 0/3] ASoC: sun4i-codec: Distinguish sun4i from sun7i
Date: Sat, 24 Sep 2016 22:05:00 +0200
Message-ID: <20160924200503.10728-1-dannym@scratchpost.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-sunxi@googlegroups.com
Cc: Danny Milosavljevic <dannym@scratchpost.org>
List-Id: alsa-devel@alsa-project.org

Introduce mechanism to detect sun7i and provide a different regmap
(different compared to sun4i Allwinner A10).

The controls will be extended in a forthcoming patch - it is necessary
to distinguish between sun4i and sun7i controls because they have different
registers.

Rename SUN4I_CODEC_AC_SYS_VERI to SUN7I_CODEC_AC_DAC_CAL and rename
SUN4I_CODEC_AC_MIC_PHONE_CAL to SUN7I_CODEC_AC_MIC_PHONE_CAL because these
are actually not present on Allwinner A10.

Handle quirks by regmap config and codec and select the correct quirks
automatically.  

Danny Milosavljevic (3):
  ASoC: sun4i-codec: Rename sun4i_codec_widgets for consistency
  ASoC: sun4i-codec: Rename some sun7i-only registers
  ASoC: sun4i-codec: Add custom regmap configs

 sound/soc/sunxi/sun4i-codec.c | 50 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 9 deletions(-)
