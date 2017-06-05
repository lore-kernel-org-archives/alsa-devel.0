From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [PATCH v4 0/3] Allwinner V3s audio codec support (ASoC part)
Date: Mon,  5 Jun 2017 21:27:19 +0800
Message-ID: <20170605132722.6459-1-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBTFY2XEQKGQE5YOWU5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This is the ASoC part of the Allwinner V3s audio codec support.

The audio codec is like the ones on A23/H3, but much simpler.

As it lacks two features that used to be common (MIC2 and LINEIN),
some structures are altered to exclude these features.

Icenowy Zheng (3):
  ASoC: sun8i-codec-analog: prepare a mixer control/widget/route set for
    V3s
  ASoC: sun8i-codec-analog: add support for V3s SoC
  ASoC: sun4i-codec: Add support for V3s codec

 .../devicetree/bindings/sound/sun4i-codec.txt      |  11 ++-
 .../bindings/sound/sun8i-codec-analog.txt          |   1 +
 sound/soc/sunxi/sun4i-codec.c                      |  63 ++++++++++++
 sound/soc/sunxi/sun8i-codec-analog.c               | 110 ++++++++++++++++++++-
 4 files changed, 180 insertions(+), 5 deletions(-)

-- 
2.12.2
