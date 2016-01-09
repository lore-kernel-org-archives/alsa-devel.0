From: kernel@martin.sperl.org
Subject: [PATCH 0/5] ASOC: bcm2835: move bcm2835-i2s to use clock framework
Date: Sat,  9 Jan 2016 09:25:52 +0000
Message-ID: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Remi Pommarel <repk@triplefau.lt>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Reichl <hias@horus.com>, lFlorian Meier <florian.meier@koalo.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
List-Id: alsa-devel@alsa-project.org

From: Martin Sperl <kernel@martin.sperl.org>

This patchset enables the bcm2835-i2s driver to use the clock
framework which was introduced with commit 94cb7f76caa0b337
("Switch to using the new clock driver support").

This commit resulted in the fact that the bcm2835-i2s driver was
no longer working due to some register addresses used by 2 drivers
(clk-bcm2835 and bcm2835-i2s).

To make it all possible this also required the introduction
of the PCM clock into the clk-bcm2835 driver. This patchset
relies on the patch by Remi Pommarel <repk@triplefau.lt>
that introduces the ability to set parent clocks
("clk: bcm2835: Support for clock parent selection"), which is
(as far as I understood) in clk-next and slated for 4.5.

Note that there is one regression: the clk-bcm2835 does not yet
support the mash functionality which the SOC-Hw supports, this
may result in slightly more "audiable noise" than the original
driver. But as this is more about making the driver functional
again, this is - I believe - a drawback we can accept for now.

Martin Sperl (5):
  ASoC: bcm2835: cleanup includes by ordering them alphabetically
  clk: bcm2835: enable management of PCM clock
  ASoC: bcm2835: move to use the clock framework
  ARM: bcm2835: I2S: use new register-range and clock framework
  dt-bindings: bsm2835: fix bindings documentation to use new clock
    framework

 .../devicetree/bindings/sound/brcm,bcm2835-i2s.txt |    7 +-
 arch/arm/boot/dts/bcm2835.dtsi                     |    5 +-
 drivers/clk/bcm/clk-bcm2835.c                      |   15 +
 include/dt-bindings/clock/bcm2835.h                |    3 +-
 sound/soc/bcm/bcm2835-i2s.c                        |  293 +++++---------------
 5 files changed, 91 insertions(+), 232 deletions(-)

--
1.7.10.4

