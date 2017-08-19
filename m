From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v5 0/8] ASoC: Add I2S support for Allwinner H3 SoCs
Date: Sat, 19 Aug 2017 14:48:31 +0200
Message-ID: <20170819124839.4034-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBKXH4DGAKGQEL5UZABI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

---

v5 changes compared to v4 are:
- fixed bad logic in fmt0 set LRCK period define.
- fixed PTR_ERR checks in init of regmap fields
- added reviewed-by to commit messages
- removed delivered patches

v4 changes compared to v3 are:
- moved clkdiv variant adjustment out of function
- used PTR_ERR_OR_ZERO for checks
- tidy up of extra lines and lines over 80 chars.
- reduced names of polarity, wss and sr reg fields.
- added reviewed-by to commit messages
- added comments for functionality that hasn't been implemented yet.
- removed delivered patches

v3 changes compared to v2 are:
- initial changes to prepare driver for newer SoCs has been broken down
  into smaller patches
- reduce use of regmap fields to where just needed.
- clkdiv expansion will be delivered later.
- defines for H3 variant segregated.
- fixed regmap config issue with SUN8I_I2S_FIFO_TX_REG.

v2 changes compared to v1 are:
 - massive refactoring to remove duplicate code making use of regmap_fields.
 - extending the clock divisors.
 - removed code that should be delivered when we support 20/24bits

---

Marcus Cooper (8):
  ASoC: sun4i-i2s: Add regmap fields for channels
  ASoC: sun4i-i2s: Add regfields for word size select and sample
    resolution
  ASoC: sun4i-i2s: bclk and lrclk polarity tidyup
  ASoC: sun4i-i2s: Add mclk enable regmap field
  ASoC: sun4i-i2s: Add regmap field to set DAI format
  ASoC: sun4i-i2s: Check for slave select bit
  ASoC: sun4i-i2s: Update global enable with bitmask
  ASoC: sun4i-i2s: Add support for H3

 .../devicetree/bindings/sound/sun4i-i2s.txt        |   2 +
 sound/soc/sunxi/sun4i-i2s.c                        | 406 ++++++++++++++++++---
 2 files changed, 357 insertions(+), 51 deletions(-)

-- 
2.14.1
