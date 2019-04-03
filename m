From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 0/12] Patches to update pdm for rockchip socs
Date: Wed,  3 Apr 2019 21:40:44 +0800
Message-ID: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org, Sugar Zhang <sugar.zhang@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

These patches to add support pdm for rk322x/rk1808/rk3308/px30 socs
and fix some issues.


Sugar Zhang (12):
  ASoC: rockchip: pdm: fix regmap_ops hang issue
  ASoC: rockchip: pdm: using left justified store mode
  ASoC: rockchip: pdm: add default regs
  ASoC: rockchip: pdm: optimize clear logic
  ASoC: rockchip: pdm: change dma burst to 8
  ASoC: rockchip: pdm: fixup pdm fractional div
  dt-bindings: sound: rockchip: add compatible for rk3308/px30
  ASoC: rockchip: pdm: add compatible for rk1808
  dt-bindings: sound: add compatible for rk1808
  ASoC: rockchip: pdm: adjust waterlevel in frame unit
  ASoC: rockchip: pdm: Mark RXFIFO_DATA as volatile and precious
  ASoC: rockchip: pdm: Correct PDM_CTRL0 reg value

 .../devicetree/bindings/sound/rockchip,pdm.txt     |   5 +
 sound/soc/rockchip/rockchip_pdm.c                  | 209 ++++++++++++++++-----
 sound/soc/rockchip/rockchip_pdm.h                  |  12 ++
 3 files changed, 180 insertions(+), 46 deletions(-)

-- 
2.7.4
