From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v8 1/7] ASoC: dt-bindings: add regulator
	property to simple amplifier
Date: Tue, 20 Nov 2018 21:17:46 -0800
Message-ID: <20181121051752.18387-2-anarsoul@gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D346267947
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 06:19:12 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id f12-v6so3731040plo.1
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 21:19:12 -0800 (PST)
In-Reply-To: <20181121051752.18387-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Amplifier may have associated regulator, so add a property for it.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 Documentation/devicetree/bindings/sound/simple-amplifier.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-amplifier.txt b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
index 8647edae7af0..7182ac4f1e65 100644
--- a/Documentation/devicetree/bindings/sound/simple-amplifier.txt
+++ b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
@@ -4,9 +4,14 @@ Required properties:
 - compatible : "dioo,dio2125" or "simple-audio-amplifier"
 - enable-gpios : the gpio connected to the enable pin of the simple amplifier
 
+Optional properties:
+- VCC-supply   : power supply for the device, as covered
+                 in Documentation/devicetree/bindings/regulator/regulator.txt
+
 Example:
 
 amp: analog-amplifier {
 	compatible = "simple-audio-amplifier";
+	VCC-supply = <&regulator>;
 	enable-gpios = <&gpio GPIOH_3 0>;
 };
-- 
2.19.1
