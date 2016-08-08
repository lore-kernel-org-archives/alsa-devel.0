From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/2] ASoC: da7218: Small clocking related updates for driver
Date: Mon, 8 Aug 2016 15:35:22 +0100
Message-ID: <cover.1470665013.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch set contains two updates relating to clocking. The first removes the
32KHz PLL feature as this is no longer supported, and the second provides MCLK
effciency improvements to avoid unnecessary MCLK enabling.

Changes are based on v4.8-rc1 Linux kernel.

Adam Thomson (2):
  ASoC: da7218: Remove 32KHz PLL mode from driver
  ASoC: da7218: Improve driver efficiency with regards to MCLK usage

 sound/soc/codecs/da7218.c | 34 +++++++++++++++-------------------
 sound/soc/codecs/da7218.h |  2 --
 2 files changed, 15 insertions(+), 21 deletions(-)

--
1.9.3
