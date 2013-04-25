From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/5] ASoC: fsl: imx-pcm driver cleanup
Date: Thu, 25 Apr 2013 11:18:45 +0800
Message-ID: <1366859930-1232-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 by alsa0.perex.cz (Postfix) with ESMTP id CE47A265CDC
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 05:18:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

The series removes the use of imx-pcm-audio/imx-fiq-pcm-audio platform
device, and deletes imx-pcm driver by moving the functions needed by
imx-pcm-fiq driver into imx-pcm-fiq.c.  This can be done because
imx-pcm-dma has moved to generic dmaengine pcm driver and does not use
any helper from imx-pcm driver now.

Shawn Guo (5):
  ASoC: fsl: remove use of imx-pcm-audio from fsl_ssi
  ASoC: fsl: remove use of imx-pcm-audio from imx-ssi
  ASoC: fsl: create function imx_pcm_fiq_exit()
  ASoC: fsl: remove use of imx-fiq-pcm-audio from imx-ssi
  ASoC: fsl: remove imx-pcm driver

 sound/soc/fsl/Kconfig           |    5 --
 sound/soc/fsl/Makefile          |   11 +--
 sound/soc/fsl/eukrea-tlv320.c   |    2 +-
 sound/soc/fsl/fsl_ssi.c         |   13 ++--
 sound/soc/fsl/imx-mc13783.c     |    2 +-
 sound/soc/fsl/imx-pcm-dma.c     |    2 +
 sound/soc/fsl/imx-pcm-fiq.c     |   92 +++++++++++++++++++++++++
 sound/soc/fsl/imx-pcm.c         |  145 ---------------------------------------
 sound/soc/fsl/imx-pcm.h         |   10 +--
 sound/soc/fsl/imx-sgtl5000.c    |    2 +-
 sound/soc/fsl/imx-ssi.c         |   44 +++---------
 sound/soc/fsl/imx-ssi.h         |    3 -
 sound/soc/fsl/mx27vis-aic32x4.c |    2 +-
 sound/soc/fsl/phycore-ac97.c    |    2 +-
 sound/soc/fsl/wm1133-ev1.c      |    2 +-
 15 files changed, 122 insertions(+), 215 deletions(-)
 delete mode 100644 sound/soc/fsl/imx-pcm.c

-- 
1.7.9.5
