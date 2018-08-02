From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] ASoC: core: remove support for card rebind using component framework
Date: Thu,  2 Aug 2018 16:03:35 +0100
Message-ID: <20180802150338.24538-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.com, vkoul@kernel.org, linux-kernel@vger.kernel.org, rohitkr@codeaurora.org, bgoswami@codeaurora.org, stefan.wahren@i2se.com, guillaume.tucker@collabora.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

DRM based audio components get registered inside the component framework
bind callback. However component framework has a big mutex lock taken for
every call to component_add, component_del and bind, unbind callbacks.

This can lead to deadlock situation if we are trying to add new/remove
component within a bind/unbind callbacks. Which is what was happening
with bcm2837 rpi 3.

Revert this change till we sort out the mutex issue.

Thanks,
srini

Srinivas Kandagatla (3):
  ASoC: apq8096: remove auto rebinding
  ASoC: smd845: remove auto rebinding
  ASoC: core: remove support for card rebind using component framework

 include/sound/soc.h      |  7 ------
 sound/soc/qcom/apq8096.c |  2 --
 sound/soc/qcom/sdm845.c  |  2 --
 sound/soc/soc-core.c     | 62 ------------------------------------------------
 4 files changed, 73 deletions(-)

-- 
2.16.2
