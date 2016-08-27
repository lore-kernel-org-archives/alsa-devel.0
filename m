From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 0/4] ASoC: dapm: Various fixes for dapm kcontrols
Date: Sat, 27 Aug 2016 19:27:57 +0800
Message-ID: <20160827112801.31010-1-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi everyone,

This series is a bunch of fixes for some problems I encountered while
experimenting with various dapm kcontrols for Allwinner A31 support
in sun4i-codec.

Patch 1 fixes a possible uninitialized variable usage in
snd_soc_dapm_get_volsw(). This doesn't show up as a compiler warning
but I'm fairly certain it might happen.

Patch 2 fixes setting the value for an enum kcontrol's second channel.

Patch 3 fixes kcontrol creation for output driver widgets. An output
driver widget is the same as a PGA widget, just with a different
priority.

Patch 4 adds an error message if anyone attempts to add hardware backed
kcontrols on PGA widgets. Originally kcontrols on PGAs weren't supported
at all. Support for them on virtual widgets were added later, but a guard
for real widgets was missing.


Regards
ChenYu


Chen-Yu Tsai (4):
  ASoC: dapm: Fix possible uninitialized variable in
    snd_soc_dapm_get_volsw()
  ASoC: dapm: Fix value setting for _ENUM_DOUBLE MUX's second channel
  ASoC: dapm: Fix kcontrol creation for output driver widget
  ASoC: dapm: Give error when adding hardware backed controls for PGA
    widgets

 sound/soc/soc-dapm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.9.3
