From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
Date: Fri, 24 Feb 2012 22:09:35 +0800
Message-ID: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6715C245DD
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 14:56:14 +0100 (CET)
Received: by pbcxa12 with SMTP id xa12so1045949pbc.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 05:56:12 -0800 (PST)
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

This is the third series towards reusing fsl_ssi driver on device tree
based IMX platforms.  It makes a few cleanups on existing PowerPC code
to ease the later addition of an IMX machine driver that works on
fsl_ssi.

Shawn Guo (6):
      ASoC: fsl: correct get_dma_channel parameter name
      ASoC: fsl: align mpc8610_hpcd with p1022_ds on getting codec node
      ASoC: Remove unnecessary -codec from cs4270 driver name
      ASoC: fsl: create fsl_utils to accommodate the common functions
      ASoC: fsl: use platform_device_id table to match p1022_ds device
      ASoC: fsl: check property 'compatible' for the machine name

 sound/soc/codecs/cs4270.c    |    2 +-
 sound/soc/fsl/Kconfig        |    5 +
 sound/soc/fsl/Makefile       |    2 +
 sound/soc/fsl/fsl_ssi.c      |    6 +-
 sound/soc/fsl/fsl_utils.c    |  153 ++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_utils.h    |   29 +++++++
 sound/soc/fsl/mpc8610_hpcd.c |  167 +++----------------------------------
 sound/soc/fsl/p1022_ds.c     |  185 ++++-------------------------------------
 sound/soc/pxa/raumfeld.c     |    2 +-
 9 files changed, 226 insertions(+), 325 deletions(-)
