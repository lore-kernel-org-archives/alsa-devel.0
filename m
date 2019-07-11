From: shengjiu.wang@nxp.com
Subject: [PATCH V4 0/2] recover the channel swap after xrun
Date: Thu, 11 Jul 2019 18:49:44 +0800
Message-ID: <cover.1562842206.git.shengjiu.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

recover the channel swap after xrun

Shengjiu Wang (2):
  ASoC: fsl_esai: Wrap some operations to be functions
  ASoC: fsl_esai: recover the channel swap after xrun

 sound/soc/fsl/fsl_esai.c | 266 ++++++++++++++++++++++++++++-----------
 1 file changed, 193 insertions(+), 73 deletions(-)

Changes in v4
-add more comments and remove read saisr

Changes in V3
- update code sytle.

Changes in v2
- add one patch for wrap operations to functions.
- fix some coding style issue

-- 
2.21.0
