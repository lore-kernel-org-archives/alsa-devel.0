From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 00/16] ASoC: fsl-ssi: Driver cleanup
Date: Sat, 15 Mar 2014 13:44:08 +0100
Message-ID: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

This new version of the cleanup is mainly a reordering of the patches. It moves
the regmap patch to the end of the series so none of the other patches depend
on it. This also fixes a bug I introduced in "Remove fsl_ssi_setup" which also
removed the switching between network and normal mode depending on the number
of channels. I reversed this code removal. Another new patch was added "Fix
i2s_mode variable setup" which fixes the i2s_mode assignment in set_dai_fmt().

Best regards,

Markus


Changes in v2:
 - Move "Use regmap" patch to the end of the series
 - Add normal/network mode switching code to again (previously removed in
   "Remove fsl_ssi_setup"
 - Add patch "Fix i2s_mode variable setup"


Markus Pargmann (16):
  ASoC: fsl-ssi: Remove fsl_ssi_setup
  ASoC: fsl-ssi: Fix i2s_mode variable setup
  ASoC: fsl-ssi: Move debugging to seperate file
  ASoC: fsl-ssi: Use dev_name for DAI driver struct
  ASoC: fsl-ssi: Move imx-specific probe to seperate function
  ASoC: fsl-ssi: Remove useless DMA code
  ASoC: fsl-ssi: baud clock error handling
  ASoC: fsl-ssi: Cleanup probe function
  ASoC: fsl-ssi: Remove unnecessary variables from ssi_private
  ASoC: fsl-ssi: reorder and document fsl_ssi_private
  ASoC: fsl-ssi: Fix register values when disabling
  ASoC: fsl-ssi: Only enable baudclk when used
  ASoC: fsl-ssi: Set default dai-fmts
  ASoC: fsl-ssi: Transmit enable synchronization
  ASoC: fsl-ssi: Update binding documentation
  ASoC: fsl-ssi: Use regmap

 .../devicetree/bindings/sound/fsl,ssi.txt          |   21 +-
 sound/soc/fsl/Kconfig                              |    1 +
 sound/soc/fsl/Makefile                             |    2 +
 sound/soc/fsl/fsl_ssi.c                            | 1173 +++++++++-----------
 sound/soc/fsl/fsl_ssi.h                            |  112 +-
 sound/soc/fsl/fsl_ssi_dbg.c                        |  163 +++
 6 files changed, 759 insertions(+), 713 deletions(-)
 create mode 100644 sound/soc/fsl/fsl_ssi_dbg.c

-- 
1.9.0
