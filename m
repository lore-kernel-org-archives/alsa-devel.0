From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 1/3] ASoC: es7134: update DT binding with
	new compatible and supplies
Date: Tue,  3 Jul 2018 17:05:58 +0200
Message-ID: <20180703150600.17697-2-jbrunet@baylibre.com>
References: <20180703150600.17697-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 47E1A2673CB
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 17:06:07 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so2682417wmc.1
 for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2018 08:06:07 -0700 (PDT)
In-Reply-To: <20180703150600.17697-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Update the documentation to add support for the es7154 and
optional power supplies phandles.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/everest,es7134.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es7134.txt b/Documentation/devicetree/bindings/sound/everest,es7134.txt
index 5495a3cb8b7b..091666069bde 100644
--- a/Documentation/devicetree/bindings/sound/everest,es7134.txt
+++ b/Documentation/devicetree/bindings/sound/everest,es7134.txt
@@ -1,10 +1,15 @@
 ES7134 i2s DA converter
 
 Required properties:
-- compatible : "everest,es7134" or "everest,es7144"
+- compatible : "everest,es7134" or
+               "everest,es7144" or
+	       "everest,es7154"
+- VDD-supply : regulator phandle for the VDD supply
+- PVDD-supply: regulator phandle for the PVDD supply for the es7154
 
 Example:
 
 i2s_codec: external-codec {
 	compatible = "everest,es7134";
+	VDD-supply = <&vcc_5v>;
 };
-- 
2.14.4
