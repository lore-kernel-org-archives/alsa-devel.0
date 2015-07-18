From: Xing Zheng <zhengxing@rock-chips.com>
Subject: [PATCH v2 0/2] Add codec machine driver for rockchip
	platform
Date: Sat, 18 Jul 2015 13:08:42 +0800
Message-ID: <1437196124-32655-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 559B3260429
 for <alsa-devel@alsa-project.org>; Sat, 18 Jul 2015 07:15:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, zhengxing <zhengxing@rock-chips.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: zhengxing <zhengxing@rock-chips.com>


Hi,
  The simple-card is not common at present, soc maybe need own machine
driver for jack detection.
  Add drivers for two families of rockchip-bases chromebooks. These
machine drives don't use simplecard because we need custom jack
detection plumbing.

- use ts3a227e for ext jack detection with max98090
- call rt5645_set_jack_detect function via rt5645 codec driver

Thanks.


Changes in v2:
Signed-off-by: zhengxing <zhengxing@rock-chips.com>

zhengxing (2):
  ASoC: rockchip: Add machine driver for max98090 codec
  ASoC: rockchip: Add machine driver for rt5645/rt5650 codec

 .../bindings/sound/rockchip-max98090.txt           |   19 ++
 .../devicetree/bindings/sound/rockchip-rt5645.txt  |   17 ++
 sound/soc/rockchip/Kconfig                         |   19 ++
 sound/soc/rockchip/Makefile                        |    6 +
 sound/soc/rockchip/rockchip_max98090.c             |  247 ++++++++++++++++++++
 sound/soc/rockchip/rockchip_rt5645.c               |  236 +++++++++++++++++++
 6 files changed, 544 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-max98090.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-rt5645.txt
 create mode 100644 sound/soc/rockchip/rockchip_max98090.c
 create mode 100644 sound/soc/rockchip/rockchip_rt5645.c

-- 
1.7.9.5
