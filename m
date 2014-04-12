From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v2 2/2] ASoC: cirrus: clps711x: Add bindings
	documentation for the CLPS711X DAI
Date: Sat, 12 Apr 2014 10:17:34 +0400
Message-ID: <1397283454-684-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.mail.ru (smtp1.mail.ru [94.100.176.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 52A372607B6
 for <alsa-devel@alsa-project.org>; Sat, 12 Apr 2014 08:17:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>
List-Id: alsa-devel@alsa-project.org

This patch adds the devicetree documentation for the Cirrus Logic
CLPS711X Digital Audio Interface (DAI).

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../bindings/sound/cirrus,clps711x-dai.txt           | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,clps711x-dai.txt

diff --git a/Documentation/devicetree/bindings/sound/cirrus,clps711x-dai.txt b/Documentation/devicetree/bindings/sound/cirrus,clps711x-dai.txt
new file mode 100644
index 0000000..fd37774
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,clps711x-dai.txt
@@ -0,0 +1,20 @@
+* Cirrus Logic CLPS711X Digital Audio Interface (DAI)
+
+Required properties:
+- compatible:  Shall contain "cirrus,clps711x-dai".
+- reg:         Should contain registers location and length.
+- clocks:      phandle + clock specifier pair of the CPU PLL reference
+               clock and (optionally) external MCLK reference clock.
+- clock-names: The clock should be named "pll" for CPU PLL and "mclk"
+               for external MCLK.
+- interrupts:  Should contain DAI interrupt number.
+
+Example:
+	dai: dai@80002000 {
+		#sound-dai-cells = <0>;
+		compatible = "cirrus,ep7312-dai", "cirrus,clps711x-dai";
+		reg = <0x80002000 0x604>;
+		clocks = <&clks 3>, <&clk12288>;
+		clock-names = "pll", "mclk";
+		interrupts = <32>;
+	};
-- 
1.8.3.2
