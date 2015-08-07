From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH v3 0/4] Add SPDIF support for rockchip
Date: Fri,  7 Aug 2015 13:44:10 +0200
Message-ID: <1438947854-3743-1-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 5193D26044D
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 13:44:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patchset adds support for the Rockchip SPDIF transceiver as present
on RK3066, RK3188 and RK3288 boards and enables it on a Radxa rock pro.
Tested on a Radxa Rock Pro board.

Changes in v3:
- Fix typos in commit message
- Resent patches to a more complete list of maintainers.

Changes in v2:
- Remove platform: module alias as it was unused
- Call MODULE_DEVICE_TABLE(of, ) right after the of match table
- use rk_spdif as a prefix consistenly throughout the driver
- Check return code of regmap_update and bubble it up
- Sort the spdif node properties
- Drop the 0x prefix from the node name
- Rename the spdif@ node to sound@

Sjoerd Simons (4):
  ASoC: dt-bindings: add rockchip tranceiver bindings
  ASoC: rockchip: Add rockchip SPDIF transceiver driver
  ARM: dts: rockchip: Add SPDIF transceiver for RK3188
  ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock

 .../devicetree/bindings/sound/rockchip-spdif.txt   |  41 +++
 arch/arm/boot/dts/rk3188-radxarock.dts             |  19 +
 arch/arm/boot/dts/rk3188.dtsi                      |  22 ++
 sound/soc/rockchip/Kconfig                         |   8 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_spdif.c                | 381 +++++++++++++++++++++
 sound/soc/rockchip/rockchip_spdif.h                |  63 ++++
 7 files changed, 536 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.txt
 create mode 100644 sound/soc/rockchip/rockchip_spdif.c
 create mode 100644 sound/soc/rockchip/rockchip_spdif.h

-- 
2.5.0
