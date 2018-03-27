From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH, alsa-lib, v3 0/2] alsa-lib: ASoC: topology: Improve parsing hw_configs
Date: Tue, 27 Mar 2018 23:00:48 +0200
Message-ID: <20180327210050.3728-1-k.marinushkin@gmail.com>
References: <20180327205632.3677-1-k.marinushkin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180327205632.3677-1-k.marinushkin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

Below is the alsa-lib part of the patch-series
"ASoC: topology: Improve parsing hw_configs"

Kirill Marinushkin (2):
  ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
  ASoC: topology: Add missing clock gating parameter when parsing
    hw_configs

 include/sound/asoc.h                       | 23 ++++++++++++++++---
 include/topology.h                         |  6 ++---
 src/conf/topology/broadwell/broadwell.conf |  4 ++--
 src/topology/pcm.c                         | 36 +++++++++++++++++++++++++-----
 4 files changed, 56 insertions(+), 13 deletions(-)

-- 
2.13.6
