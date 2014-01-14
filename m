From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 3/3] Binding: atmel-wm8904: add option to choose clock
Date: Tue, 14 Jan 2014 11:25:56 +0800
Message-ID: <1389669956-2304-4-git-send-email-voice.shen@atmel.com>
References: <1389669956-2304-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1389669956-2304-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@kernel.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Bo Shen <voice.shen@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Mark Brown <broonie@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add the option to choose clock output on which pin connect to SSC.
Default is on TK pin to SSC, add clk_from_rk_pin option, the clock
is on RK pin to SSC.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 Documentation/devicetree/bindings/sound/atmel-wm8904.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
index 8bbe50c..68a5c1a 100644
--- a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
+++ b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
@@ -33,6 +33,8 @@ Required properties:
 
 Optional properties:
   - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
+  - clk_from_rk_pin: according to hardware design, clk privide on rk pin
+    to ssc device
 
 Example:
 sound {
-- 
1.8.5.2

