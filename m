From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/6] Add device tree support for mxs audio
Date: Thu, 10 May 2012 16:42:07 +0800
Message-ID: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id B33EB2436D
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 10:42:34 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so2153807pbb.38
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 01:42:33 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, Dong Aisheng <dong.aisheng@linaro.org>
List-Id: alsa-devel@alsa-project.org

This series adds device tree probe for mxs-saif driver and mxs-sgtl5000
ASoC machine driver, and is tested on imx28-evk board.

It's based on sound, clkdev, mxs pinctrl and DT branches, and probably
easier to have it go through arm-soc with sound/for-3.5 pulled in as
dependency.

Shawn Guo (6):
      ASoC: mxs: add __devinit for mxs_saif_probe
      ASoC: mxs: use devm_clk_get for mxs_saif_probe
      ASoC: mxs: mxs-pcm does not need to be a plaform_driver
      ASoC: mxs: add device tree support for mxs-saif
      ASoC: mxs: add device tree support for mxs-sgtl5000
      ARM: dts: enable audio support for imx28-evk

 .../bindings/sound/mxs-audio-sgtl5000.txt          |   17 +++
 .../devicetree/bindings/sound/mxs-saif.txt         |   36 ++++++
 arch/arm/boot/dts/imx28-evk.dts                    |   41 +++++++
 arch/arm/boot/dts/imx28.dtsi                       |   23 ++++
 sound/soc/mxs/mxs-pcm.c                            |   24 +---
 sound/soc/mxs/mxs-pcm.h                            |    3 +
 sound/soc/mxs/mxs-saif.c                           |  119 +++++++++++---------
 sound/soc/mxs/mxs-saif.h                           |    1 -
 sound/soc/mxs/mxs-sgtl5000.c                       |   61 ++++++++++-
 9 files changed, 253 insertions(+), 72 deletions(-)
