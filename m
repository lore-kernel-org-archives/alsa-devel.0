From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v8 3/7] ASoC: dt-bindings: make enable-gpio
	optional for simple amplifier
Date: Tue, 20 Nov 2018 21:17:48 -0800
Message-ID: <20181121051752.18387-4-anarsoul@gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07AF526796E
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 06:19:14 +0100 (CET)
Received: by mail-pl1-f193.google.com with SMTP id s5-v6so3710006plq.11
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 21:19:14 -0800 (PST)
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

Amplifier may have no enable GPIO, so make this property optional

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 Documentation/devicetree/bindings/sound/simple-amplifier.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-amplifier.txt b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
index 7182ac4f1e65..b1b097cc9b68 100644
--- a/Documentation/devicetree/bindings/sound/simple-amplifier.txt
+++ b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
@@ -2,9 +2,9 @@ Simple Amplifier Audio Driver
 
 Required properties:
 - compatible : "dioo,dio2125" or "simple-audio-amplifier"
-- enable-gpios : the gpio connected to the enable pin of the simple amplifier
 
 Optional properties:
+- enable-gpios : the gpio connected to the enable pin of the simple amplifier
 - VCC-supply   : power supply for the device, as covered
                  in Documentation/devicetree/bindings/regulator/regulator.txt
 
-- 
2.19.1
