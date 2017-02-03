From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v8 0/4] Add support for es8388 and hdmi audio
	on the rock2
Date: Fri,  3 Feb 2017 15:37:56 +0100
Message-ID: <20170203143800.23859-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 62270260083
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 15:38:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Romain Perier <romain.perier@collabora.com>
List-Id: alsa-devel@alsa-project.org

This set of patches adds a machine driver for rk3288-based boards that have
the built-in HDMI audio and a generic analog output. It also adds slave mode
to the es8328 driver that currently only supported the master mode. Then, it
adds the required DT definitions to link rockchip-i2s to the es8388 analog
output and to hdmi audio.

This work is based on the initial work that was done by Sjoerd Simons
<sjoerd.simons@collabora.co.uk> with some improvements, changes and more
commits.

Changes in v8:
 - Fixed unmet direct dependencies for SND_SOC_IMX_ES8328 caused by patch 2/4
Changes in v7:
 - Added patch 2/4
 - No longer select ES8328_I2C for RK3288_HDMI_ANALOG
 - Fixed DT regulator names in the DT for the Rock2
 - Splitted pins for the headphone in the DT for the Rock2
Changes in v6:
 - Fixed bad error handling for gpio in rk3288_analog_hdmi.c
 - Removed message duplication in rk_hw_params(), in rk3288_analog_hdmi.c
 - Removed patch 1/4 (from the previous series), as it has been merged
Changes in v5:
 - Fixed coding style issue in patch 2/4 (the switch case).
 - Moved the code for the master mode and the slave mode into the switch case for patch 2/4
 - Fixed error handling for patch 3/4
Changes in v4:
 - Add support for multi codecs in the asoc machine driver, so the driver
   matches the hw architecture (analog and hdmi audio are connected on
   the same i2s line)
 - Renamed the driver to rk3288-hdmi-analog.c and changed its
   documentation
 - Add built-in support for hdmi audio in this driver
 - Add support for the property 'rockchip,routing'

Changes in v3:
 - Cosmetic changes in rockchip_es8388.c
 - Added missing email to MODULE_AUTHOR in rockchip_es8388.c
Changes in v2:
 - Fixed wrong use of the data structure i2c_device_id
 - Fixed wrong dependencies for SND_SOC_ROCKCHIP_ES8388

Romain Perier (4):
  ASoC: es8328: Add support for slave mode
  ASoC: Allow to select ES8328_I2C and ES8328_SPI directly
  ASoC: rockchip: Add machine driver for RK3288 boards that use
    analog/HDMI
  arm: dts: Add support for ES8388 to the Radxa Rock 2

 .../bindings/sound/rockchip,rk3288-hdmi-analog.txt |  36 +++
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |   2 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts          |  42 +++
 sound/soc/codecs/Kconfig                           |   8 +-
 sound/soc/codecs/es8328.c                          |  20 +-
 sound/soc/fsl/Kconfig                              |   2 +-
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rk3288_hdmi_analog.c            | 299 +++++++++++++++++++++
 9 files changed, 408 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
 create mode 100644 sound/soc/rockchip/rk3288_hdmi_analog.c

-- 
2.9.3
