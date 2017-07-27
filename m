From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFT v2 0/3] ASoC: samsung: s3c24xx: Fixes for error paths
Date: Thu, 27 Jul 2017 19:13:35 +0200
Message-ID: <20170727171338.13300-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Changes since v1:
1. Add patch 2/3.
2. Drop assignment of iis_cclk=iis_pclk to have balance with clk disables error
   and remove paths (pointed by Arvind).

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  ASoC: samsung: Fix possible double iounmap on s3c24xx driver probe
    failure
  ASoC: samsung: Add missing prepare for iis clock of s3c24xx
  ASoC: samsung: Add proper error paths to s3c24xx I2S driver

 sound/soc/samsung/s3c-i2s-v2.c  | 12 ++++++++++--
 sound/soc/samsung/s3c-i2s-v2.h  |  7 +++++++
 sound/soc/samsung/s3c2412-i2s.c | 13 +++++++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.11.0
