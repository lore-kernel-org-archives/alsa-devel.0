From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 0/3] ASoC: Add Freescale i.MX S/PDIF controller
	driver
Date: Wed, 31 Jul 2013 20:07:04 +0800
Message-ID: <cover.1375271745.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F5ED2615E7
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 13:57:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, timur@tabi.org
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com
List-Id: alsa-devel@alsa-project.org

* This series of patches add i.MX S/PDIF drivers, including CPU DAI, machine.
* It also add two missing sample rates support for spdif dummy codec drivers

Nicolin Chen (3):
  ASoC: codec: spdif: Add S20_3LE and S24_LE support for dummy codec
    drivers
  ASoC: fsl: Add S/PDIF CPU DAI driver
  ASoC: fsl: Add S/PDIF machine driver

 .../devicetree/bindings/sound/fsl,spdif.txt        |   63 +
 .../devicetree/bindings/sound/imx-audio-spdif.txt  |   29 +
 sound/soc/codecs/spdif_receiver.c                  |    2 +
 sound/soc/codecs/spdif_transmitter.c               |    5 +-
 sound/soc/fsl/Kconfig                              |   14 +
 sound/soc/fsl/Makefile                             |    4 +
 sound/soc/fsl/fsl_spdif.c                          | 1276 ++++++++++++++++++++
 sound/soc/fsl/fsl_spdif.h                          |  233 ++++
 sound/soc/fsl/imx-spdif.c                          |  134 ++
 9 files changed, 1758 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
 create mode 100644 sound/soc/fsl/fsl_spdif.c
 create mode 100644 sound/soc/fsl/fsl_spdif.h
 create mode 100644 sound/soc/fsl/imx-spdif.c
