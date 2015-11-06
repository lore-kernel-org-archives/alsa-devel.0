From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v3 0/3] ASoC: rockchip: i2s: add 8 channels capture support and share lrck
Date: Fri,  6 Nov 2015 09:38:08 +0800
Message-ID: <1446773891-32174-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, heiko@sntech.de
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

support 8 channels capture support.
share lrck tx/rx when symmetric_rates enabled.

Sugar Zhang (3):
  ASoC: rockchip: i2s: add 8 channels capture support
  Documentation: DT bindings: rockchip-i2s: add capture property
  ASoC: rockchip: i2s: share tx/rx lrck when symmetric_rates enabled

 .../devicetree/bindings/sound/rockchip-i2s.txt     |  5 +++
 sound/soc/rockchip/rockchip_i2s.c                  | 48 +++++++++++++++++++++-
 sound/soc/rockchip/rockchip_i2s.h                  | 16 ++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.3.6
