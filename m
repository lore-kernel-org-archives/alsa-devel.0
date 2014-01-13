From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCHv2 4/6] ASoC: simple-card: add sound-widgets usage
Date: Mon, 13 Jan 2014 13:53:56 +0800
Message-ID: <1389592438-13761-5-git-send-email-Li.Xiubo@freescale.com>
References: <1389592438-13761-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389592438-13761-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index e9e20ec..01eb2d0 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -15,6 +15,10 @@ Optional properties:
 					  Each entry is a pair of strings, the first being the
 					  connection's sink, the second being the connection's
 					  source.
+- sound-widgets				: The name of the audio card's off-CODEC widgets. If the
+					  audio card need the off-CODEC widgets, the card driver
+					  should register its widgets with one specified name:
+					  "XXXX", and in dt node the sound-widgets = "XXXX".
 
 Required subnodes:
 
@@ -42,6 +46,7 @@ Example:
 
 sound {
 	compatible = "simple-audio-card";
+	sound-widgets = "widgets"
 	simple-audio-card,format = "left_j";
 	simple-audio-routing =
 		"MIC_IN", "Mic Jack",
-- 
1.8.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
