From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] ASoC: mediatek: remove "simple-mfd" in the example
Date: Tue, 27 Mar 2018 09:32:25 +0800
Message-ID: <79b79aa29ea14e6f851ad01ed1f5a33543b05040.1522114156.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Garlic Tseng <garlic.tseng@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>
List-Id: alsa-devel@alsa-project.org

Remove compatible string "simple-mfd" in the example as we have
already added devm_of_platform_populate() in the parent driver.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index 6df87b9..e2f7f49 100644
--- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
+++ b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
@@ -53,7 +53,7 @@ See ../arm/mediatek/mediatek,audsys.txt for details about the parent node.
 Example:
 
 	audsys: audio-subsystem@11220000 {
-		compatible = "mediatek,mt2701-audsys", "syscon", "simple-mfd";
+		compatible = "mediatek,mt2701-audsys", "syscon";
 		...
 
 		afe: audio-controller {
-- 
1.9.1
