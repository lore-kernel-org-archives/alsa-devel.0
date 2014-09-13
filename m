From: Jianqun <jay.xu@rock-chips.com>
Subject: [PATCH 0/5] ASoC: rockchip-i2s: patches for rockchip
	i2s driver
Date: Sat, 13 Sep 2014 08:38:43 +0800
Message-ID: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vasmtpcom.263.net (va-smtp01.263.net [54.88.144.211])
 by alsa0.perex.cz (Postfix) with ESMTP id 8988C26109C
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 03:16:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: huangtao@rock-chips.com, cf@rock-chips.com, Jianqun <jay.xu@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

These patches to fix rockchip i2s driver bugs, also make driver codes
reasonable.
Tested on RK3288 board.

Jianqun (5):
  ASoC: rockchip-i2s: fix rockchip i2s defination more reasonable
  ASoC: rockchip-i2s: fix master mode set bit error
  ASoC: rockchip-i2s: add dma data to snd_soc_dai
  ASoC: rockchip-i2s: fix registers' property of rockchip i2s controller
  ASoC: rockchip-i2s: enable "hclk" for rockchip I2S controller

 sound/soc/rockchip/Kconfig        |  3 +--
 sound/soc/rockchip/Makefile       |  2 +-
 sound/soc/rockchip/rockchip_i2s.c | 41 ++++++++++++++++++++++++---------------
 3 files changed, 27 insertions(+), 19 deletions(-)

-- 
1.9.1
