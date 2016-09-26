From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/2] ASoC: da7219: Codec soft reset and AAD improvements
Date: Mon, 26 Sep 2016 14:29:19 +0100
Message-ID: <cover.1474896038.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Xing Zheng <zhengxing@rock-chips.com>, Hsin-Yu Chao <hychao@chromium.org>
List-Id: alsa-devel@alsa-project.org

This patch set makes the following updates to the driver code:

 1) Ensures codec is properly reset at startup, and if previously active then
    disable audio paths prior to reset.
 2) Disables AAD in suspend, if device is not a wake-up source.

Changes are based on top of latest code introduced under the following commits:

ASoC: da7219: software reset codec at probe
ASoC: da7219: Support HP detect procedure when MCLK not present

Adam Thomson (2):
  ASoC: da7219: Reset codec gracefully, if still active
  ASoC: da7219: Disable AAD if codec is not a wake-up source

 include/sound/da7219.h        |  2 ++
 sound/soc/codecs/da7219-aad.c | 56 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/da7219-aad.h |  5 ++++
 sound/soc/codecs/da7219.c     | 60 +++++++++++++++++++++++++++++++------------
 sound/soc/codecs/da7219.h     |  6 +++++
 5 files changed, 113 insertions(+), 16 deletions(-)

--
1.9.3
