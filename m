From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/3] ASoC: da7219: Extend CCF support to allow WCLK/BCLK config
Date: Tue, 19 Mar 2019 17:49:29 +0000
Message-ID: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Akshu Agrawal <Akshu.Agrawal@amd.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch set extends the existing CCF support in the DA7219 codec driver by
splitting the DAI clock gate into clocks to cover WCLK and BCLK, to enable the
configuration of these clocks from audio machine drivers when this codec is
the clock master of the DAI.

Adam Thomson (3):
  ASoC: da7219: Update DAI clock binding info to cover WCLK/BCLK
  ASoC: da7219: Expose BCLK and WCLK control through CCF
  ASoC: AMD: Update DA7219 DAI clock name to align with codec updates

 Documentation/devicetree/bindings/sound/da7219.txt |   8 +-
 include/sound/da7219.h                             |   8 +-
 sound/soc/amd/acp-da7219-max98357a.c               |   2 +-
 sound/soc/codecs/da7219.c                          | 523 ++++++++++++++++-----
 sound/soc/codecs/da7219.h                          |   6 +-
 5 files changed, 412 insertions(+), 135 deletions(-)

-- 
1.9.1
