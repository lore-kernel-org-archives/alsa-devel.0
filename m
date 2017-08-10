From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v2 3/3] dt-bindings: ASoC: rockchip: Add rockchip,codec-names property
Date: Thu, 10 Aug 2017 12:54:58 +0800
Message-ID: <1502340898-28403-4-git-send-email-jeffy.chen@rock-chips.com>
References: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de
Cc: briannorris@chromium.org, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add a new rockchip,codec-names property, so that the driver can parse
the codecs by name.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2:
Let rockchip,codec-names be a required property.

 Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
index eac91db..05351df 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
@@ -5,6 +5,7 @@ Required properties:
 - rockchip,cpu: The phandle of the Rockchip I2S controller that's
   connected to the codecs
 - rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
+- rockchip,codec-names: The names of the MAX98357A/RT5514/DA7219 codecs
 
 Optional properties:
 - dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
@@ -18,5 +19,6 @@ sound {
 	compatible = "rockchip,rk3399-gru-sound";
 	rockchip,cpu = <&i2s0>;
 	rockchip,codec = <&max98357a &rt5514 &da7219>;
+	rockchip,codec-names = "MAX98357A", "RT5514", "DA7219";
 	dmic-wakeup-delay-ms = <20>;
 };
-- 
2.1.4
