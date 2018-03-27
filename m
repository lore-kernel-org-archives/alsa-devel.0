From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH v3 0/2] ASoC: topology: Improve parsing hw_configs
Date: Tue, 27 Mar 2018 22:56:30 +0200
Message-ID: <20180327205632.3677-1-k.marinushkin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello Jaroslav, Takashi, Mark,

This patch series is a resend of [1] and [2], rebased on top of the latest
head. It was logical to resend them together.

It includes 2 patches for linux + 2 patches for alsa-lib.

Please have a look.

Best Regards,
Kirill

[1] https://patchwork.kernel.org/patch/10250485/
[2] https://patchwork.kernel.org/patch/10230611/

Kirill Marinushkin (2):
  ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
  ASoC: topology: Add missing clock gating parameter when parsing
    hw_configs

 include/uapi/sound/asoc.h | 23 ++++++++++++++++++++---
 sound/soc/soc-topology.c  | 19 ++++++++++++++-----
 2 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.13.6
