From: John Keeping <john@metanate.com>
Subject: [PATCH 0/9] ASoC: es8328 codec improvements
Date: Mon,  9 May 2016 12:24:28 +0100
Message-ID: <20160509112437.8924-1-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

The first 4 patches are bug fixes, then the next 4 add support for more
sample rates and formats.

The final patch I'm slightly unsure about since the hardware does allow
different playback and capture rates, but it only allows 8kHz and 48kHz
or 8.0182kHz and 44.1kHz, all other rates have to be symmetric.

All of these patches have been tested on a Radxa Rock2 Square with
rockchip-i2s.

John Keeping (9):
  ASoC: es8328: Move clock setup to hw_params
  ASoC: es8328: Fix ADC format setup
  ASoC: es8328: Fix mask for VMIDSEL
  ASoC: es8328: Use single R/W for regmap
  ASoC: es8328: Use more suitable definition for mic bias
  ASoC: es8328: Move sample size setup to hw_params
  ASoC: es8328: Support more sample formats
  ASoC: es8328: Support more sample rates
  ASoC: es8328: Set symmetric rates

 sound/soc/codecs/es8328.c | 198 +++++++++++++++++++++++++++++++++++-----------
 sound/soc/codecs/es8328.h |  23 ++++--
 2 files changed, 168 insertions(+), 53 deletions(-)

-- 
2.8.0.rc4.238.g874082a
