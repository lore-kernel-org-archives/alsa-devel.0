From: Shunqian Zheng <zhengsq@rock-chips.com>
Subject: [PATCH v1 0/4] Audio Codec Driver of RK3036 SoC
Date: Tue, 13 Oct 2015 09:01:05 +0800
Message-ID: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, benzh@chromium.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, ZhengShunQian <zhengsq@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

=46rom: ZhengShunQian <zhengsq@rock-chips.com>

Base on the other seris of RK3036 clk patches, which is not landed yet,
this patches add the RK3036 SoC codec driver.

Rockchip RK3036 SoC integrated with an Inno audio codec. It supports
the following features:
o. 24bit DAC
o. Support 16=CE=A9 to 32=CE=A9 headphone output and speaker output
o. Support Mono, Stereo channel
o. Sampling rate of 8/12/16/24/32/44.1/48/96KHz

While there are some features like dapm and s2r are still WIP,
I would like to send these patches now and get some feedback.

Thank you for your review.

ZhengShunQian (4):
  ASoC: codec: Inno codec driver for RK3036 SoC
  ASoC: RK3036: Add binding doc of inno-rk3036 codec driver
  ASoC: Add codec machine driver for RK3036
  ASoC: RK3036: Add binding doc for audio machine driver

 .../devicetree/bindings/sound/inno-rk3036.txt      |  20 +
 .../devicetree/bindings/sound/rockchip-rk3036.txt  |  14 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/inno_rk3036.c                     | 439 +++++++++++++=
++++++++
 sound/soc/codecs/inno_rk3036.h                     | 308 +++++++++++++=
++
 sound/soc/rockchip/Kconfig                         |  10 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_rk3036.c               | 147 +++++++
 9 files changed, 946 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/inno-rk3036=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-rk=
3036.txt
 create mode 100644 sound/soc/codecs/inno_rk3036.c
 create mode 100644 sound/soc/codecs/inno_rk3036.h
 create mode 100644 sound/soc/rockchip/rockchip_rk3036.c

--=20
1.9.1
