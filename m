From: Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 0/3] ASoC: rockchip: i2s: fix watermark to 16 and maxburst to 4
Date: Wed, 24 Dec 2014 17:36:59 +0800
Message-ID: <1419413822-11539-1-git-send-email-jay.xu@rock-chips.com>
References: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1419325709-15374-1-git-send-email-jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

To make Bus DMA works more efficiency, DMA may work in burst mode,
   we set the watermark of transmit and receive reach to 16 bits.

Jianqun Xu (3):
  ASoC: rockchip: i2s: fix error defination of transmit data level
  ASoC: rockchip: i2s: set TDL and RDL to 16 samples
  ASoC: rockchip: i2s: fix maxburst of dma data to 4

 sound/soc/rockchip/rockchip_i2s.c | 8 ++++++--
 sound/soc/rockchip/rockchip_i2s.h | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
changes since v1:
- modify commit message suggested by dgreid
- add patch to fix maxburst
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
