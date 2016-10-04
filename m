From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 10/14] dt-bindings: sound: Add sun8i audio card documentation
Date: Tue,  4 Oct 2016 11:46:23 +0200
Message-ID: <c317ce9f180a24611e79086944feca00d416b7b4.1475571575.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1475569400.git.mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
In-Reply-To: <cover.1475571575.git.mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
References: <cover.1475571575.git.mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add the documentation for dt-binding of the audio card driver
for sun8i SoC.

Signed-off-by: Mylène Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/sun8i-audio.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/sun8i-audio.txt b/Documentation/devicetree/bindings/sound/sun8i-audio.txt
new file mode 100644
index 0000000..2403983
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun8i-audio.txt
@@ -0,0 +1,17 @@
+* Allwinner A23/A33 audio card
+
+This binding implements the A33 audio card.
+
+Required properties:
+- compatible: must be "allwinner,sun8i-audio"
+- allwinner,audio-codec: must have the phandle of the audio codec
+  ("sun8i-a33-codec", for example).
+- allwinner,i2s-controller: must have the phandle of the DAI
+  ("allwinner,sun4i-a10-i2s", for example)
+
+Example:
+sound {
+	compatible = "allwinner,sun8i-audio";
+	allwinner,audio-codec = <&codec>;
+	allwinner,i2s-controller = <&dai>;
+};
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
