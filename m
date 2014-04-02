From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH v2 0/2] ASoC: fsl_sai: Add bus clock and mclks with clock controls
Date: Wed, 2 Apr 2014 18:10:18 +0800
Message-ID: <cover.1396432924.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: broonie@kernel.org, shawn.guo@linaro.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

This series of patches add clock controls to fsl_sai driver and updates
the vf610.dtsi accordingly.

Changelog
v2:
 * Appended two extra mclks to the driver since SAI actually has three.
 * Renamed clock name to 'bus' and 'mclk' according to the reference manual.

Nicolin Chen (2):
  ASoC: fsl_sai: Add clock controls for SAI
  ARM: dts: Append clock bindings for sai2 on VF610 platform

 .../devicetree/bindings/sound/fsl-sai.txt          |  8 ++--
 arch/arm/boot/dts/vf610.dtsi                       |  6 ++-
 sound/soc/fsl/fsl_sai.c                            | 50 ++++++++++++++++++++--
 sound/soc/fsl/fsl_sai.h                            |  4 ++
 4 files changed, 59 insertions(+), 9 deletions(-)

-- 
1.8.4


