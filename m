From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2] ASoC: audio-graph-card: support external amplifier with DAPM widget
Date: Thu, 29 Jun 2017 21:26:36 +0800
Message-ID: <1498742798-3128-1-git-send-email-shawnguo@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Baoyou Xie <xie.baoyou-i+zz7BTLltu8dxfXipz/DA@public.gmane.org>, Xin Zhou <zhou.xin8-i+zz7BTLltu8dxfXipz/DA@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

It's basically the result of discussion around how external amplifier
controlled by GPIO should be supported by audio card, that uses generic
machine driver like audio-graph-card.

The patch series updates audio-graph-card bindings and driver to support
DAPM widget and audio routing, and then based on that, creates an output
driver widget with event to control the amplifier via GPIO.

[1] https://www.spinics.net/lists/arm-kernel/msg589717.html

Shawn Guo (2):
  ASoC: audio-graph-card: update bindings for amplifier support
  ASoC: audio-graph-card: add widgets and routing for external amplifier
    support

 .../devicetree/bindings/sound/audio-graph-card.txt |  5 +++
 sound/soc/generic/audio-graph-card.c               | 48 +++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
