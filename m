From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 0/8] ARM: at91: sama5d3: enable sound support
Date: Mon, 17 Mar 2014 17:45:33 +0800
Message-ID: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id B8AD0260799
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 10:47:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, nicolas.ferre@atmel.com
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>, Russell King <linux@arm.linux.org.uk>, linux-doc@vger.kernel.org, Boris BREZILLON <b.brezillon@overkiz.com>, Takashi Iwai <tiwai@suse.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

This patch add sound support on sama5d3xek board.

This patch series based on the following patch set:
  clk: at91: better support for the PCKs
  http://comments.gmane.org/gmane.linux.kernel/1664477


Bo Shen (5):
  ARM: at91: sama5d3: add DMA property for SSC devices
  ARM: at91: sama5d3: disable sound by default
  ARM: at91: sama5d3: correct the sound compatible string
  ARM: at91: sama5d3: add the missing property
  ARM: at91: sama5d3: clock for ssc from rk pin

Boris BREZILLON (3):
  ASoC: atmel: support CCF based clks
  ASoC: atmel: document clock properties of the wm8904 driver
  ARM: at91/dt: add clock properties to the wm8904 codec node

 .../devicetree/bindings/sound/atmel-wm8904.txt     |  2 ++
 arch/arm/boot/dts/sama5d3.dtsi                     |  6 ++++++
 arch/arm/boot/dts/sama5d3xmb.dtsi                  | 11 +++++++++-
 sound/soc/atmel/atmel_wm8904.c                     | 25 +++++++++++-----------
 4 files changed, 31 insertions(+), 13 deletions(-)

-- 
1.8.5.2
