From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2 1/2] dt: binding: ASOC: add dt-binding doc for pcm5102a
Date: Tue, 17 May 2016 13:59:10 +0000
Message-ID: <1463493551-27385-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, florian.meier-oZ8rN/sblLk@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Add dt-binding documentation for the TI pcm5102a DAC.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/pcm5102a.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm5102a.txt

diff --git a/Documentation/devicetree/bindings/sound/pcm5102a.txt b/Documentation/devicetree/bindings/sound/pcm5102a.txt
new file mode 100644
index 0000000..87d72be
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/pcm5102a.txt
@@ -0,0 +1,13 @@
+PCM5102a audio CODEC
+
+This device is a i2s only device.
+
+Required properties:
+
+- compatible : set as "ti,pcm5102a"
+
+Examples:
+
+	pcm5102a: pcm5102a {
+		compatible = "ti,pcm5102a";
+	};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
