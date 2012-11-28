From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-abe-twl6040: Use "ti,
	jack-detection" DT property as boolean
Date: Wed, 28 Nov 2012 11:35:43 +0100
Message-ID: <1354098943-16185-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id AAC5E2615FC
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 11:35:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Handle the jack detection inforamtion as bool from devicetree.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt | 4 ++--
 sound/soc/omap/omap-abe-twl6040.c                            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt b/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
index 65dec87..fd40c85 100644
--- a/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
+++ b/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
@@ -12,7 +12,7 @@ Required properties:
 
 Optional properties:
 - ti,dmic: phandle for the OMAP dmic node if the machine have it connected
-- ti,jack_detection: Need to be set to <1> if the board capable to detect jack
+- ti,jack_detection: Need to be present if the board capable to detect jack
   insertion, removal.
 
 Available audio endpoints for the audio-routing table:
@@ -59,7 +59,7 @@ sound {
 	compatible = "ti,abe-twl6040";
 	ti,model = "SDP4430";
 
-	ti,jack-detection = <1>;
+	ti,jack-detection;
 	ti,mclk-freq = <38400000>;
 
 	ti,mcpdm = <&mcpdm>;
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index a57a4e6..1d6ea86 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -331,8 +331,8 @@ static __devinit int omap_abe_probe(struct platform_device *pdev)
 			num_links = 1;
 		}
 
-		of_property_read_u32(node, "ti,jack-detection",
-				     &priv->jack_detection);
+		priv->jack_detection = of_property_read_bool(node,
+							   "ti,jack-detection");
 		of_property_read_u32(node, "ti,mclk-freq",
 				     &priv->mclk_freq);
 		if (!priv->mclk_freq) {
-- 
1.8.0
