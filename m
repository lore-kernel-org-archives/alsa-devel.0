From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 00/14] ASoC: qcom: Add capture support.
Date: Wed, 10 Feb 2016 10:16:58 +0000
Message-ID: <1455099418-311-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

LPASS IP on QCOM SOC supports both Playback and capture
via I2S, but this feature is missing in existing code. 
This patchset aims at adding capture support to lpass IP.
First few patches in this series does cleanup the driver
to make easy to add capture support.

Most of these patches are acked by Kenneth.

These patches are tested on DB410C with Headset Mic, secondary mic.

Thanks,
srini

Changes since RFC:
 - made patches bisectable, reported by 0day testing
 - merged two patches as suggested by Kenneth
 - used corect device for snd_dma alloc/free apis,
 spotted by Kenneth
 - renamed LPAIF_I2SCTL_MICMODE_QUAD02 to
 LPAIF_I2SCTL_MICMODE_QUAD23, spotted by Kenneth.
 - Fixed minor issues suggested by Kenneth.


Srinivas Kandagatla (14):
  ASoC: qcom: use snd_dma_alloc/free* apis
  ASoC: qcom: add wrdma register details to lpass_variant
  ASoC: qcom: rename rdmactl_audif_start to dmactrl_audif_start
  ASoC: qcom: pass direction to dma allocation
  ASoC: qcom: ipq806x: add error in dma allocation.
  ASoC: qcom: rename rdma_ch_bit_map to dma_ch_bit_map
  ASoC: qcom: ipq806x: add wrdma related register offsets
  ASoC: qcom: apq8016: add wrdma support
  ASoC: qcom: add mic related i2s control register defines
  ASoC: qcom: add wrdma register definitions
  ASoC: qcom: add generic bit masks for RDMA and WRDMA
  ASoC: qcom: apq8016: set the correct max register for regmap
  ASoC: qcom: add mic support
  ASoC: qcom: apq8016-sbc: add mic support

 sound/soc/qcom/apq8016_sbc.c     |  10 +-
 sound/soc/qcom/lpass-apq8016.c   |  31 +++--
 sound/soc/qcom/lpass-cpu.c       | 146 +++++++++++++++++------
 sound/soc/qcom/lpass-ipq806x.c   |  11 +-
 sound/soc/qcom/lpass-lpaif-reg.h | 116 +++++++++++++------
 sound/soc/qcom/lpass-platform.c  | 243 +++++++++++++++++++++++----------------
 sound/soc/qcom/lpass.h           |  10 +-
 7 files changed, 390 insertions(+), 177 deletions(-)

-- 
1.9.1
