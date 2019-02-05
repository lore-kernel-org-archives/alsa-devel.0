From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/6] dt-bindings: sound: Document jz4725b-codec
	bindings
Date: Tue,  5 Feb 2019 00:11:04 -0300
Message-ID: <20190205031108.26171-2-paul@crapouillou.net>
References: <20190205031108.26171-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from crapouillou.net (outils.crapouillou.net [89.234.176.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 02DF526743A
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 04:11:41 +0100 (CET)
In-Reply-To: <20190205031108.26171-1-paul@crapouillou.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Paul Cercueil <paul@crapouillou.net>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add documentation about how to probe the jz4725b-codec driver from
devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/sound/ingenic,jz4725b-codec.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
new file mode 100644
index 000000000000..05adc0d47b13
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
@@ -0,0 +1,20 @@
+Ingenic JZ4725B codec controller
+
+Required properties:
+- compatible : "ingenic,jz4725b-codec"
+- reg : codec registers location and length
+- clocks : phandle to the AIC clock.
+- clock-names: must be set to "aic".
+- #sound-dai-cells: Must be set to 0.
+
+Example:
+
+codec: audio-codec@100200a4 {
+	compatible = "ingenic,jz4725b-codec";
+	reg = <0x100200a4 0x8>;
+
+	#sound-dai-cells = <0>;
+
+	clocks = <&cgu JZ4725B_CLK_AIC>;
+	clock-names = "aic";
+};
-- 
2.11.0
