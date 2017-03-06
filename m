From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 3/3] ASoC: dio2125: add dt-bindings
Date: Mon,  6 Mar 2017 18:44:51 +0100
Message-ID: <20170306174451.24406-4-jbrunet@baylibre.com>
References: <20170306174451.24406-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 19956266DD6
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 18:45:09 +0100 (CET)
Received: by mail-wm0-f46.google.com with SMTP id t193so71144855wmt.1
 for <alsa-devel@alsa-project.org>; Mon, 06 Mar 2017 09:45:09 -0800 (PST)
In-Reply-To: <20170306174451.24406-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/dioo,dio2125.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/dioo,dio2125.txt

diff --git a/Documentation/devicetree/bindings/sound/dioo,dio2125.txt b/Documentation/devicetree/bindings/sound/dioo,dio2125.txt
new file mode 100644
index 000000000000..63dbfe0f11d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dioo,dio2125.txt
@@ -0,0 +1,12 @@
+DIO2125 Audio Driver
+
+Required properties:
+- compatible : "dioo,dio2125"
+- enable-gpios : the gpio connected to the enable pin of the dio2125
+
+Example:
+
+amp: analog-amplifier {
+	compatible = "dioo,dio2125";
+	enable-gpios = <&gpio GPIOH_3 0>;
+};
-- 
2.9.3
