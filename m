From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2 0/3] ASOC: bcm2835: move bcm2835-i2s to use clock framework
Date: Tue, 12 Jan 2016 12:35:45 +0000
Message-ID: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This patchset enables the bcm2835-i2s driver to use the clock
framework which was introduced with commit 94cb7f76caa0
("ARM: bcm2835: Switch to using the new clock driver support.").

This commit resulted in the fact that the bcm2835-i2s driver was
no longer working due to some register addresses used by 2 drivers
(clk-bcm2835 and bcm2835-i2s).

This patchset requires that the patchset for PCM-clock
support as well as fractional/mash support is applied to
the clk-bcm2835 driver and the corresponding device tree,
but as the current version of the driver is not working,
that should not be a problem.

Note that there is one change:
right now the current driver tries to calculate an optimal
bclk_ratio based on its knowledge that it is using the 19.2Mhz
oscillator. This computation would recommend the use of 40
or 80 bits instead of 32/64 bits that are required.

Some of the DACs can not handle this, so most downstream
drivers would set snd_soc_dai_set_bclk_ratio explicitly to
disable this "non-power-of-2" automatic selection.

So it seems wise to leave it out of the current patchset.

If it is deemed necessary, then I can provide a separate
patch that implements this again.

Changelog:
  V1->V2: * moving clock patches into a separate patchset,
            which fixes also other issues in the clock framework
          * remove unnecessary bclk_size assignments

Martin Sperl (3):
  ASoC: bcm2835: move to use the clock framework
  ARM: bcm2835: I2S: use new register-range and clock framework
  dt-bindings: bsm2835: fix bindings documentation to use new clock
    framework

 .../devicetree/bindings/sound/brcm,bcm2835-i2s.txt |    7 +-
 arch/arm/boot/dts/bcm2835.dtsi                     |    5 +-
 sound/soc/bcm/bcm2835-i2s.c                        |  284 +++++---------------
 3 files changed, 69 insertions(+), 227 deletions(-)

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
