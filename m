From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RFC 00/15] ASoC: qcom: Add capture support.
Date: Mon,  1 Feb 2016 17:27:02 +0000
Message-ID: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

LPASS IP on QCOM SOC supports both Playback and capture
via I2S, but this feature is missing in existing code. 
This patchset aims at adding capture support to lpass IP.
First few patches in this series does cleanup the driver
to make easy to add capture support.

These patches are tested on DB410C with Headset Mic.

Thanks,
srini

Srinivas Kandagatla (15):
  ASoC: qcom: use snd_dma_alloc/free* apis
  ASoC: qcom: add wrdma register details to lpass_variant
  ASoC: qcom: rename rdmactl_audif_start to dmactrl_audif_start
  ASoC: qcom: pass direction to dma allocation
  ASoC: qcom: ipq806x: add error in dma allocation.
  ASoC: qcom: ipq806x: add wrdma related register offsets
  ASoC: qcom: add mic related i2s control register defines
  ASoC: qcom: add wrdma dma channel start
  ASoC: qcom: rename rdma_ch_bit_map to dma_ch_bit_map
  ASoC: qcom: apq8016: add wrdma support
  ASoC: qcom: add wrdma register definations
  ASoC: qcom: add generic bit masks for RDMA and WRDMA
  ASoC: qcom: apq8016: set the correct max register for regmap
  ASoC: qcom: apq8016-sbc: add mic support
  ASoC: qcom: add mic support

 sound/soc/qcom/apq8016_sbc.c     |  10 +-
 sound/soc/qcom/lpass-apq8016.c   |  31 +++--
 sound/soc/qcom/lpass-cpu.c       | 146 +++++++++++++++++------
 sound/soc/qcom/lpass-ipq806x.c   |  11 +-
 sound/soc/qcom/lpass-lpaif-reg.h | 118 +++++++++++++------
 sound/soc/qcom/lpass-platform.c  | 243 +++++++++++++++++++++++----------------
 sound/soc/qcom/lpass.h           |  10 +-
 7 files changed, 392 insertions(+), 177 deletions(-)

-- 
1.9.1
