From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/4] constify codecs acpi_device_id.
Date: Sun, 23 Jul 2017 22:53:23 +0530
Message-ID: <1500830607-17268-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

acpi_device_id are not supposed to change at runtime. All functions
working with acpi_device_id provided by <acpi/acpi_bus.h> work with
const acpi_device_id. So mark the non-const structs as const.

Arvind Yadav (4):
  [PATCH 1/4] ASoC: rt5514: constify acpi_device_id.
  [PATCH 2/4] ASoC: rt5663: constify acpi_device_id.
  [PATCH 3/4] ASoC: rt5659: constify acpi_device_id.
  [PATCH 4/4] ASoC: rt5665: constify acpi_device_id.

 sound/soc/codecs/rt5514.c | 2 +-
 sound/soc/codecs/rt5659.c | 2 +-
 sound/soc/codecs/rt5663.c | 2 +-
 sound/soc/codecs/rt5665.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4
