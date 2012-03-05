From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine driver
	working with fsl_ssi
Date: Mon,  5 Mar 2012 22:30:48 +0800
Message-ID: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 421491041C9
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 15:17:01 +0100 (CET)
Received: by iakh37 with SMTP id h37so5940768iak.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 06:17:00 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Changes since v1:
 * Address comments from Mark, Timur, and Sascha (Thanks for review).
 * Drop patches that have been applied by Mark.

Richard Zhao (2):
      ARM: imx: convert audmux to a platform driver
      ASoC: fsl: add dt support for imx-audmux

Shawn Guo (15):
      ASoC: imx: move eukrea audmux call into ASoC machine driver
      ASoC: imx: move phycore audmux call into ASoC machine driver
      ARM: imx: merge audmux-v1 and audmux-v2
      ASoC: imx: move audmux driver into sound/soc/imx
      ASoC: imx: rename audmux prefix mxc to imx
      ASoC: imx: separate imx-pcm bits from imx-ssi driver
      ASoC: imx: add an explicit Kconfig option for imx-ssi driver
      ASoC: fsl: separate SSI and DMA Kconfig options
      ASoC: imx: merge sound/soc/imx into sound/soc/fsl
      ASoC: fsl: create fsl_utils to accommodate the common functions
      ASoC: fsl: check property 'compatible' for the machine name
      ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
      ASoC: fsl: remove the fatal error checking on codec-handle
      ASoC: fsl: let fsl_ssi work with imx pcm and machine drivers
      ASoC: fsl: add imx-sgtl5000 machine driver

 .../bindings/sound/imx-audio-sgtl5000.txt          |   24 +++
 .../devicetree/bindings/sound/imx-audmux.txt       |   13 ++
 arch/arm/mach-imx/Kconfig                          |    6 -
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c       |   20 --
 arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c       |    1 -
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |   17 --
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |   17 --
 arch/arm/mach-imx/mach-pca100.c                    |   13 --
 arch/arm/mach-imx/mach-pcm043.c                    |   13 --
 arch/arm/mach-imx/mm-imx21.c                       |    6 +
 arch/arm/mach-imx/mm-imx25.c                       |    7 +
 arch/arm/mach-imx/mm-imx27.c                       |    7 +
 arch/arm/mach-imx/mm-imx3.c                        |   13 ++
 arch/arm/mach-imx/mm-imx5.c                        |   22 +++
 arch/arm/plat-mxc/Kconfig                          |    6 -
 arch/arm/plat-mxc/Makefile                         |    2 -
 arch/arm/plat-mxc/audmux-v1.c                      |   64 -------
 arch/arm/plat-mxc/include/mach/audmux.h            |   60 -------
 sound/soc/Kconfig                                  |    1 -
 sound/soc/Makefile                                 |    1 -
 sound/soc/fsl/Kconfig                              |  124 +++++++++++++-
 sound/soc/fsl/Makefile                             |   29 +++-
 sound/soc/{imx => fsl}/eukrea-tlv320.c             |   42 ++++-
 sound/soc/fsl/fsl_ssi.c                            |  139 ++++++++++++----
 sound/soc/fsl/fsl_utils.c                          |  135 ++++++++++++++
 sound/soc/fsl/fsl_utils.h                          |   27 +++
 .../audmux-v2.c => sound/soc/fsl/imx-audmux.c      |  185 +++++++++++++++-----
 sound/soc/fsl/imx-audmux.h                         |   60 +++++++
 sound/soc/{imx => fsl}/imx-pcm-dma-mx2.c           |    2 +-
 sound/soc/{imx => fsl}/imx-pcm-fiq.c               |    0
 sound/soc/fsl/imx-pcm.c                            |  105 +++++++++++
 sound/soc/fsl/imx-pcm.h                            |   32 ++++
 sound/soc/fsl/imx-sgtl5000.c                       |  181 +++++++++++++++++++
 sound/soc/{imx => fsl}/imx-ssi.c                   |   90 +----------
 sound/soc/{imx => fsl}/imx-ssi.h                   |   16 +--
 sound/soc/fsl/mpc8610_hpcd.c                       |  159 ++----------------
 sound/soc/{imx => fsl}/mx27vis-aic32x4.c           |   20 +-
 sound/soc/fsl/p1022_ds.c                           |  181 ++------------------
 sound/soc/{imx => fsl}/phycore-ac97.c              |   27 +++-
 sound/soc/{imx => fsl}/wm1133-ev1.c                |   25 ++--
 sound/soc/imx/Kconfig                              |   60 -------
 sound/soc/imx/Makefile                             |   19 --
 42 files changed, 1140 insertions(+), 831 deletions(-)
