From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH 0/2] ARM/sound: fix audio on kirkwood-openrd-client
Date: Sun, 24 Jan 2016 00:36:38 +0200
Message-ID: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>, Rick Thomas <rbthomas-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Audio playback has been broken some time on OpenRD client. With the
following patches I got the audio file playback working with mplayer.

Aaro Koskinen (2):
  ARM: DTS: kirkwood-openrd-client: fix audio
  ASoC: simple-card: don't fail if sysclk setting is not supported

 arch/arm/boot/dts/kirkwood-openrd-client.dts | 6 +++++-
 arch/arm/boot/dts/kirkwood.dtsi              | 2 +-
 sound/soc/generic/simple-card.c              | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
