From: Raphael Poggi <poggi.raph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] dt-bindings: sound: add binding for pcm1792a
Date: Fri, 20 Nov 2015 11:09:16 +0100
Message-ID: <1448014157-36526-4-git-send-email-raphael.poggi@avalun.com>
References: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448014157-36526-1-git-send-email-raphael.poggi-jXdF5569nj7QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Raphael Poggi <poggi.raph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Raphael Poggi <poggi.raph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Add a binding for specify channel selection.

Signed-off-by: Raphael Poggi <poggi.raph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/pcm1792a.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/pcm1792a.txt b/Documentation/devicetree/bindings/sound/pcm1792a.txt
index 970ba1e..6e87a3a 100644
--- a/Documentation/devicetree/bindings/sound/pcm1792a.txt
+++ b/Documentation/devicetree/bindings/sound/pcm1792a.txt
@@ -9,10 +9,15 @@ Required properties:
 For required properties on SPI, please consult
 Documentation/devicetree/bindings/spi/spi-bus.txt
 
+Optional properties:
+- ti,side: specifie the channel side
+  insertion, removal.
+
 Examples:
 
 	codec_spi: 1792a@0 {
 		compatible = "ti,pcm1792a";
 		spi-max-frequency = <600000>;
+		ti,side = <left>
 	};
 
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
