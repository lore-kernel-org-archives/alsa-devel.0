From: Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 0/2] ASoC: rockchip: i2s: add support for
	grabbing output clock to codec
Date: Wed, 19 Nov 2014 11:06:03 +0800
Message-ID: <1416366365-4632-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from irl-smtp01.263.net (irl-smtp01.263.net [54.76.167.174])
 by alsa0.perex.cz (Postfix) with ESMTP id EE9D22604E9
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 04:06:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com
Cc: Jianqun Xu <jay.xu@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Reference to Chapter 3 Clock & Reset Unit (CRU) of RK3288 TRM, i2s0_clkout has
two source clock, XIN24M_DIV2 for 12M and clk_i2s0 for more kinds of
frequencies, I2S0(i2s_clk) has only single source clock clk_i2s0.

i2s0_clkout: generate to output to outside of chip, generally for codec
I2S0(i2s_clk): generate for i2s controller inside of chip

Jianqun Xu (2):
  ASoC: rockchip-i2s: dt: add i2s_clkout to list of clocks
  ASoC: rockchip: i2s: add support for grabbing output clock to codec

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt |  5 +++--
 sound/soc/rockchip/rockchip_i2s.c                        | 11 +++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
1.9.1
