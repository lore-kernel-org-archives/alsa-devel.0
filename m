From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 3/5] ASoC: es7134: update DT binding with new compatible and supplies
Date: Fri, 29 Jun 2018 17:09:22 +0200
Message-ID: <20180629150924.18197-4-jbrunet@baylibre.com>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180629150924.18197-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Update the documentation to add support for the es7154 and
optional power supplies phandles.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/everest,es7134.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es7134.txt b/Documentation/devicetree/bindings/sound/everest,es7134.txt
index 5495a3cb8b7b..c6bcdc5bded8 100644
--- a/Documentation/devicetree/bindings/sound/everest,es7134.txt
+++ b/Documentation/devicetree/bindings/sound/everest,es7134.txt
@@ -1,7 +1,13 @@
 ES7134 i2s DA converter
 
 Required properties:
-- compatible : "everest,es7134" or "everest,es7144"
+- compatible : "everest,es7134" or
+               "everest,es7144" or
+	       "everest,es7154"
+
+Optional properties:
+- VDD-supply: regulator phandle for the VDD supply
+- AVDD-supply: regulator phandle for the AVDD supply
 
 Example:
 
-- 
2.14.4
