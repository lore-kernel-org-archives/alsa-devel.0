From: "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH v2 0/7] ASoC: tlv320aic26: Add device tree support and bug fixes
Date: Thu, 21 Mar 2019 18:14:06 -0400
Message-ID: <20190321221413.13268-1-jcormier@criticallink.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Cc: "Cormier, Jonathan" <jcormier@criticallink.com>, Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

The following patches were created to get the tlv320aic26 working
on our AM335x SoM.

I'm resubmitting this patch series. Previous version here:
https://lore.kernel.org/patchwork/cover/601439/

This patch series relies on the following patch for proper operation.
commit 93d0ad8f374c ("ASoC: tlv320aic26: Convert to params_width()")

Changes since RFC:
- Removed the unnecessary "#if defined(CONFIG_OF)"
- Dropped the DSP_B patch
Changes since V1:
- Reordered Kconfig patch to first so each patch can be built
- Rebased changes to Linux 5.1-rc1

Cormier, Jonathan (7):
  ASoC: tlv320aic26: Allow tlv320aic26 to be selected in menuconfig
  dt-bindings: ASoC: tlv320aic26: Add device tree binding
  ASoC: tlv320aic26: Add device tree binding
  ASoC: tlv320aic26: Fix module autoload
  ASoC: tlv320aic26: Fix regmap by setting reg_defaults and reg_stride
  ASoC: tlv320aic26: hw_params was unintentionally clearing AIC26 master
    mode
  ASoC: tlv320aic26: Change Capture Mute to Capture Switch to match alsa
    documentation.

 .../devicetree/bindings/sound/tlv320aic26.txt | 65 +++++++++++++++++++
 sound/soc/codecs/Kconfig                      |  4 +-
 sound/soc/codecs/tlv320aic26.c                | 55 ++++++++++++++--
 3 files changed, 116 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic26.txt

-- 
2.21.0
