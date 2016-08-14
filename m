From: John Keeping <john@metanate.com>
Subject: [PATCH 0/2] ASoC: Chromebook Pixel 2015 support
Date: Sun, 14 Aug 2016 12:18:21 +0100
Message-ID: <20160814111823.1782-1-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>, Dylan Reid <dgreid@chromium.org>, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

These patches add basic support for audio on the Chromebook Pixel 2015.
I took the machine driver from ChromeOS commit v3.14-10186-g7e7d95df2983
and other than removing support for wake on voice (which is not
supported by the mainline rt5677 codec driver), the only differences are
to cope with API changes since 3.14.

Only two authors have committed changes to the machine driver in the
ChromeOS tree and all of the commits are signed off; both authors' SoB
lines are preserved in the second commit here.

The codec driver is sufficiently different that I just added ACPI
support from scratch using the ChromeOS source as a reference for the
property names.

John Keeping (2):
  ASoC: rt5677: Add ACPI support
  ASoC: Intel: boards: Add bdw-rt5677 machine driver

 sound/soc/codecs/rt5677.c           | 109 +++++++++---
 sound/soc/intel/Kconfig             |  11 ++
 sound/soc/intel/boards/Makefile     |   2 +
 sound/soc/intel/boards/bdw-rt5677.c | 341 ++++++++++++++++++++++++++++++++++++
 sound/soc/intel/common/sst-acpi.c   |   1 +
 5 files changed, 443 insertions(+), 21 deletions(-)
 create mode 100644 sound/soc/intel/boards/bdw-rt5677.c

-- 
2.9.3.728.g30b24b4.dirty
