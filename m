From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/3] ASoC: lpass-platform: Fixes and Cleanup.
Date: Mon, 31 Oct 2016 11:25:42 +0000
Message-ID: <1477913145-8259-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Kenneth Westfield <kwestfie@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

This patchset fixes broken lpass-platform driver in v4.9-rc1, and also
fixes problem while using lpass as kernel module.
There is also a cleanup patch in this series just to tidy up the code
in the same area where there is regression.

Tested this patchset with msm8916 codec patchset in linux-next on
v4.9-rc1 on DB410c.

Without this patchset lpass-platform driver can not play audio or
even load/unload as module.

Thanks,
srini

Changes since v2:
	- reordered fix so that it can go into next rc, suggested by Mark.
	- Added Acks from Kenneth

Srinivas Kandagatla (3):
  ASoC: lpass-platform: Fix broken pcm data usage
  ASoC: lpass-platform: use dma_ch instead of rdma_ch/wrdma_ch
  ASoC: lpass-cpu: add module licence and description

 sound/soc/qcom/lpass-cpu.c      |   3 +
 sound/soc/qcom/lpass-platform.c | 183 ++++++++++++++++------------------------
 sound/soc/qcom/lpass.h          |   1 -
 3 files changed, 77 insertions(+), 110 deletions(-)

-- 
2.10.1
