From: Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/2] Add DP dai-links to the rk3399-gru machine driver
Date: Mon,  5 Sep 2016 21:48:53 -0700
Message-ID: <1473137335-14541-1-git-send-email-zyw@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cychiang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Yao <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


Hi

This series patch is for the machine driver supporting for DP.

It base on the DP drvier patches[0] and hdmi-notify patches[1], they are both
in reviewing.

[0]
https://patchwork.kernel.org/patch/9315557/
https://patchwork.kernel.org/patch/9278077/

[1]
https://patchwork.kernel.org/patch/8887261/
https://patchwork.kernel.org/patch/8887251/


Chris Zhong (2):
  drm/rockchip: cdn-dp: support audio hot-plug
  ASoC: rockchip: Add DP dai-links to the rk3399-gru machine driver

 .../bindings/sound/rockchip,rk3399-gru-sound.txt   | 13 +++---
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |  4 ++
 sound/soc/rockchip/rk3399_gru_sound.c              | 48 ++++++++++++++++++++++
 3 files changed, 59 insertions(+), 6 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
