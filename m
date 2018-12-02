From: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 07/10] dt-bindigs: sound: Add Allwinner
 suniv F1C100s Audio Codec
Date: Mon,  3 Dec 2018 00:23:14 +0300
Message-ID: <d0ce4b1f2a89a319d6becb5f88d7ca4184aa5595.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Reply-To: mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDI4VHO5SYLBBX42SHQAKGQETO6CIFY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <cover.1543782328.git.mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vinod Koul <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add compatible string for Allwinner suniv F1C100s audio codec.

Signed-off-by: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/sun4i-codec.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index 66579bb..9778bc1 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -8,6 +8,7 @@ Required properties:
 		- "allwinner,sun8i-a23-codec"
 		- "allwinner,sun8i-h3-codec"
 		- "allwinner,sun8i-v3s-codec"
+		- "allwinner,suniv-f1c100s-codec"
 - reg: must contain the registers location and length
 - interrupts: must contain the codec interrupt
 - dmas: DMA channels for tx and rx dma. See the DMA client binding,
@@ -27,6 +28,7 @@ Required properties for the following compatibles:
 		- "allwinner,sun8i-a23-codec"
 		- "allwinner,sun8i-h3-codec"
 		- "allwinner,sun8i-v3s-codec"
+		- "allwinner,suniv-f1c100s-codec"
 - resets: phandle to the reset control for this device
 - allwinner,audio-routing: A list of the connections between audio components.
 			   Each entry is a pair of strings, the first being the
@@ -41,6 +43,7 @@ Required properties for the following compatibles:
 			   "MIC1"
 			   "MIC2"	(not on sun8i-v3s)
 			   "MIC3"	(sun6i-a31 only)
+			   "MIC"	(suniv-f1c100s only)
 
 			   Microphone biases from the SoC:
 			   "HBIAS"
@@ -51,6 +54,8 @@ Required properties for the following compatibles:
 			   "Headset Mic"
 			   "Line In"
 			   "Line Out"
+			   "Right FM In"	(suniv-f1c100s only)
+			   "Left FM In"		(suniv-f1c100s only)
 			   "Mic"
 			   "Speaker"
 
-- 
2.7.4
