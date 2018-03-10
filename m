From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [RESEND PATCH 1/2] ASoC: Add DT bindings documentation
	for max9759 amplifier
Date: Sat, 10 Mar 2018 12:05:15 +0100
Message-ID: <1520679916-13517-2-git-send-email-narmstrong@baylibre.com>
References: <1520679916-13517-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B6854267614
 for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2018 12:05:24 +0100 (CET)
Received: by mail-wr0-f193.google.com with SMTP id r66so3691322wrb.6
 for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2018 03:05:24 -0800 (PST)
In-Reply-To: <1520679916-13517-1-git-send-email-narmstrong@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-Id: alsa-devel@alsa-project.org

This patch adds DT bindings documentation for Maxim MAX9759
speaker amplifier.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/sound/maxim,max9759.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max9759.txt

diff --git a/Documentation/devicetree/bindings/sound/maxim,max9759.txt b/Documentation/devicetree/bindings/sound/maxim,max9759.txt
new file mode 100644
index 0000000..737a996
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max9759.txt
@@ -0,0 +1,18 @@
+Maxim MAX9759 Speaker Amplifier
+===============================
+
+Required properties:
+- compatible : "maxim,max9759"
+- shutdown-gpios : the gpio connected to the shutdown pin
+- mute-gpios : the gpio connected to the mute pin
+- gain-gpios : the 2 gpios connected to the g1 and g2 pins
+
+Example:
+
+max9759: analog-amplifier {
+	compatible = "maxim,max9759";
+	shutdown-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+	mute-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
+	gain-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>,
+		     <&gpio3 25 GPIO_ACTIVE_LOW>;
+};
-- 
2.7.4
