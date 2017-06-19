From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/2] ASoC: da7219: Resolve HP detect issues relating to MCLK
Date: Mon, 19 Jun 2017 10:56:32 +0100
Message-ID: <cover.1497865554.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Harsha Priya <harshapriya.n@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch set resolves issues in the HP detect feature, relating to MCLK, where
the feature can misdetect headphones as lineout.

Adam Thomson (2):
  ASoC: da7219: Fix HP detection procedure for all MCLK frequencies
  ASoC: Intel: bxt: Move codec sysclk config to codec_init function

 sound/soc/codecs/da7219-aad.c                 | 31 ++++++++++++----
 sound/soc/codecs/da7219.c                     | 53 ++++++++++++++++++---------
 sound/soc/codecs/da7219.h                     |  5 ++-
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 14 ++++---
 4 files changed, 73 insertions(+), 30 deletions(-)

-- 
1.9.1
