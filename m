From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v7 0/2] Add freescale S/PDIF CPU DAI and
	machine drivers
Date: Mon, 19 Aug 2013 16:35:20 +0800
Message-ID: <cover.1376901081.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D21A26179B
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 10:25:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lars@metafoo.de, p.zabel@pengutronix.de, s.hauer@pengutronix.de
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, swarren@wwwdotorg.org, festevam@gmail.com, timur@tabi.org, rob.herring@calxeda.com, tomasz.figa@gmail.com, R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Changelog:
v6->v7:
 * Removed extra comma in array.
 * Revised some comments.
 * Added some dev_err().
 * Check the return value of soft reset.
 * Use bitrev8() instead of extra reverse_bits().
 * Use cache_bypass as default for regmap.
v5->v6:
 * Sorted out rxtx clk source in DT binding.
 * Use devm_xxxx() functions.
 * Use platform_get_resource() instead.
v4->v5:
 * Dropped rx/tx-clksrc-names DT bindings.
 * Use standard clock binding instead to pass the clock source list.
 * Update the compatible list by using "imx35", the first SoC that has spdif.
v3->v4:
 * Use regmap for CPU DAI driver.
 * Use individual clock source for 32KHz, 44KHz, 48KHz playback.
 * Determine clock source configuration from 'clocks' entry.
 * Added imx53 to compatible list, merged imx6q and imx6dl in the list.
 * Improve the algorism of reverse_bits().
 * Dropped the unneeded clk_put().
v2->v3:
 * Removed a wrong tag from the commit of patch-1.
v1->v2:
 * Dropped one applied patch for spdif dummy codec drivers.
 * Use generic DMA DT binding.
 * Let spdif controller driver calculate the clock div.
 * Added one optional clock source for spdif tx.
 * Reivsed documentation accordingly.

Nicolin Chen (2):
  ASoC: fsl: Add S/PDIF CPU DAI driver
  ASoC: fsl: Add S/PDIF machine driver

 .../devicetree/bindings/sound/fsl,spdif.txt        |   56 +
 .../devicetree/bindings/sound/imx-audio-spdif.txt  |   29 +
 sound/soc/fsl/Kconfig                              |   14 +
 sound/soc/fsl/Makefile                             |    4 +
 sound/soc/fsl/fsl_spdif.c                          | 1277 ++++++++++++++++++++
 sound/soc/fsl/fsl_spdif.h                          |  224 ++++
 sound/soc/fsl/imx-spdif.c                          |  134 ++
 7 files changed, 1738 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
 create mode 100644 sound/soc/fsl/fsl_spdif.c
 create mode 100644 sound/soc/fsl/fsl_spdif.h
 create mode 100644 sound/soc/fsl/imx-spdif.c
