From: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 0/3] Improve eye-diagram & single-ended test for rk3288 hdmi
Date: Mon,  9 Mar 2015 12:36:12 +0800
Message-ID: <1425875772-21252-1-git-send-email-ykk@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Yao <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Ben Zhang <benzh-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mmind00-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


RK3288 hdmi eye-diagram test would fail when pixel clock is 148.5MHz,
and single-ended test would failed when display mode is 74.25MHz.

To fix such problems, we make those patch set:
- Fix some code style, leave space for next patches.
- For hdmi eye-diagram test, we turn on the Transmitter Trailer-B and
  improve slopeboost to 10%-20% decrease.
- For hdmi single-ended test, we set CKLVL to 18 and & TXLVL to 19 when
  pixel clock is 74.25MHz, keep CKLVL & TXLVL to 13 when pixel clock is
  148.5MHz.

Changes in v2:
- set slopeboost back to 10%-20%, then rasing/falling time would pass.
- For pixel clock less than 74.25MHz, set txlvl to 19 and set cklvl to 18.

Yakir Yang (3):
  drm: bridge/dw_hdmi: fixed codec style
  drm: bridge/dw_hdmi_rockchip: improve hdmi eye-diagram test
  drm: bridge/dw_hdmi: improve hdmi single-end test

 drivers/gpu/drm/bridge/dw_hdmi.c            | 20 ++++++++++----------
 drivers/gpu/drm/imx/dw_hdmi-imx.c           | 12 ++++++------
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 14 +++++++-------
 include/drm/bridge/dw_hdmi.h                |  5 +++--
 4 files changed, 26 insertions(+), 25 deletions(-)

-- 
2.1.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
