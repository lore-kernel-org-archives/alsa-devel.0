From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: fix simple card widgets routing property name usage
Date: Fri, 10 Jan 2014 13:17:27 +0800
Message-ID: <1389331047-21437-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: broonie@linaro.org
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Fix the usage of simple card widgets routing property, and make it the
same with simple card routing property name.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index e9e20ec..19c84df 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -43,7 +43,7 @@ Example:
 sound {
 	compatible = "simple-audio-card";
 	simple-audio-card,format = "left_j";
-	simple-audio-routing =
+	simple-audio-card,routing =
 		"MIC_IN", "Mic Jack",
 		"Headphone Jack", "HP_OUT",
 		"Ext Spk", "LINE_OUT";
-- 
1.8.4


