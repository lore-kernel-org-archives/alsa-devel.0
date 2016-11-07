From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v3 0/6] ASoC: sun4i-codec: Add support for A31 Codec
Date: Mon,  7 Nov 2016 18:06:57 +0800
Message-ID: <20161107100703.5586-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBSVEQHAQKGQEDEGC5MA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi everyone,

This is v3 of my Allwinner A31 audio codec support series. These are
the remaining driver patches not yet merged, with 1 new fix, and the
dts file patches.

The A31's internal codec is similar (in terms of DMA, interface and
control layouts) to the one found in the A10/A13/A20 SoCs. However
it has more external inputs and outputs, the mixer controls are now
stereo (left/right separated), and it also has some audio processing
features (not supported yet).


Changes since v2:

  - Added patch """ASoC: sun4i-codec: Add "Right Mixer" to "Line Out
    Mono Diff." route""" which fixes line out when all the sources
    have their left channel muted.

  - Dropped unused codec_pa_pin from A31 hummingbird dts patch.
    In the past we always provided a pinmux setting for GPIOs used, to
    avoid accidentally muxing a pin that was already used for GPIO, or
    vice versa. The pinctrl subsystem now supports exclusive use of a
    pin for GPIO, which the sunxi platform wants to migrate to. This
    drops the requirement of the explicit pinmux setting for GPIOs.

  - Added Maxime's Acked-by for the two existing patches from v2.


After these are merged I plan to submit patches to support the audio
codec found in Allwinner's A23 and H3 SoCs.


Regards
ChenYu


Chen-Yu Tsai (6):
  ASoC: sun4i-codec: Add support for optional reset control to quirks
  ASoC: sun4i-codec: Add support for A31 ADC capture path
  ASoC: sun4i-codec: Add "Right Mixer" to "Line Out Mono Diff." route
  ARM: dts: sun6i: Add audio codec device node
  ARM: dts: sun6i: hummingbird: Enable internal audio codec
  ARM: dts: sun6i: sina31s: Enable internal audio codec

 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 13 ++++
 arch/arm/boot/dts/sun6i-a31.dtsi            | 13 ++++
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts    |  8 +++
 sound/soc/sunxi/sun4i-codec.c               | 94 ++++++++++++++++++++++++++++-
 4 files changed, 127 insertions(+), 1 deletion(-)

-- 
2.10.2
