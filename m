From: shengjiu.wang@nxp.com
Subject: [PATCH V2 0/2] recover the channel swap after xrun
Date: Wed,  3 Jul 2019 14:42:03 +0800
Message-ID: <cover.1562136119.git.shengjiu.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

recover the channel swap after xrun

Shengjiu Wang (2):
  ASoC: fsl_esai: Wrap some operations to be functions
  ASoC: fsl_esai: recover the channel swap after xrun

 sound/soc/fsl/fsl_esai.c | 267 ++++++++++++++++++++++++++++-----------
 1 file changed, 194 insertions(+), 73 deletions(-)

Changes in v2
- add one patch for wrap operations to functions.
- fix some coding style issue


-- 
2.21.0
