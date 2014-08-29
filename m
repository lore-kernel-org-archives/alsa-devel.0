From: Jianqun <jay.xu@rock-chips.com>
Subject: [PATCH 0/2] rockchip-i2s: add power setting for I2S controller and fix some critical bugs
Date: Fri, 29 Aug 2014 15:07:04 -0700
Message-ID: <1409350027-17604-1-git-send-email-jay.xu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, yongjun_wei@trendmicro.com.cn, heiko@sntech.de, dianders@chromium.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Jianqun <jay.xu@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Add optional power setting for i2s controller found on rk3066, rk3168 and rk3288
processors from rockchip, should according to hardware design.

Default setting for I2S controller is powered by 3.3V, there needs this patch if
it's powered by 1.8V by hardware design.

Jianqun (2):
  rockchip-i2s: dt: add grf requested properties to set power of I2S controller
  rockchip-i2s: add power setting for I2S controller, also fix some bugs

 .../devicetree/bindings/sound/rockchip-i2s.txt     |  6 +-
 sound/soc/rockchip/rockchip_i2s.c                  | 93 +++++++++++++---------
 sound/soc/rockchip/rockchip_i2s.h                  | 13 +--
 3 files changed, 68 insertions(+), 44 deletions(-)

-- 
1.8.3.2
