From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/2] ASoC: Add support for the Allwinner A10 codec
Date: Sat, 12 Sep 2015 15:26:22 +0200
Message-ID: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBCUU2GXQKGQEWDOZLXA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi everyone,

This patch set adds the support for what Allwinner calls the codec on
their SoCs.

This codec is actually a combination of a codec and DAI, tied together
in a single memory-mapped IP. It is completely standalone, and outputs
directly the analog signal.

While it supports both playback and capture, the capture is not
implemented in this patch, and will be posted eventually as a separate
one.

This set, in order to be functional, has a dependency on the audio
clocks patch set posted separately. However, it doesn't needs this to
compile properly, so I guess it can be merged without really caring
for the merging status of the clock patches.

Let me know what you think,
Maxime

Emilio L=C3=B3pez (1):
  ASoC: sunxi: add support for the on-chip codec on early Allwinner SoCs

Maxime Ripard (1):
  Documentation: bindings: Add the Allwinner A10 codec bindings

 .../devicetree/bindings/sound/sun4i-codec.txt      |  33 +
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/sunxi/Kconfig                            |  11 +
 sound/soc/sunxi/Makefile                           |   2 +
 sound/soc/sunxi/sun4i-codec.c                      | 720 +++++++++++++++++=
++++
 6 files changed, 767 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-codec.txt
 create mode 100644 sound/soc/sunxi/Kconfig
 create mode 100644 sound/soc/sunxi/Makefile
 create mode 100644 sound/soc/sunxi/sun4i-codec.c

--=20
2.5.1

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
