From: Yakir Yang <ykk@rock-chips.com>
Subject: [RFC PATCH 0/3]
Date: Tue, 10 Feb 2015 22:16:31 +0800
Message-ID: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Russell King <rmk+kernel@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Rob Clark <robdclark@gmail.com>, Mark Yao <mark.yao@rock-chips.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sean Cross <xobs@kosagi.com>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, djkurtz@chromium.org, mmind00@googlemail.com, dianders@chromium.org, marcheu@chromium.org, linux-rockchip@lists.infradead.org, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

RK3288 hdmi eye-diagram test would fail when pixel clock is 148.5MHz,
and single-ended test would failed when display mode is 74.25MHz.
- Fix some code style, leave space for next patches.
- For hdmi eye-diagram test, we turn on the Transmitter Trailer-B and
  improve slopeboost to 25%-30% decrease.
- For hdmi single-ended test, we set CKLVL & TXLVL to 17 when pixel
  clock is 74.25MHz, keep CKLVL & TXLVL to 13 when pixel clock is 148.5MHz.


Yakir Yang (3):
  drm: bridge/dw_hdmi: fixed codec style
  drm: bridge/dw_hdmi_rockchip: improve hdmi eye-diagram test
  drm: bridge/dw_hdmi: improve hdmi single-end test

 drivers/gpu/drm/bridge/dw_hdmi.c            |   20 ++++++++++----------
 drivers/gpu/drm/imx/dw_hdmi-imx.c           |   12 ++++++------
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |   14 +++++++-------
 include/drm/bridge/dw_hdmi.h                |    5 +++--
 4 files changed, 26 insertions(+), 25 deletions(-)

-- 
1.7.9.5
