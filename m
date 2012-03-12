From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v4] ASoC: add imx-sgtl5000 machine driver
	working with fsl_ssi
Date: Mon, 12 Mar 2012 19:58:47 +0800
Message-ID: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EF569103F24
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 12:58:49 +0100 (CET)
Received: by iakh37 with SMTP id h37so7438983iak.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 04:58:49 -0700 (PDT)
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

Changes since v3:
 * Change imx compatible to "fsl,imx21-ssi"
 * Leave locking issue as a FIXME for Timur to sort out separately

---
Shawn Guo (10):
      ASoC: fsl: separate SSI and DMA Kconfig options
      ASoC: imx: merge sound/soc/imx into sound/soc/fsl
      ASoC: fsl: rename imx-pcm Kconfig options and filename
      ASoC: fsl: create fsl_utils to accommodate the common functions
      ASoC: fsl: remove helper fsl_asoc_get_codec_dev_name
      ASoC: fsl: check property 'compatible' for the machine name
      ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
      ASoC: fsl: remove the fatal error checking on codec-handle
      ASoC: fsl: let fsl_ssi work with imx pcm and machine drivers
      ASoC: fsl: add imx-sgtl5000 machine driver

 .../bindings/sound/imx-audio-sgtl5000.txt          |   24 +++
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig   |    1 +
 arch/powerpc/configs/mpc85xx_defconfig             |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig         |    1 +
 sound/soc/Kconfig                                  |    1 -
 sound/soc/Makefile                                 |    1 -
 sound/soc/fsl/Kconfig                              |  124 ++++++++++++-
 sound/soc/fsl/Makefile                             |   29 +++-
 sound/soc/{imx => fsl}/eukrea-tlv320.c             |    2 +-
 sound/soc/fsl/fsl_ssi.c                            |  140 +++++++++++----
 sound/soc/fsl/fsl_utils.c                          |   91 ++++++++++
 sound/soc/fsl/fsl_utils.h                          |   26 +++
 sound/soc/{imx => fsl}/imx-audmux.c                |    0
 sound/soc/{imx => fsl}/imx-audmux.h                |    0
 .../{imx/imx-pcm-dma-mx2.c => fsl/imx-pcm-dma.c}   |    0
 sound/soc/{imx => fsl}/imx-pcm-fiq.c               |    0
 sound/soc/{imx => fsl}/imx-pcm.c                   |    0
 sound/soc/{imx => fsl}/imx-pcm.h                   |    0
 sound/soc/fsl/imx-sgtl5000.c                       |  177 ++++++++++++++++++
 sound/soc/{imx => fsl}/imx-ssi.c                   |    2 +-
 sound/soc/{imx => fsl}/imx-ssi.h                   |    0
 sound/soc/fsl/mpc8610_hpcd.c                       |  168 ++----------------
 sound/soc/{imx => fsl}/mx27vis-aic32x4.c           |    0
 sound/soc/fsl/p1022_ds.c                           |  190 ++------------------
 sound/soc/{imx => fsl}/phycore-ac97.c              |    0
 sound/soc/{imx => fsl}/wm1133-ev1.c                |    0
 sound/soc/imx/Kconfig                              |   79 --------
 sound/soc/imx/Makefile                             |   22 ---
 28 files changed, 604 insertions(+), 475 deletions(-)
