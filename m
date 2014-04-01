From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 0/2] Add ipg clock control to sai driver
Date: Tue, 1 Apr 2014 19:52:51 +0800
Message-ID: <cover.1396352401.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: broonie@kernel.org, shawn.guo@linaro.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

This series of patches add ipg clock control to fsl_sai driver and updates
the vf610.dtsi accordingly.

@Shawn
I'm not sure if VF610 currently does full works with SAI audio function.
The PATCH-2 is based on broonie/for-next.

Nicolin Chen (2):
  ASoC: fsl_sai: Add clock control for SAI
  ARM: dts: Add ipg clock for sai2 on VF610 platform

 .../devicetree/bindings/sound/fsl-sai.txt          |  7 ++--
 arch/arm/boot/dts/vf610.dtsi                       |  4 +--
 sound/soc/fsl/fsl_sai.c                            | 37 ++++++++++++++++++++--
 sound/soc/fsl/fsl_sai.h                            |  2 ++
 4 files changed, 43 insertions(+), 7 deletions(-)

-- 
1.8.4


