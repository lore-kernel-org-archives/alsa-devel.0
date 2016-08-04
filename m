From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/4] ASoC: da7213: Device clocking updates and fixes
Date: Thu, 4 Aug 2016 15:35:35 +0100
Message-ID: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch set contains a series of patches relating to device clocking. The
changes are as follows:

 1) Set correct default BCLKs per WCLK to achieve all DAI formats. Currently
    only 16-bit formats would operate correctly.
 2) Only use MCLK as required, when an audio stream is active. Can be disabled
    all other times.
 3) Refactoring of sysclk() and pll() functions to make them cleaner, removing
    need for unnecessary private flags, and resolve incorrect 32Khz mode
    configuration.
 4) Improve 32KHz PLL locking with some small register updates when configuring
    PLL and when DAI is enabled.

Patches are based on v4.7 Linux kernel

Adam Thomson (4):
  ASoC: da7213: Default to 64 BCLKs per WCLK to support all formats
  ASoC: da7213: Improve driver efficiency with regards to MCLK usage
  ASoC: da7213: Refactor sysclk(), pll() functions to improve handling
  ASoC: da7213: Improve 32KHz mode PLL locking

 sound/soc/codecs/da7213.c | 134 +++++++++++++++++++++++++++++-----------------
 sound/soc/codecs/da7213.h |  12 +++--
 2 files changed, 94 insertions(+), 52 deletions(-)

--
1.9.3
