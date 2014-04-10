From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5640: Add the info of rt5639 to
	the binding document
Date: Thu, 10 Apr 2014 10:57:35 +0800
Message-ID: <1397098655-21965-2-git-send-email-oder_chiou@realtek.com>
References: <1397098655-21965-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B38D261A40
 for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2014 04:57:45 +0200 (CEST)
In-Reply-To: <1397098655-21965-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds the info of rt5639 to the binding document.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5640.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5640.txt b/Documentation/devicetree/bindings/sound/rt5640.txt
index 068a114..bac4d9a 100644
--- a/Documentation/devicetree/bindings/sound/rt5640.txt
+++ b/Documentation/devicetree/bindings/sound/rt5640.txt
@@ -1,10 +1,10 @@
-RT5640 audio CODEC
+RT5640/RT5639 audio CODEC
 
 This device supports I2C only.
 
 Required properties:
 
-- compatible : "realtek,rt5640".
+- compatible : One of "realtek,rt5640" or "realtek,rt5639".
 
 - reg : The I2C address of the device.
 
@@ -18,7 +18,7 @@ Optional properties:
 
 - realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
 
-Pins on the device (for linking into audio routes):
+Pins on the device (for linking into audio routes) for RT5639/RT5640:
 
   * DMIC1
   * DMIC2
@@ -31,13 +31,16 @@ Pins on the device (for linking into audio routes):
   * HPOR
   * LOUTL
   * LOUTR
-  * MONOP
-  * MONON
   * SPOLP
   * SPOLN
   * SPORP
   * SPORN
 
+Additional pins on the device for RT5640:
+
+  * MONOP
+  * MONON
+
 Example:
 
 rt5640 {
-- 
1.8.1.1.439.g50a6b54
