From: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH] ASoC: simple-scu-card: Parse off codec widgets
Date: Fri, 11 Aug 2017 17:12:19 +0300
Message-ID: <1502460739-12134-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mihai.serban-3arQi8VN3Tc@public.gmane.org, shengjiu.wang-3arQi8VN3Tc@public.gmane.org, viorel.suman-3arQi8VN3Tc@public.gmane.org, Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/simple-scu-card.txt | 1 +
 sound/soc/generic/simple-scu-card.c                         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-scu-card.txt b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
index 327d229..32f8dbc 100644
--- a/Documentation/devicetree/bindings/sound/simple-scu-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
@@ -24,6 +24,7 @@ Optional subnode properties:
 - simple-audio-card,convert-rate	: platform specified sampling rate convert
 - simple-audio-card,convert-channels	: platform specified converted channel size (2 - 8 ch)
 - simple-audio-card,prefix		: see routing
+- simple-audio-card,widgets		: Please refer to widgets.txt.
 - simple-audio-card,routing		: A list of the connections between audio components.
 					  Each entry is a pair of strings, the first being the connection's sink,
 					  the second being the connection's source. Valid names for sources.
diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index a75b385..0bb3da7 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -191,6 +191,10 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	if (!node)
 		return -EINVAL;
 
+	ret = asoc_simple_card_of_parse_widgets(card, PREFIX);
+	if (ret < 0)
+		return ret;
+
 	ret = asoc_simple_card_of_parse_routing(card, PREFIX, 0);
 	if (ret < 0)
 		return ret;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
