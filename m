From: Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH 0/2] ASoC: Dell IoT Gateway audio support
Date: Mon, 19 Dec 2016 21:51:45 +0800
Message-ID: <20161219135147.24208-1-shrirang.bagul@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These patches add basic audio support on new Dell Edge IoT Gateways.
RT5660 codec is connected to SSP2 port on Intel Atom Baytrail E3815 SoC.
The machine driver is based on bytcr_rt5640. These devices have line-in and
line-out jacks with line-out mute enable gpio described in ACPI tables.

Shrirang Bagul (2):
  ASoC: rt5660: Add ACPI support
  ASoC: Intel: boards: Add Baytrail RT5660 machine driver

 sound/soc/codecs/rt5660.c             |  26 ++
 sound/soc/intel/Kconfig               |  13 +
 sound/soc/intel/atom/sst/sst_acpi.c   |   2 +
 sound/soc/intel/boards/Makefile       |   2 +
 sound/soc/intel/boards/bytcr_rt5660.c | 573 ++++++++++++++++++++++++++++++++++
 5 files changed, 616 insertions(+)
 create mode 100644 sound/soc/intel/boards/bytcr_rt5660.c

-- 
2.9.3
