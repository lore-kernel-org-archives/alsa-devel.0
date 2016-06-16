From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v1 1/2] ASoC: Add DT bindings documentation for max98504
 amplifier
Date: Thu, 16 Jun 2016 18:40:37 +0200
Message-ID: <1466095238-9047-1-git-send-email-s.nawrocki@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds DT bindings documentation for Maxim MAX98504
speaker amplifier.

Signed-off-by: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
Changes since initial version:
 - dropped all optional properties used for setting up TDM and
   speaker data source,
 - added regulator supply properties.
---
 .../devicetree/bindings/sound/max98504.txt         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98504.txt

diff --git a/Documentation/devicetree/bindings/sound/max98504.txt b/Documentation/devicetree/bindings/sound/max98504.txt
new file mode 100644
index 0000000..7aa5b93
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98504.txt
@@ -0,0 +1,22 @@
+Maxim MAX98504 class D mono speaker amplifier
+
+This device supports I2C control interface and an IRQ output signal. It features
+a PCM and PDM digital audio interface (DAI) and a differential analog input.
+
+Required properties:
+
+ - compatible : "maxim,max98504"
+ - reg : should contain the I2C slave device address
+ - DVDD-supply, DIOVDD-supply, PVDD-supply: power supplies for the device,
+   as covered in Documentation/devicetree/bindings/regulator/regulator.txt
+
+Example:
+
+ max98504: max98504@31 {
+	compatible = "maxim,max98504";
+	reg = <0x31>;
+
+	DVDD-supply = <&regulator>;
+	DIOVDD-supply = <&regulator>;
+	PVDD-supply = <&regulator>;
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
