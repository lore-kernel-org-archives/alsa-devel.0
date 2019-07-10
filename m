From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 0/4] Fix some use-after-free problems in sound/soc/generic
Date: Wed, 10 Jul 2019 15:25:05 +0800
Message-ID: <1562743509-30496-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jonathanh@nvidia.com, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
List-Id: alsa-devel@alsa-project.org

We developed a coccinelle SmPL to detect sound/sooc/generic code and
found some use-after-free problems.
This patch series fixes those problems.

Wen Yang (4):
  ASoC: simple-card: fix an use-after-free in simple_dai_link_of_dpcm()
  ASoC: simple-card: fix an use-after-free in simple_for_each_link()
  ASoC: audio-graph-card: fix use-after-free in graph_dai_link_of_dpcm()
  ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()

 sound/soc/generic/audio-graph-card.c | 30 ++++++++++++++++--------------
 sound/soc/generic/simple-card.c      | 26 +++++++++++++-------------
 2 files changed, 29 insertions(+), 27 deletions(-)

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org

-- 
2.9.5
