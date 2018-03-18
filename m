From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] ASoC: samsung: Mark unused Odroid compatibles as deprecated
Date: Sun, 18 Mar 2018 16:35:12 +0100
Message-ID: <20180318153512.8343-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Compatible for XU4 audio is not being used.  Instead the board uses the
same compatible as XU3.  The devices are now just compatible so they
should use the same value.  Mark "hardkernel,odroid-xu4-audio" as being
deprecated so in this future could be removed to limit useless
properties.

Additionally add older compatibles appearing in the bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Correct typo XU4->XU3 for one deprecated compatible.
---
 Documentation/devicetree/bindings/sound/samsung,odroid.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.txt b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
index f35a2694eb04..e9da2200e173 100644
--- a/Documentation/devicetree/bindings/sound/samsung,odroid.txt
+++ b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
@@ -3,7 +3,9 @@ Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
 Required properties:
 
  - compatible - "hardkernel,odroid-xu3-audio" - for Odroid XU3 board,
-		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board
+		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board (deprecated),
+		"samsung,odroid-xu3-audio" - for Odroid XU3 board (deprecated),
+		"samsung,odroid-xu4-audio" - for Odroid XU4 board (deprecated)
  - model - the user-visible name of this sound complex
  - clocks - should contain entries matching clock names in the clock-names
     property
-- 
2.14.1
