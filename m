From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 0/4] ASoC: Convert to use regmap framework's endianness method.
Date: Mon, 25 Aug 2014 11:30:58 +0800
Message-ID: <1408937462-18727-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, nicoleotsuka@gmail.com, timur@tabi.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: galak@codeaurora.org, mark.rutland@arm.com, robh+dt@kernel.org, pawel.moll@arm.com, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Changes in V3:
- Delete 'ASoC: fsl-sai: rename big_endian_data to is_msb_first.' patch.


Changes in V2:
- Modified the regmap config to const type.
- Added ASRC patch.
- Followed Rutland's advice.




Xiubo Li (4):
  ASoC: fsl-asrc: Convert to use regmap framework's endianness method.
  ASoC: fsl-esai: Convert to use regmap framework's endianness method.
  ASoC: fsl-spdif: Convert to use regmap framework's endianness method.
  ASoC: fsl-sai: Convert to use regmap framework's endianness method.

 Documentation/devicetree/bindings/sound/fsl-sai.txt | 7 +++----
 sound/soc/fsl/fsl_asrc.c                            | 6 +-----
 sound/soc/fsl/fsl_esai.c                            | 5 +----
 sound/soc/fsl/fsl_sai.c                             | 6 +-----
 sound/soc/fsl/fsl_sai.h                             | 1 -
 sound/soc/fsl/fsl_spdif.c                           | 5 +----
 6 files changed, 7 insertions(+), 23 deletions(-)

-- 
1.8.5
