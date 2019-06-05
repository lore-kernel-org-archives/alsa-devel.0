From: Fletcher Woodruff <fletcherw@chromium.org>
Subject: [PATCH v6 0/4] Fix jack detection for Chromebook Pixel
Date: Wed,  5 Jun 2019 16:24:15 -0600
Message-ID: <20190605222419.54479-1-fletcherw@chromium.org>
References: <20190507220115.90395-1-fletcherw@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507220115.90395-1-fletcherw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fletcher Woodruff <fletcherw@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, Ross Zwisler <zwisler@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Headphone/mic jack detection doesn't work on the Chromebook Pixel 2015.

This patch changes the irq implementation to support polarity flipping
and fixes the configuration code so that correct GPIO pins are read
from ACPI.

With this series, plugging and unplugging the headphone jack switches
between headphones and speakers automatically, and headset microphones 
are also detected.

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

Fletcher Woodruff (2):
  ASoC: rt5677: fall back to DT prop names on error
  ASoC: rt5677: move jack-detect init to i2c probe

 sound/soc/codecs/rt5677.c | 317 ++++++++++++++++++++++++++------------
 sound/soc/codecs/rt5677.h |  13 +-
 2 files changed, 234 insertions(+), 96 deletions(-)

-- 
2.22.0.rc1.311.g5d7573a151-goog
