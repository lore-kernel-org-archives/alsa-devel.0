From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: axi-i2s: make both "rx" and "tx" optional" to the asoc tree
Date: Mon, 11 Mar 2019 17:23:16 +0000 (GMT)
Message-ID: <20190311172316.2C2DB1128896@debutante.sirena.org.uk>
References: <20190307214456.16445-2-luca@lucaceresoli.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307214456.16445-2-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>Mark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: axi-i2s: make both "rx" and "tx" optional

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From fa225400758dfc7ccddebf4d990f991a435f7921 Mon Sep 17 00:00:00 2001
From: Luca Ceresoli <luca@lucaceresoli.net>
Date: Thu, 7 Mar 2019 22:44:56 +0100
Subject: [PATCH] ASoC: axi-i2s: make both "rx" and "tx" optional

Both the capture and playback channels are optional in the axi_i2s IP
block. Document how to tell the driver which channels are
instantiated.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/adi,axi-i2s.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt b/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
index 4248b662deff..229ad1392cdc 100644
--- a/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
@@ -1,5 +1,8 @@
 ADI AXI-I2S controller
 
+The core can be generated with transmit (playback), only receive
+(capture) or both directions enabled.
+
 Required properties:
  - compatible : Must be "adi,axi-i2s-1.00.a"
  - reg : Must contain I2S core's registers location and length
@@ -9,8 +12,8 @@ Required properties:
  - clock-names : "axi" for the clock to the AXI interface, "ref" for the sample
    rate reference clock.
  - dmas: Pairs of phandle and specifier for the DMA channels that are used by
-   the core. The core expects two dma channels, one for transmit and one for
-   receive.
+   the core. The core expects two dma channels if both transmit and receive are
+   enabled, one channel otherwise.
  - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
 
 For more details on the 'dma', 'dma-names', 'clock' and 'clock-names' properties
-- 
2.20.1
