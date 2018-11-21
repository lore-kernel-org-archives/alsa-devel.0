From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v8 0/7] Add support for audiocodec in Allwinner
	A64
Date: Tue, 20 Nov 2018 21:17:45 -0800
Message-ID: <20181121051752.18387-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by alsa0.perex.cz (Postfix) with ESMTP id D7176267936
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 06:19:12 +0100 (CET)
Received: by mail-pl1-f195.google.com with SMTP id b22-v6so3712325pls.7
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 21:19:12 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

v2: - Use simple-amplifier for speaker amp on Pinebook
    - Rename sun50i-a64-i2s to sun50i-a64-codec-i2s to preserve compatible
      string for other 3 I2S modules in A64 in case if there's any
      incompatibility with H3
v3: - renamed sunxi-adda-pr-regmap to sun8i-adda-pr-regmap
    - use ilog2() to calculate reg value for LRCK div instead of using a
      table
v4: - dts: don't use 'Mic' and 'Headset Mic' widgets from sun8i-codec,
      define our board-level widgets instead.
v5: - collect all the tags
v6: - driver patches has been merged through ASoC tree
    - rebase onto 4.20-rc1
    - Drop 'Speaker' from routes on sopine and pine64, they don't have
      speaker.
v7: - drop 'Mic' and 'Headset Mic' from dtsi
    - move AIF1 Slot 0 ADC to ADC route to sun8i-codec
    - drop BIAS routes for Pine64 and SoPine
v8  - drop merged patches
    - add regulator property for simple amplifier, make enable-gpio
      optional
    - add regulator to speaker amp, introduce headphone amp


Vasily Khoruzhick (7):
  ASoC: dt-bindings: add regulator property to simple amplifier
  ASoC: simple-amplifier: add VCC regulator widget
  ASoC: dt-bindings: make enable-gpio optional for simple amplifier
  ASoC: simple-amplifier: make enable-gpio optional
  arm64: dts: allwinner: a64: add nodes necessary for analog sound
    support
  arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine
  arm64: dts: allwinner: a64: enable sound on Pinebook

 .../bindings/sound/simple-amplifier.txt       |  5 ++
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 35 ++++++++++++
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 53 ++++++++++++++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 35 ++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 54 +++++++++++++++++++
 sound/soc/codecs/simple-amplifier.c           |  7 ++-
 6 files changed, 188 insertions(+), 1 deletion(-)

-- 
2.19.1
