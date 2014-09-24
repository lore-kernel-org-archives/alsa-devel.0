From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: Add gpio-controller DTS
	documentation
Date: Wed, 24 Sep 2014 11:31:58 -0700
Message-ID: <1411583518-32260-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f73.google.com (mail-pa0-f73.google.com
 [209.85.220.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CAE2261B25
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 20:32:02 +0200 (CEST)
Received: by mail-pa0-f73.google.com with SMTP id lf10so215978pab.2
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 11:32:01 -0700 (PDT)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 Documentation/devicetree/bindings/sound/rt5677.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5677.txt b/Documentation/devicetree/bindings/sound/rt5677.txt
index 98509fb..bd28df6 100644
--- a/Documentation/devicetree/bindings/sound/rt5677.txt
+++ b/Documentation/devicetree/bindings/sound/rt5677.txt
@@ -10,6 +10,11 @@ Required properties:
 
 - interrupts : The CODEC's interrupt output.
 
+- gpio-controller : Indicates this device is a GPIO controller.
+
+- #gpio-cells : Should be two. The first cell is the pin number and the
+  second cell is used to specify optional parameters (currently unused).
+
 Optional properties:
 
 - realtek,pow-ldo2-gpio : The GPIO that controls the CODEC's POW_LDO2 pin.
@@ -36,6 +41,10 @@ rt5677 {
 	reg = <0x2c>;
 	interrupt-parent = <&gpio>;
 	interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
+
+	gpio-controller;
+	#gpio-cells = <2>;
+
 	realtek,pow-ldo2-gpio =
 		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 };
-- 
2.1.0.rc2.206.gedb03e5
