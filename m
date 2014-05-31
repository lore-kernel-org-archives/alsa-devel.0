From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ALSA: Docs: Fix typo in tegra_hda doc.
Date: Fri, 30 May 2014 19:15:47 -0700
Message-ID: <1401502547-8436-1-git-send-email-dgreid@chromium.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, swarren@wwwdotorg.org, linux-doc@vger.kernel.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

The correct name of the third clock is hda2codec_2x.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
index c26f8ca..b4730c2 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
@@ -20,9 +20,9 @@ hda@0,70030000 {
 	clocks = <&tegra_car TEGRA124_CLK_HDA>,
 		 <&tegra_car TEGRA124_CLK_HDA2HDMI>,
 		 <&tegra_car TEGRA124_CLK_HDA2CODEC_2X>;
-	clock-names = "hda", "hda2hdmi", "hdacodec_2x";
+	clock-names = "hda", "hda2hdmi", "hda2codec_2x";
 	resets = <&tegra_car 125>, /* hda */
 		 <&tegra_car 128>; /* hda2hdmi */
 		 <&tegra_car 111>, /* hda2codec_2x */
-	reset-names = "hda", "hda2hdmi", "hdacodec_2x";
+	reset-names = "hda", "hda2hdmi", "hda2codec_2x";
 };
-- 
1.8.1.3.605.g02339dd

