From: Florian Vaussard <florian.vaussard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] dt/bindings: Add bindings documentation for TI ADS117x ADC
Date: Mon, 18 Jan 2016 17:04:51 +0100
Message-ID: <1453133092-29521-2-git-send-email-florian.vaussard@heig-vd.ch>
References: <1453133092-29521-1-git-send-email-florian.vaussard@heig-vd.ch>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453133092-29521-1-git-send-email-florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Janusz Krzysztofik <jkrzyszt-NCk8gXQAEuFz6jiHbVrK7g@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Currently the binding is only made of the compatible string.

Signed-off-by: Florian Vaussard <florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/ti,ads117x.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,ads117x.txt

diff --git a/Documentation/devicetree/bindings/sound/ti,ads117x.txt b/Documentation/devicetree/bindings/sound/ti,ads117x.txt
new file mode 100644
index 0000000..c1c2741
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,ads117x.txt
@@ -0,0 +1,11 @@
+Texas Intstruments ADS117x ADC
+
+Required properties:
+
+  - compatible : "ti,ads117x"
+
+Example:
+
+ads1178 {
+	compatible = "ti,ads117x";
+};
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
