From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 2/2] dt-bindings: ASoC: axi-i2s: make both "rx" and "tx" optional
Date: Thu,  7 Mar 2019 22:44:56 +0100
Message-ID: <20190307214456.16445-2-luca@lucaceresoli.net>
References: <20190307214456.16445-1-luca@lucaceresoli.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307214456.16445-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Both the capture and playback channels are optional in the axi_i2s IP
block. Document how to tell the driver which channels are
instantiated.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
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
2.17.1
