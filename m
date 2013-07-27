From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v10 0/7] ASoC: fsl-ssi: ac97-slave support
Date: Sat, 27 Jul 2013 13:31:49 +0200
Message-ID: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id BB454260308
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2013 13:34:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi,

this series implements ac97-slave support for fsl-ssi and phycore ac97 DT
support.

Since v9 there were a lot of changes. I dropped the board specific ac97-link
reset functions and added generic functions to soc-core. It uses devicetree
parsed pinctrl and gpios. The audmux setup was removed from phycore-ac97-dt.
The initial setup can now be defined in DT.

Regards,

Markus


Markus Pargmann (7):
      ASoC: core: Generic ac97 link reset functions
      ASoC: codec: wm9712 simple DT bindings
      ASoC: imx-audmux: Read default configuration from devicetree
      ASoC: fsl-ssi: Add support for imx-pcm-fiq
      ASoC: fsl-ssi: Use generic DMA bindings if possible
      ASoC: fsl-ssi: ac97-slave support
      ASoC: Add phycore-ac97-dt driver

 .../devicetree/bindings/sound/fsl,ssi.txt          |  12 +
 .../devicetree/bindings/sound/imx-audmux.txt       |   9 +
 .../bindings/sound/phytec,phycore-ac97.txt         |  16 +
 .../devicetree/bindings/sound/soc-ac97link.txt     |  28 ++
 Documentation/devicetree/bindings/sound/wm9712.txt |  10 +
 include/sound/soc.h                                |   2 +
 sound/soc/codecs/wm9712.c                          |   9 +
 sound/soc/fsl/Kconfig                              |  15 +-
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/fsl_ssi.c                            | 431 +++++++++++++++++----
 sound/soc/fsl/imx-audmux.c                         |  62 +++
 sound/soc/fsl/phycore-ac97-dt.c                    | 124 ++++++
 sound/soc/fsl/phycore-ac97.c                       |  13 +-
 sound/soc/soc-core.c                               | 153 ++++++++
 14 files changed, 789 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
 create mode 100644 Documentation/devicetree/bindings/sound/soc-ac97link.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm9712.txt
 create mode 100644 sound/soc/fsl/phycore-ac97-dt.c
