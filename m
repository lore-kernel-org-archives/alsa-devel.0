From: Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/2] rockchip: i2s: patches to add optional clock output from
Date: Tue,  2 Dec 2014 22:49:24 +0800
Message-ID: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The clock output from rockchip SoCs' CRU to chip outside is from the same source
as hclk which is for i2s controller. We make it optional because some audio
codec outside not need the master clock from SoC but from other clock source.

Jianqun Xu (2):
  ASoC: rockchip-i2s: dt: add an optional property "i2s_clk_out"
  ASoC: rockchip: i2s: add support for grabbing output clock to codec

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt |  8 ++++++--
 sound/soc/rockchip/rockchip_i2s.c                        | 11 +++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
