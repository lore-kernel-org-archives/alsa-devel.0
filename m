From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/2] Add support for i.MX8QM
Date: Wed, 14 Aug 2019 11:29:09 +0300
Message-ID: <20190814082911.665-1-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, festevam@gmail.com, devicetree@vger.kernel.org, robh+dt@kernel.org, shengjiu.wang@nxp.com, viorel.suman@nxp.com, linux-imx@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

i.MX8QM SOC integrates 6 SAI instances. Register map is similar with
i.MX6 series.

Daniel Baluta (2):
  ASoC: fsl_sai: Add support for imx8qm
  ASoC: dt-bindings: Introduce compatible string for imx8qm

 Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 ++-
 sound/soc/fsl/fsl_sai.c                             | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.17.1
