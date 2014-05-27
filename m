From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v5 0/8] ASoC: fsl-ssi: Driver cleanup
Date: Tue, 27 May 2014 10:24:17 +0200
Message-ID: <1401179065-31195-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id CEB0C265521
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 10:24:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

These are the remaining patches of this fsl-ssi cleanup series.

v5 adds the possibility to set the bitclock frequency using .set_dai_sysclk as
suggested. If it is not explicitly set, the bitclock is calculated using the
hw_params. I also added the missing signed-off-by tags to the patches.

Best Regards,

Markus


Markus Pargmann (4):
  ASoC: fsl-ssi: make fsl,mode property optional
  ASoC: fsl-ssi: Fix baudclock handling
  ASoC: fsl-ssi: reorder and document fsl_ssi_private
  ASoC: fsl-ssi: Use regmap

Sascha Hauer (4):
  ASoC: fsl-ssi: introduce SoC specific data
  ASoC: fsl-ssi: set bitclock in master mode from hw_params
  ASoC: fsl-ssi: remove unnecessary spinlock
  ASoC: fsl-ssi: Set framerate divider correctly for i2s master mode

 sound/soc/fsl/Kconfig   |   1 +
 sound/soc/fsl/fsl_ssi.c | 574 ++++++++++++++++++++++++++++--------------------
 sound/soc/fsl/fsl_ssi.h |  50 ++---
 3 files changed, 360 insertions(+), 265 deletions(-)

-- 
2.0.0.rc2
