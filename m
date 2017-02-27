From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/2] ASoC: es7134: add dt-bindings for the
	es7134 dac
Date: Mon, 27 Feb 2017 16:47:24 +0100
Message-ID: <20170227154724.13724-3-jbrunet@baylibre.com>
References: <20170227154724.13724-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B812267153
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 16:47:38 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id v77so65901430wmv.0
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 07:47:38 -0800 (PST)
In-Reply-To: <20170227154724.13724-1-jbrunet@baylibre.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/everest,es7134.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7134.txt

diff --git a/Documentation/devicetree/bindings/sound/everest,es7134.txt b/Documentation/devicetree/bindings/sound/everest,es7134.txt
new file mode 100644
index 000000000000..5495a3cb8b7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es7134.txt
@@ -0,0 +1,10 @@
+ES7134 i2s DA converter
+
+Required properties:
+- compatible : "everest,es7134" or "everest,es7144"
+
+Example:
+
+i2s_codec: external-codec {
+	compatible = "everest,es7134";
+};
-- 
2.9.3
