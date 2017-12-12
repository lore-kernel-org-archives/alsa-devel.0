From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 0/4] ARM: sun8i: a83t: Add support for I2S and
	I2C
Date: Tue, 12 Dec 2017 16:11:44 +0800
Message-ID: <20171212081148.9194-1-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wens.csie.org (mirror2.csie.ntu.edu.tw [140.112.30.76])
 by alsa0.perex.cz (Postfix) with ESMTP id 626DA267137
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 09:12:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi everyone,

This series adds support for I2S and I2C on the Allwinner A83T SoC.
The I2S controllers are similar to the ones found on the A31. However
the TX FIFO and interrupt status registers were swapped around. This
seems to be a recurring theme for the audio related hardware blocks.

Patch 1 adds support for the A83T variant with a compatible string
and associated quirks structure.

Patch 2 adds device nodes and default pinmux settings for the I2S
controllers.

Patch 3 adds device nodes and default pinmux settings for the I2C
controllers.

Patch 4 is an example of a PCM5122 codec tied to I2C2 and I2S1 over
the GPIO header of the Banana Pi M3. This patch should not be merged.

Please have a look.

Regards
ChenYu


Chen-Yu Tsai (4):
  ASoC: sun4i-i2s: Add support for A83T
  ARM: dts: sun8i: a83t: Add I2S controller device nodes
  ARM: dts: sun8i: a83t: Add I2C device nodes and pinmux settings
  [DO NOT MERGE] ARM: dts: sun8i: a83t: bpi-m3: Enable PCM5122 codec
    with I2S1

 .../devicetree/bindings/sound/sun4i-i2s.txt        |  2 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       | 33 ++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 99 ++++++++++++++++++++++
 sound/soc/sunxi/sun4i-i2s.c                        | 21 +++++
 4 files changed, 155 insertions(+)

-- 
2.15.0
