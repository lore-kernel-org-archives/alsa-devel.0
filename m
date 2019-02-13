From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/2] ASoC: da7219: BCLK and TDM flexibility improvements
Date: Wed, 13 Feb 2019 17:47:31 +0000
Message-ID: <cover.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Akshu Agrawal <Akshu.Agrawal@amd.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch set updates the driver to be more flexible regarding the BCLK and
TDM configurations of the device.

Previously the BCLK rate was fixed at 64 periods per WCLK, when the codec is
DAI clock master, but to satisfy devices which prefer a lower rate, and to save
power, the BCLK rate is now calculated based on hw_params() data.

As a fallout of the BCLK efforts it was also apparent that the TDM code could be
made more flexible as well. The device is capable of automatically detecting
the BCLK rate when it is clock slave, so previous limitations imposed were
not necessary. The mask handling is now used as an input to determine the BCLK
offset to align closer with other examples within ALSA.

Adam Thomson (2):
  ASoC: da7219: Add support for master mode BCLK rate adjustment
  ASoC: da7219: Update TDM usage to be more flexible

 sound/soc/codecs/da7219.c | 116 +++++++++++++++++++++++++++++-----------------
 sound/soc/codecs/da7219.h |   1 +
 2 files changed, 74 insertions(+), 43 deletions(-)

-- 
1.9.1
