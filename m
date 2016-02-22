From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 0/2] patches to add support for rockchip rt5640 card
Date: Mon, 22 Feb 2016 15:56:53 +0800
Message-ID: <1456127815-68575-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, heiko@sntech.de
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org, Oder Chiou <oder_chiou@realtek.com>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bard Liao <bardliao@realtek.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

add default values for i2s registers from TRM.
rt5640: add master clock handing.


Sugar Zhang (2):
  ASoC: rockchip: i2s: add default values for registers
  ASoC: rt5640: add master clock handling for rt5640

 Documentation/devicetree/bindings/sound/rt5640.txt |  3 +++
 sound/soc/codecs/rt5640.c                          | 31 ++++++++++++++++++++++
 sound/soc/codecs/rt5640.h                          |  2 ++
 sound/soc/rockchip/rockchip_i2s.c                  | 10 +++++++
 4 files changed, 46 insertions(+)

-- 
1.9.1
