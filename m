From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH v2 3/3] Binding: atmel-wm8904: add option to choose clock
Date: Mon, 27 Jan 2014 14:55:26 +0800
Message-ID: <1390805726-1841-4-git-send-email-voice.shen@atmel.com>
References: <1390805726-1841-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1390805726-1841-1-git-send-email-voice.shen@atmel.com>
Sender: linux-doc-owner@vger.kernel.org
To: broonie@kernel.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Bo Shen <voice.shen@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Mark Brown <broonie@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add the option to choose clock on which pin input to SSC (as slave).
Default is on TK pin to SSC, add "atmel,clk-from-rk-pin" option to
specify the clock is on RK pin to SSC.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v2:
  - using "-" replace "_" in binding document

 Documentation/devicetree/bindings/sound/atmel-wm8904.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
index 8bbe50c..2d86e2b 100644
--- a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
+++ b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
@@ -33,6 +33,12 @@ Required properties:
 
 Optional properties:
   - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
+  - atmel,clk-from-rk-pin: bool property.
+     - When SSC works in slave mode, according to the hardware design, the
+       clock can get from TK pin, and also can get from RK pin. So, add
+       this parameter to choose where the clock from.
+     - By default the clock is from TK pin, if the clock from RK pin, this
+       property is needed.
 
 Example:
 sound {
-- 
1.8.5.2

