From: Florian Vaussard <florian.vaussard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/2] ASoC: ads117x: Add bindings documentation for TI ADS117x ADC
Date: Fri,  5 Feb 2016 16:32:13 +0100
Message-ID: <1454686334-9668-2-git-send-email-florian.vaussard@heig-vd.ch>
References: <1454686334-9668-1-git-send-email-florian.vaussard@heig-vd.ch>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454686334-9668-1-git-send-email-florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Florian Vaussard <florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Currently the binding is only made of the compatible string.

Signed-off-by: Florian Vaussard <florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/ti,ads117x.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,ads117x.txt

diff --git a/Documentation/devicetree/bindings/sound/ti,ads117x.txt b/Documentation/devicetree/bindings/sound/ti,ads117x.txt
new file mode 100644
index 0000000..7db19b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,ads117x.txt
@@ -0,0 +1,11 @@
+Texas Intstruments ADS117x ADC
+
+Required properties:
+
+  - compatible : "ti,ads1174" or "ti,ads1178"
+
+Example:
+
+ads1178 {
+	compatible = "ti,ads1178";
+};
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
