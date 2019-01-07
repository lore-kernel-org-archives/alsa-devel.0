From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/2] ASoC: da7219: Improvements to DAI clocks handling in driver
Date: Mon, 7 Jan 2019 16:11:45 +0000
Message-ID: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Akshu Agrawal <Akshu.Agrawal@amd.com>, Daniel Kurtz <djkurtz@google.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This small patchset provides improvements to CCF based clock handling relating
to the DAI clocks. In the first patch MCLK is made parent of DAI clocks, if MCLK
has been provided to the driver, which means that MCLK will automatically be
enabled as a prerequisite to DAI clocks. The second patch adds the ability to
read the WCLK rate provided by the codec when DAI clocks are featured. This is
more useful than the returned rate simply being the rate of the parent clock,
which in this case would be MCLK.

Adam Thomson (2):
  ASoC: da7219: MCLK should be enabled before DAI clocks
  ASoC: da7219: Add recalc_rate function to return DAI clock rate

 sound/soc/codecs/da7219.c | 77 ++++++++++++++++++++++++++++++++++++++++-------
 sound/soc/codecs/da7219.h |  1 +
 2 files changed, 67 insertions(+), 11 deletions(-)

-- 
1.9.1
