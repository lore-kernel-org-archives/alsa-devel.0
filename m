From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/2] ASoC: da7219: Improve mclk error checking, use of_match_ptr
Date: Wed, 7 Oct 2015 11:57:10 +0100
Message-ID: <cover.1444214947.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch set contains a couple of small updates/fixes:

 - Use of of_match_ptr() for assigning match table to driver structure
 - Only enable/disable mclk if it has been provided to the driver.
 - Add error checking of clk_prepare_enable.

Patch set is based on changes introduced under patch:

'ASoC: da7219: Improve error handling for regulator supplies'
(Commit 4e929134eb8271abc9c52c371e056debfea6898b , kernel/git/broonie/sound.git)

Adam Thomson (2):
  ASoC: da7219: Use of_match_ptr() when assigning match table
  ASoC: da7219: Improve error checking of mclk enable/disable

 sound/soc/codecs/da7219.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--
1.9.3
