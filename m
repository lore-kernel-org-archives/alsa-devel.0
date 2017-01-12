From: Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH v2 0/4]  ASoC: Dell IoT Gateway audio support
Date: Thu, 12 Jan 2017 20:00:57 +0800
Message-ID: <20170112120101.16933-1-shrirang.bagul@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This work is based on for-next branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

These patches add basic audio support on new Dell Edge IoT Gateways.
RT5660 codec is connected to SSP2 port on Intel Atom Baytrail E3815 SoC.
The machine driver is based on bytcr_rt5640. These devices have line-in and
line-out jacks with line-out mute enable gpio described in ACPI tables.

Since v1:
* rt5660: Use enumerations to define GPIO's described ACPI DSDT
* Initialize rt5660 controls from card struct
* Re-use existing bytcr_rt5640 machine driver to support rt5660 codec based
  audio

Shrirang Bagul (4):
  ASoC: rt5660: Add ACPI support
  ASoC: Intel: bytcr_rt5640: move codec clks to card driver data
  ASoC: Intel: Support rt5660 codec for Baytrail
  ASoC: Intel: bytcr_rt5640: Support line-out mute gpio

 sound/soc/codecs/rt5660.c             |  32 ++++++
 sound/soc/intel/Kconfig               |  11 +-
 sound/soc/intel/atom/sst/sst_acpi.c   |   2 +
 sound/soc/intel/boards/bytcr_rt5640.c | 211 ++++++++++++++++++++++++++++++----
 4 files changed, 228 insertions(+), 28 deletions(-)

-- 
2.9.3
