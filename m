From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 0/3] at91/ssc: fixes on ASoC tree for 3.8
Date: Mon, 17 Dec 2012 12:23:23 +0100
Message-ID: <cover.1355742707.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, voice.shen@atmel.com
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

This series goes on top of current Linus' git tree and fixes an error that
we have while compiling DTBs for AT91:
ERROR (phandle_references): Reference to non-existent node or label
"pinctrl_ssc0_tx"

ERROR: Input tree has errors, aborting (use -f to force output)
make[3]: *** [arch/arm/boot/dts/at91sam9g20ek.dtb] Error 2

I have included pending material that is dealing with SSC and pinctrl. The
pinctrl part can be merged more easily now that the big pinctrl update for AT91
has been merged upstream.
I have also included a typo patch that you have already taken as 315656b (ASoC:
atmel-ssc: change disable to disable in dts node) in your topic/atmel branch
but that was not described properly.

If you find it easier, I can provide you a git tree for this material: just
tell me...

Thanks for your help, best regards,


Bo Shen (3):
  ARM: at91/dts: fix typo in SSC status property
  ARM: at91/dts: add pinctrl support for SSC peripheral
  ASoC: atmel-ssc: add pinctrl selection to driver

 arch/arm/boot/dts/at91sam9260.dtsi | 18 +++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi | 40 ++++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/at91sam9g45.dtsi | 40 ++++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/at91sam9n12.dtsi | 26 +++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  | 32 +++++++++++++++++++++++-------
 drivers/misc/atmel-ssc.c           |  8 ++++++++
 6 files changed, 153 insertions(+), 11 deletions(-)

-- 
1.8.0

