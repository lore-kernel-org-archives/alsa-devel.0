From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 0/3] Enhance imx-wm8962 machine driver
Date: Fri, 6 Dec 2013 17:47:41 +0800
Message-ID: <cover.1386322845.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Although there's no direct relationship between any of these three patches,
I recommend to apply them in order so as to circumvent merging conflicts.

Nicolin Chen (3):
  ASoC: fsl: imx-wm8962: Don't update bias_level in machine driver
  ASoC: fsl: imx-wm8962: Grant hw_params/free() permission to control
    FLL
  ASoC: fsl: imx-wm8962: Add headphone and microphone jack plugin/out
    detection

 .../devicetree/bindings/sound/imx-audio-wm8962.txt |   8 +
 Documentation/devicetree/bindings/sound/wm8962.txt |   8 +
 sound/soc/fsl/imx-wm8962.c                         | 361 ++++++++++++++++++---
 3 files changed, 326 insertions(+), 51 deletions(-)

-- 
1.8.4
