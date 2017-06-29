From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] ASoC: audio-graph-card: update bindings for amplifier support
Date: Thu, 29 Jun 2017 21:26:37 +0800
Message-ID: <1498742798-3128-2-git-send-email-shawnguo@kernel.org>
References: <1498742798-3128-1-git-send-email-shawnguo@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498742798-3128-1-git-send-email-shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Baoyou Xie <xie.baoyou-i+zz7BTLltu8dxfXipz/DA@public.gmane.org>, Xin Zhou <zhou.xin8-i+zz7BTLltu8dxfXipz/DA@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

The audio-graph-card should be able to support widgets and routing in
the same way as what simple-audio-card does.  The patch adds the
properties into audio-graph-card bindings.  Then an optional property
'pa-gpios' for controlling external amplifier, which depends on DAPM
widgets and routing, is added.

Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/audio-graph-card.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
index bac4b1b1060f..6e6720aa33f1 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
@@ -10,6 +10,8 @@ see ${LINUX}/Documentation/devicetree/bindings/sound/simple-card.txt
 Below are same as Simple-Card.
 
 - label
+- widgets
+- routing
 - dai-format
 - frame-master
 - bitclock-master
@@ -24,6 +26,9 @@ Required properties:
 - compatible				: "audio-graph-card";
 - dais					: list of CPU DAI port{s}
 
+Optional properties:
+- pa-gpios: GPIO used to control external amplifier.
+
 Example: Single DAI case
 
 	sound_card {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
