From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V3 0/3] add spba clock for fsl audio IP
Date: Tue, 24 Nov 2015 15:03:27 +0800
Message-ID: <cover.1448348336.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

add spba clock for fsl audio IP

Changes in V3
- update the comments for clock description.

Shengjiu Wang (3):
  ASoC: fsl_esai: spba clock is needed by esai device
  ASoC: fsl_spdif: spba clk is needed by spdif device
  ASoC: fsl_asrc: spba clock is needed by asrc device

 Documentation/devicetree/bindings/sound/fsl,asrc.txt  |  5 +++++
 Documentation/devicetree/bindings/sound/fsl,esai.txt  |  5 +++++
 Documentation/devicetree/bindings/sound/fsl,spdif.txt |  5 +++++
 sound/soc/fsl/fsl_asrc.c                              | 10 ++++++++++
 sound/soc/fsl/fsl_asrc.h                              |  2 ++
 sound/soc/fsl/fsl_esai.c                              | 13 +++++++++++++
 sound/soc/fsl/fsl_spdif.c                             | 15 +++++++++++++++
 7 files changed, 55 insertions(+)

-- 
1.9.1
