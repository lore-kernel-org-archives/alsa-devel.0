From: Fletcher Woodruff <fletcherw@chromium.org>
Subject: [PATCH v8 0/2] Fix jack detection for Chromebook Pixel
Date: Tue, 18 Jun 2019 17:45:53 -0600
Message-ID: <20190618234555.188955-1-fletcherw@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fletcher Woodruff <fletcherw@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, Ross Zwisler <zwisler@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Headphone/mic jack detection doesn't work on the Chromebook Pixel 2015.

These patches change the irq implementation to support polarity flipping.
With this series, plugging and unplugging the headphone jack switches
between headphones and speakers automatically, and headset microphones
are also detected.

v8:
  - Remove first two patches since they've been merged
  - Add pointer to i2c->dev in rt5677_priv for use in dev_err functions
  - Convert pr_err to dev_err in irq function

v7:
  - Rebase onto for-next branch of broonie/sound.git

v6:
  - Move refactoring into its own patch
  - Reorder patches so that DT property names patch is first
  - Clarify commit message for patch which implements irq handler
  - Remove unused work struct
  - Make IRQ function return IRQ_HANDLED only if IRQs actually fire

v5:
  - Fix void* parameter to devm_request_threaded_irq

v4:
  - Fix incorrect void* cast in rt5677_irq()

v3:
  - Update commit message for patch 1/3 to clarify why we implement
    our own irq_chip.

v2:
  - Split IRQ change into two patches: adding and fixing potential race
  - Change config reading code to try both DT and ACPI style names

Ben Zhang (2):
  ASoC: rt5677: clear interrupts by polarity flip
  ASoC: rt5677: handle concurrent interrupts

 sound/soc/codecs/rt5677.c | 192 +++++++++++++++++++++++++++++++-------
 sound/soc/codecs/rt5677.h |   8 +-
 2 files changed, 164 insertions(+), 36 deletions(-)

--
2.22.0.410.gd8fdbe21b5-goog
