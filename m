From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 0/2] ASoC: fsl_sai: Two bug fixes for fsl_sai driver
Date: Thu, 17 Jul 2014 21:21:36 +0800
Message-ID: <cover.1405603108.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, b02247@freescale.com, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org

Nicolin Chen (2):
  ASoC: fsl_sai: Reset FIFOs after disabling TE/RE
  ASoC: fsl_sai: Fix incorrect register writing in fsl_sai_isr()

 sound/soc/fsl/fsl_sai.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
1.8.4
