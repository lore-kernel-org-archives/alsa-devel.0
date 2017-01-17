From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 00/10] Add sun8i A33 audio driver
Date: Tue, 17 Jan 2017 15:02:20 +0100
Message-ID: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello everyone,

This a V2 of my Allwinner A33 (sun8i) audio codec driver.
Tested on linux-next-20170105 tag with one remaining patch from Chen-Yu's
series:
http://lkml.iu.edu/hypermail/linux/kernel/1611.3/01256.html
Patch to apply before this serie:
https://patchwork.kernel.org/patch/9423999/

Changes since V1:
	- Remove the analog codec driver as a better version has been
	committed by Chen-Yu Tsai and is already merged.
	- Remove the audio-card as simple-card can be used
	- The DMA maxburst is set to 8 in the sun4i-i2s instead of
	adding the maxburst of 4 in Sun6i dma engine.
	- Create a new compatible for sun4i-i2s to handle the reset
	line.
	- Fix various problems in sun8i-codec driver according to V1's
	reviews
	- Add the pm_runtime hooks in sun8i-codec driver to prepare/
	unprepare clocks.
	- Update the DTS according to Chen-Yu's analog codec driver.
	- Rename sun8i-codec's clocks to "bus" and "mod"
	- The first "delay" issue from V1 is fixed by using a delay
	when enabling the headphone amplifier to let the amplifier
	being up.

Patch 1 increases the DMA maxburst value of sun4i-i2s to 8.
See Chen-Yu's commit log for more details:
https://patchwork.kernel.org/patch/9411805/

Patch 2 adds the CLK_SET_RATE_PARENT flag to ccu sun8i-a33 clocks.

Patches 3 and 4 add a new compatible "allwinner,sun6i-a31-i2s"
to handle the reset line for sun4i-i2s driver. It uses a quirk to
use a version with or without reset lines.

Patch 5 adds the sun8i codec driver which represents the digital part
of the A33 codec. It supports only playback features.

Path 6 fixes the previous issue of a "first time delay" in V1 (see cover
letter). Do not hesitate if you have comments on this patch.

Patches 7 adds the dt-bindings documentation for new audio driver
added in this serie (sun8i-codec).

Patch 8 adds the cpu DAI, codec and audio nodes to sun8i-a33 device tree.

Patches 9 and 10 enable the audio on Parrot and Sinlinx's boards.

The DAI for this A33 codec is the same than for A20: "sun4i-i2s".
Currently, all the drivers handle only the playback feature.
The other ones (such as capture) and all other interfaces except
headphone are not supported. I will send a patch to handle the
capture with microphones in next few weeks.

Examples of amixer commands:
	amixer set 'Headphone' 75%
	amixer set 'Headphone' on
	amixer set 'DAC' on
	amixer set 'Right DAC Mixer RSlot 0' on
	amixer set 'Left DAC Mixer LSlot 0' on

It was tested on Parrot and Sinlinx boards.

Let me know if you have any comments on this serie.

Thank you in advance,
Best regards,

Mylène Josserand (10):
  ASoC: sun4i-i2s: Increase DMA max burst to 8
  clk: ccu-sun8i-a33: Add CLK_SET_RATE_PARENT to ac-dig
  dt-bindings: sound: Add new reset compatible for sun4i-i2s
  ASoC: sun4i-i2s: Add quirks to handle new compatible for reset
  ASoC: Add sun8i digital audio codec
  ASoC: sun8i-codec-analog: Add amplifier event to fix first delay
  dt-bindings: sound: Add sun8i audio documentation
  ARM: dts: sun8i: Add audio codec, dai and card for A33
  ARM: dts: sun8i: parrot: Enable audio nodes
  ARM: dts: sun8i: sinlinx: Enable audio nodes

 .../devicetree/bindings/sound/sun4i-i2s.txt        |  23 +
 .../devicetree/bindings/sound/sun8i-codec.txt      |  76 +++
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   8 +
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  47 ++
 arch/arm/boot/dts/sun8i-r16-parrot.dts             |   8 +
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |   2 +-
 sound/soc/sunxi/Kconfig                            |  11 +
 sound/soc/sunxi/Makefile                           |   1 +
 sound/soc/sunxi/sun4i-i2s.c                        |  61 ++-
 sound/soc/sunxi/sun8i-codec-analog.c               |  30 +-
 sound/soc/sunxi/sun8i-codec.c                      | 531 +++++++++++++++++++++
 11 files changed, 791 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec.txt
 create mode 100644 sound/soc/sunxi/sun8i-codec.c

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
