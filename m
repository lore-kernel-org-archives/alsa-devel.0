From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/3] ASoC: SOF: initial support for i.MX8
Date: Wed, 21 Aug 2019 11:47:27 -0500
Message-ID: <20190821164730.7385-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, devicetree@vger.kernel.org, Xiubo.Lee@gmail.com, shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com, robh+dt@kernel.org, linux-imx@nxp.com, viorel.suman@nxp.com, festevam@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The reviews for these patches took place already on mailing lists and
GitHub, and the code is already integrated in the SOF tree (along with
dependencies already accepted in the i.MX tree)

Changes since v1:
As agreed with Daniel and Mark, this v2 series includes the DT
bindings (Fixed 'compatible' typo in examples)
The SAI/ESAI support was merged separately so dropped from this set.

Daniel Baluta (3):
  dt-bindings: dsp: fsl: Add DSP core binding support
  ASoC: SOF: Add OF DSP device support
  ASoC: SOF: imx: Add i.MX8 HW support

 .../devicetree/bindings/dsp/fsl,dsp.yaml      |  88 ++++
 sound/soc/sof/Kconfig                         |  11 +
 sound/soc/sof/Makefile                        |   4 +
 sound/soc/sof/imx/Kconfig                     |  22 +
 sound/soc/sof/imx/Makefile                    |   4 +
 sound/soc/sof/imx/imx8.c                      | 394 ++++++++++++++++++
 sound/soc/sof/sof-of-dev.c                    | 143 +++++++
 7 files changed, 666 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
 create mode 100644 sound/soc/sof/imx/Kconfig
 create mode 100644 sound/soc/sof/imx/Makefile
 create mode 100644 sound/soc/sof/imx/imx8.c
 create mode 100644 sound/soc/sof/sof-of-dev.c

-- 
2.20.1
