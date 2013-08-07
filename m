From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dt: Move WM8903 pin list from Tegra
	board binding to CODEC binding
Date: Wed,  7 Aug 2013 10:16:18 +0100
Message-ID: <1375866978-14726-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E107261618
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 11:16:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The pin list is the same for any board using the CODEC.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 .../bindings/sound/nvidia,tegra-audio-wm8903.txt   | 22 ++--------------------
 Documentation/devicetree/bindings/sound/wm8903.txt | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
index 3bf722d..0efe58c 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
@@ -11,26 +11,8 @@ Required properties:
 - nvidia,audio-routing : A list of the connections between audio components.
   Each entry is a pair of strings, the first being the connection's sink,
   the second being the connection's source. Valid names for sources and
-  sinks are the WM8903's pins, and the jacks on the board:
-
-  WM8903 pins:
-
-  * IN1L
-  * IN1R
-  * IN2L
-  * IN2R
-  * IN3L
-  * IN3R
-  * DMICDAT
-  * HPOUTL
-  * HPOUTR
-  * LINEOUTL
-  * LINEOUTR
-  * LOP
-  * LON
-  * ROP
-  * RON
-  * MICBIAS
+  sinks are the WM8903's pins (documented in the WM8903 binding document),
+  and the jacks on the board:
 
   Board connectors:
 
diff --git a/Documentation/devicetree/bindings/sound/wm8903.txt b/Documentation/devicetree/bindings/sound/wm8903.txt
index f102cbc..94ec32c 100644
--- a/Documentation/devicetree/bindings/sound/wm8903.txt
+++ b/Documentation/devicetree/bindings/sound/wm8903.txt
@@ -28,6 +28,25 @@ Optional properties:
     performed. If any entry has the value 0xffffffff, that GPIO's
     configuration will not be modified.
 
+Pins on the device (for linking into audio routes):
+
+  * IN1L
+  * IN1R
+  * IN2L
+  * IN2R
+  * IN3L
+  * IN3R
+  * DMICDAT
+  * HPOUTL
+  * HPOUTR
+  * LINEOUTL
+  * LINEOUTR
+  * LOP
+  * LON
+  * ROP
+  * RON
+  * MICBIAS
+
 Example:
 
 codec: wm8903@1a {
-- 
1.8.4.rc1
