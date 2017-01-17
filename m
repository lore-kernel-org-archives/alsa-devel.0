From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v3 0/4] Add support for es8388 on the rock2
Date: Tue, 17 Jan 2017 09:17:01 +0100
Message-ID: <20170117081705.14107-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id D8FA7266802
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 09:17:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Romain Perier <romain.perier@collabora.com>
List-Id: alsa-devel@alsa-project.org

This set of patches adds a machine driver for rockchip boards that use
ES8388 codecs. It also adds slave mode to the es8328 driver that
currently only supported the master mode. Then, it adds the required DT
definitions to link rockchip-i2s to the es8388 analog output.

This work is based on the initial work that was done by Sjoerd Simons
<sjoerd.simons@collabora.co.uk> with some improvements, changes and more
commits.

Changes in v3:
 - Cosmetic changes in rockchip_es8388.c
 - Added missing email to MODULE_AUTHOR in rockchip_es8388.c
Changes in v2:
 - Fixed wrong use of the data structure i2c_device_id
 - Fixed wrong dependencies for SND_SOC_ROCKCHIP_ES8388

Romain Perier (4):
  ASoC: es8328-i2c: Add compatible for ES8388
  ASoC: es8328: Add support for slave mode
  ASoC: rockchip: Add machine driver for ES8388 codecs
  arm: dts: Add support for ES8388 to the Radxa Rock 2

 Documentation/devicetree/bindings/sound/es8328.txt |   2 +-
 .../devicetree/bindings/sound/rockchip-es8388.txt  |  28 +++
 arch/arm/boot/dts/rk3288-rock2-square.dts          |  37 +++
 sound/soc/codecs/es8328-i2c.c                      |   2 +
 sound/soc/codecs/es8328.c                          |  28 ++-
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_es8388.c               | 269 +++++++++++++++++++++
 8 files changed, 370 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-es8388.txt
 create mode 100644 sound/soc/rockchip/rockchip_es8388.c

-- 
2.9.3
