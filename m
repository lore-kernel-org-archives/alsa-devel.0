From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v4 0/2] Add freescale S/PDIF CPU DAI and machine drivers
Date: Mon, 12 Aug 2013 20:01:08 +0800
Message-ID: <1376308870-14232-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: broonie@kernel.org, lars@metafoo.de, p.zabel@pengutronix.de
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, timur@tabi.org, rob.herring@calxeda.com
List-Id: alsa-devel@alsa-project.org

Changelog:
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

 .../devicetree/bindings/sound/fsl,spdif.txt        |  100 ++
 .../devicetree/bindings/sound/imx-audio-spdif.txt  |   29 +
 sound/soc/fsl/Kconfig                              |   14 +
 sound/soc/fsl/Makefile                             |    4 +
 sound/soc/fsl/fsl_spdif.c                          | 1350 ++++++++++++++++++++
 sound/soc/fsl/fsl_spdif.h                          |  223 ++++
 sound/soc/fsl/imx-spdif.c                          |  134 ++
 7 files changed, 1854 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
 create mode 100644 sound/soc/fsl/fsl_spdif.c
 create mode 100644 sound/soc/fsl/fsl_spdif.h
 create mode 100644 sound/soc/fsl/imx-spdif.c
