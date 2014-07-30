From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 0/4] ASoC: fsl: Add stream names to CPU DAI drivers for DPCM
Date: Wed, 30 Jul 2014 11:10:25 +0800
Message-ID: <cover.1406688048.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org, b42378@freescale.com, b02247@freescale.com
List-Id: alsa-devel@alsa-project.org

DPCM needs extra dapm routes in the machine driver to route audio
between Front-End and Back-End. In order to differ the stream names
in the route map from CODECs, we here add specific stream names to
all Freescale ASoC CPU DAI drivers so that we can implement ASRC via
DPCM to each of them.

Document for DPCM: ./Documentation/sound/alsa/soc/DPCM.txt

Nicolin Chen (4):
  ASoC: fsl_esai: Add stream names for DPCM usage
  ASoC: fsl_sai: Add stream names for DPCM usage
  ASoC: fsl_spdif: Add stream names for DPCM usage
  ASoC: fsl_ssi: Add stream names for DPCM usage

 sound/soc/fsl/fsl_esai.c  | 2 ++
 sound/soc/fsl/fsl_sai.c   | 2 ++
 sound/soc/fsl/fsl_spdif.c | 2 ++
 sound/soc/fsl/fsl_ssi.c   | 2 ++
 4 files changed, 8 insertions(+)

-- 
1.8.4
