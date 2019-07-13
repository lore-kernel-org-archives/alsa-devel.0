From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 0/2] ASoC: samsung: odroid: fix err handling of odroid_audio_probe
Date: Sat, 13 Jul 2019 11:46:13 +0800
Message-ID: <1562989575-33785-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: krzk@kernel.org
Cc: sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
List-Id: alsa-devel@alsa-project.org

We developed a coccinelle SmPL to detect sound/soc/samsung/odroid.c and
found some use-after-free problems.
This patch series fixes those problems.

Wen Yang (2):
  ASoC: samsung: odroid: fix an use-after-free issue for codec
  ASoC: samsung: odroid: fix a double-free issue for cpu_dai

 sound/soc/samsung/odroid.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org

-- 
2.9.5
