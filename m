From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 0/2] ASoC: fsl: Use dynamic slot width for ESAI.
Date: Fri, 24 Oct 2014 16:48:10 -0700
Message-ID: <cover.1414193668.git.nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, b02247@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This series of patches add the support of dynamic slot width for
ESAI driver. To do this, the PATCH-1 removes the fixed width. In
order not to break those platforms that use fixed width, there
comes the PATCH-2 to apply an override of slot_width.

@Shengjiu,
Will you be available to test this series on Sabre Auto for both
Master and Slave cases? I'd like to wait for your Test-by. Thanks.

Nicolin Chen (2):
  ASoC: fsl_esai: Use dynamic slot width as default
  ASoC: fsl-asoc-card: Add slot_width setting for cpu-dai

 sound/soc/fsl/fsl-asoc-card.c | 12 ++++++++++++
 sound/soc/fsl/fsl_esai.c      | 12 +++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

-- 
1.9.1
