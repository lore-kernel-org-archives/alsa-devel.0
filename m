From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/4] ASoC: merge imx into fsl
Date: Thu, 23 Feb 2012 22:48:35 +0800
Message-ID: <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4331F24491
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 15:35:18 +0100 (CET)
Received: by dady9 with SMTP id y9so1438842dad.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 06:35:15 -0800 (PST)
In-Reply-To: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This is the second step towards reusing fsl_ssi driver on device tree
based IMX platforms.  The series merges sound/soc/imx into sound/soc/fsl
and makes fsl_ssi driver compilable on ARM/IMX.

Compile-tested for PowerPC.

Shawn Guo (4):
      ASoC: imx: add an explicit Kconfig option for imx-ssi driver
      ASoC: fsl: separate SSI and DMA Kconfig options
      ASoC: imx: merge sound/soc/imx into sound/soc/fsl
      ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX

 sound/soc/Makefile                       |    1 -
 sound/soc/fsl/Kconfig                    |   99 ++++++++++++++++++++++++++++--
 sound/soc/fsl/Makefile                   |   22 ++++++-
 sound/soc/{imx => fsl}/eukrea-tlv320.c   |    2 +-
 sound/soc/fsl/fsl_ssi.c                  |   75 ++++++++++++++---------
 sound/soc/{imx => fsl}/imx-pcm-dma-mx2.c |    0
 sound/soc/{imx => fsl}/imx-pcm-fiq.c     |    0
 sound/soc/{imx => fsl}/imx-pcm.c         |    0
 sound/soc/{imx => fsl}/imx-pcm.h         |    0
 sound/soc/{imx => fsl}/imx-ssi.c         |    2 +-
 sound/soc/{imx => fsl}/imx-ssi.h         |    0
 sound/soc/{imx => fsl}/mx27vis-aic32x4.c |    0
 sound/soc/{imx => fsl}/phycore-ac97.c    |    0
 sound/soc/{imx => fsl}/wm1133-ev1.c      |    0
 sound/soc/imx/Kconfig                    |   64 -------------------
 sound/soc/imx/Makefile                   |   19 ------
 17 files changed, 162 insertions(+), 123 deletions(-)
