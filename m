From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 0/8] ASoC: fsl: Refine DT binding documents for more readability
Date: Tue,  7 Oct 2014 12:29:03 -0700
Message-ID: <cover.1412708790.git.nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

This series of patches simply add indentations and blank lines to each DT
binding documents of Freescale ASoC drivers so as to make them more clear
and readable.

@Mark Brown
  Not sure if they are okay to get applied through your tree.
  Otherwise, I might need to change these subjects and send
  them to DT maillist only. Thank you.

Nicolin Chen (8):
  ASoC: fsl_esai: Add indentation for binding doc to increase
    readability
  ASoC: fsl_spdif: Add indentation for binding doc to increase
    readability
  ASoC: fsl_sai: Add indentation for binding doc to increase readability
  ASoC: eukrea-tlv320: Add indentation for binding doc to increase
    readability
  ASoC: imx-audmux: Add indentation for binding doc to increase
    readability
  ASoC: imx-sgtl5000: Add indentation for binding doc to increase
    readability
  ASoC: imx-spdif: Add indentation for binding doc to increase
    readability
  ASoC: imx-wm8962: Add indentation for binding doc to increase
    readability

 .../devicetree/bindings/sound/eukrea-tlv320.txt    | 15 +++--
 .../devicetree/bindings/sound/fsl,esai.txt         | 44 ++++++++-------
 .../devicetree/bindings/sound/fsl,spdif.txt        | 37 ++++++------
 .../devicetree/bindings/sound/fsl-sai.txt          | 66 ++++++++++++++--------
 .../bindings/sound/imx-audio-sgtl5000.txt          | 61 +++++++++++---------
 .../devicetree/bindings/sound/imx-audio-spdif.txt  | 22 ++++----
 .../devicetree/bindings/sound/imx-audio-wm8962.txt | 45 ++++++++-------
 .../devicetree/bindings/sound/imx-audmux.txt       | 22 +++++---
 8 files changed, 178 insertions(+), 134 deletions(-)

-- 
1.9.1
