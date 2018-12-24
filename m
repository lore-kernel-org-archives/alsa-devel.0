From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 0/2] ASoC: soc-core: add snd_soc_of_lookup_component()
Date: Mon, 24 Dec 2018 14:32:11 +0530
Message-ID: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, asishb@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Platform DAI component probe is not called if it is not
present in component list during sound card registration.
Add snd_soc_of_lookup_component() to get component info from
device_node. This can be used by machine driver to make sure that
card components are registered before calling snd_soc_register_card().


Ajit Pandey (2):
  ASoC: soc-core: add snd_soc_of_lookup_component()
  ASoC: qcom: defer probe if platform dai is not registered

 include/sound/soc.h     |  1 +
 sound/soc/qcom/common.c |  9 +++++++++
 sound/soc/soc-core.c    | 28 ++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
