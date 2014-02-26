From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 2/2] ASoC: cirrus: clps711x: Add bindings documentation for the CLPS711X DAI
Date: Wed, 26 Feb 2014 20:07:36 +0400
Message-ID: <1393430856-16322-1-git-send-email-shc_work@mail.ru>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds the devicetree documentation for the Cirrus Logic
CLPS711X Digital Audio Interface (DAI).

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 .../bindings/sound/cirrus,clps711x-dai.txt           | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,clps711x-dai.txt

diff --git a/Documentation/devicetree/bindings/sound/cirrus,clps711x-dai.txt b/Documentation/devicetree/bindings/sound/cirrus,clps711x-dai.txt
new file mode 100644
index 0000000..718599e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,clps711x-dai.txt
@@ -0,0 +1,20 @@
+* Cirrus Logic CLPS711X Digital Audio Interface (DAI)
+
+Required properties:
+- compatible: Should be "cirrus,clps711x-dai".
+- reg: Should contain registers location and length.
+- clocks: A clock specifier for the CPU PLL clock.
+- clock-names: The CPU PLL clock should be named "pll".
+- interrupts: Should contain DAI interrupt number.
+- syscon: phandle to syscon device node which control DAI (SYSCON3).
+
+Example:
+	dai: dai@80002000 {
+		#sound-dai-cells = <0>;
+		compatible = "cirrus,clps711x-dai";
+		reg = <0x80002000 0x604>;
+		clocks = <&clks 3>;
+		clock-names = "pll";
+		interrupts = <32>;
+		syscon = <&syscon3>;
+	};
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
