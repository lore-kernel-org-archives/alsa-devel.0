From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v11 0/7] ASoC: fsl-ssi: ac97-slave support
Date: Mon, 19 Aug 2013 17:05:53 +0200
Message-ID: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id AAEA9264F0B
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 17:07:30 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi,

this series implements ac97-slave support for fsl-ssi and adds a simple generic
DT sound card.

Regards,

Markus

Changes in v11:
 - Dropped phycard specific sound patches
 - Added a generic simple DT sound card with support for ac97 using ac97-codec
 - Some new bugfix patches

Markus Pargmann (5):
      ASoC: imx-pcm-dma: Add missing include
      ASoC: core: Generic ac97 link reset functions
      ASoC: generic: simple DT sound card
      ASoC: fsl: Kconfig, visible config items for simple card
      ASoC: fsl-ssi: ac97-slave support

Michael Grzeschik (2):
      ASoC: fsl-ssi: imx-pcm-fiq bugfix
      ASoC: fsl: disable ssi irq for imx

Steffen Trumtrar (1):
      ASoC: fsl-ssi: add SSIEN errata work around

 .../devicetree/bindings/sound/fsl,ssi.txt          |   4 +
 .../bindings/sound/generic,simple-dt-card.txt      |  28 ++
 .../devicetree/bindings/sound/soc-ac97link.txt     |  28 ++
 include/sound/soc.h                                |   2 +
 sound/soc/fsl/Kconfig                              |  23 +-
 sound/soc/fsl/fsl_ssi.c                            | 369 ++++++++++++++++-----
 sound/soc/fsl/imx-pcm-dma.c                        |   1 +
 sound/soc/generic/Kconfig                          |   1 +
 sound/soc/generic/Makefile                         |   3 +-
 sound/soc/generic/simple-dt-card.c                 | 186 +++++++++++
 sound/soc/soc-core.c                               | 153 +++++++++
 11 files changed, 711 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/soc-ac97link.txt
 create mode 100644 sound/soc/generic/simple-dt-card.c
