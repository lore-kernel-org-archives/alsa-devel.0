From: Fletcher Woodruff <fletcherw@chromium.org>
Subject: [PATCH v5 0/3] Fix jack detection for Chromebook Pixel
Date: Tue,  7 May 2019 16:01:12 -0600
Message-ID: <20190507220115.90395-1-fletcherw@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fletcher Woodruff <fletcherw@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Headphone/mic jack detection doesn't work on the Chromebook Pixel 2015.

This patch changes the irq implementation to support polarity flipping
and fixes the configuration code so that correct GPIO pins are read
from ACPI.

With this series, plugging and unplugging the headphone jack switches
between headphones and speakers automatically, and headset microphones 
are also detected.

v5:
  - Fix void* parameter to devm_request_threaded_irq
  - Correct authorship for patch 2/3

v4:
  - Fix incorrect void* cast in rt5677_irq() 

v3:
  - Update commit message for patch 1/3 to clarify why we implement
    our own irq_chip.

v2:
  - Split IRQ change into two patches: adding and fixing potential race
  - Change config reading code to try both DT and ACPI style names


Ben Zhang (2):
  ASoC: rt5677: allow multiple interrupt sources
  ASoC: rt5677: handle concurrent interrupts

Fletcher Woodruff (1):
  ASoC: rt5677: fall back to DT prop names on error

 sound/soc/codecs/rt5677.c | 346 ++++++++++++++++++++++++++------------
 sound/soc/codecs/rt5677.h |  14 +-
 2 files changed, 256 insertions(+), 104 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog
