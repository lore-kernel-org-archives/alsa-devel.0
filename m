From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 0/3] ASoC: fsl_sai: Fix some issues in fsl_sai_trigger()
Date: Wed, 23 Jul 2014 19:23:37 +0800
Message-ID: <cover.1406113865.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, b42378@freescale.com, b02247@freescale.com
List-Id: alsa-devel@alsa-project.org

The series of patches focus on issue fix inside fsl_sai_trigger().

Nicolin Chen (3):
  ASoC: fsl_sai: Reduce race condition during TE/RE enabling
  ASoC: fsl_sai: Don't reset FIFO until TE/RE bit is unset
  ASoC: fsl_sai: Improve enable flow in fsl_sai_trigger()

 sound/soc/fsl/fsl_sai.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

-- 
1.8.4
