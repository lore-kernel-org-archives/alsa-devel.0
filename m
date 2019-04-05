From: Fletcher Woodruff <fletcherw@chromium.org>
Subject: [PATCH v2 0/3] Fix jack detection for Chromebook Pixel
Date: Fri,  5 Apr 2019 14:42:54 -0600
Message-ID: <20190405204257.87095-1-fletcherw@chromium.org>
References: <20190401205519.34023-2-fletcherw@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401205519.34023-2-fletcherw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fletcher Woodruff <fletcherw@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, Ross Zwisler <zwisler@google.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Headphone/mic jack detection doesn't work on the Chromebook Pixel 2015.

This patch changes the irq implementation to support polarity flipping
and fixes the configuration code so that correct GPIO pins are read
from ACPI.

With this series, plugging and unplugging the headphone jack switches
between headphones and speakers automatically, and headset microphones 
are also detected.

v2:
  - Split IRQ change into two patches: adding and fixing potential race
  - Change config reading code to try both DT and ACPI style names

Ben Zhang (2):
  ASoC: rt5677: allow multiple interrupt sources
  ASoC: rt5677: handle concurrent interrupts

Fletcher Woodruff (1):
  ASoC: rt5677: fall back to DT prop names on error

 sound/soc/codecs/rt5677.c | 347 +++++++++++++++++++++++++++-----------
 sound/soc/codecs/rt5677.h |  14 +-
 2 files changed, 257 insertions(+), 104 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog
