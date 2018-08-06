From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/5] ASoC: qcom: few trival fixes
Date: Mon,  6 Aug 2018 11:12:04 +0100
Message-ID: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.com, vkoul@kernel.org, linux-kernel@vger.kernel.org, rohitkr@codeaurora.org, bgoswami@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patchset have few trivial fixes, 3 of them to do with cleaning up the
unused header files, 1 patch is to do with fixing warning on common.c and
other is to add missing AIF_IN dapm for slim tx ports.

Thanks,
srini

Srinivas Kandagatla (5):
  ASoC: qcom: make common.c as proper module
  ASoC: apq8096: remove unused header files
  ASoC: sdm845: remove unused header files
  ASoC: qcom: remove unused header files from common.h
  ASoC: qdsp6: q6afe-dai: add SLIM tx AIF_IN dapm

 sound/soc/qcom/Kconfig           | 5 +++++
 sound/soc/qcom/Makefile          | 6 ++++--
 sound/soc/qcom/apq8096.c         | 2 --
 sound/soc/qcom/common.h          | 1 -
 sound/soc/qcom/qdsp6/q6afe-dai.c | 7 +++++++
 sound/soc/qcom/sdm845.c          | 2 --
 6 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.16.2
