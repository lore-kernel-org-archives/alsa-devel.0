From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] ASoC: tfa9879: clean up bindings
Date: Mon, 11 Dec 2017 15:26:14 +0100
Message-ID: <20171211142615.11440-2-peda@axentia.se>
References: <20171211142615.11440-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00105.outbound.protection.outlook.com [40.107.0.105])
 by alsa0.perex.cz (Postfix) with ESMTP id F3B93266E93
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 15:26:31 +0100 (CET)
In-Reply-To: <20171211142615.11440-1-peda@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

Fix a couple of nitpicks:

- list #sound-dai-cells as a required property.
- The chip supports full speed I2C; don't indicate standard mode only.
- status = "okay" is just noise.
- The chip is an amplifier, not a codec.
- consistently indent with tabs.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/sound/tfa9879.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tfa9879.txt b/Documentation/devicetree/bindings/sound/tfa9879.txt
index 23ba522d9e2b..1620e6848436 100644
--- a/Documentation/devicetree/bindings/sound/tfa9879.txt
+++ b/Documentation/devicetree/bindings/sound/tfa9879.txt
@@ -6,18 +6,18 @@ Required properties:
 
 - reg : the I2C address of the device
 
+- #sound-dai-cells : must be 0.
+
 Example:
 
 &i2c1 {
-	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
 
-	codec: tfa9879@6c {
+	amp: amp@6c {
 		#sound-dai-cells = <0>;
 		compatible = "nxp,tfa9879";
 		reg = <0x6c>;
-        };
+	};
 };
 
-- 
2.11.0
