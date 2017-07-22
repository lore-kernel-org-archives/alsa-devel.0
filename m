From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v2 0/2] ASoC: Add I2S support for Allwinner H3 SoCs
Date: Sat, 22 Jul 2017 08:53:50 +0200
Message-ID: <20170722065352.7635-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBAXNZPFQKGQEQSGJSGQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hi All,
please find attached a series of patches to bring i2s support to the
Allwinner H3 SoC. This has been tested with the following setups:

A20 Olimex EVB connected to a pcm5102
Orange Pi 2 connected to a uda1380
Orange Pi 2 hdmi audio playback
Pine 64 connected to the audio DAC board

To get i2s working some additional patches are required which will be
delivered later. For now they have been pushed here

https://github.com/codekipper/linux-sunxi/commits/sunxi-audio-h3

I don't own a A33 device which uses the i2s block for the audio codec
so if someone could test against that it would be much appreciated.

I'm also wondering if there is a preferred way of setting the lrclk
size in the dts?..currently it is set to the sample width but for example
the pcm5102a wants it to be 32 bits whatever the sample rate.

Thanks in advance,
CK

v2 changes compared to v1 are:
 - massive refactoring to remove duplicate code making use of regmap_fields.
 - extending the clock divisors.
 - removed code that should be delivered when we support 20/24bits

---

Marcus Cooper (2):
  ASoC: sun4i-i2s: Add more quirks for newer SoCs
  ASoC: sun4i-i2s: Add support for H3

 .../devicetree/bindings/sound/sun4i-i2s.txt        |   2 +
 sound/soc/sunxi/sun4i-i2s.c                        | 469 ++++++++++++++++++---
 2 files changed, 407 insertions(+), 64 deletions(-)

-- 
2.13.3
