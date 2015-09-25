From: "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH  V1 0/6] ASoC: tlv320aic26: Add device tree support and bug fixes
Date: Fri, 25 Sep 2015 14:30:03 -0400
Message-ID: <1443205809-27549-1-git-send-email-jcormier@criticallink.com>
References: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Cormier, Jonathan" <jcormier@criticallink.com>
List-Id: alsa-devel@alsa-project.org

Hi,

The following patches were created to get the tlv320aic26 working on our AM335x
SoM.

This patch series relies on commit 93d0ad8f374c
"ASoC: tlv320aic26: Convert to params_width()" for proper operation.

Changes since RFC:
- Removed the unecessary "#if defined(CONFIG_OF)"
- Dropped the DSP_B patch

Thanks
-Jonathan

Cormier, Jonathan (6):
  ASoC: tlv320aic26: Add device tree binding
  ASoC: tlv320aic26: Fix module autoload
  ASoC: tlv320aic26: Make SND_SOC_TLV320AIC26 user-visible
  ASoC: tlv320aic26: Fix regmap by setting reg_defaults and reg_stride
  ASoC: tlv320aic26: hw_params was unintentionally clearing AIC26 master
    mode
  ASoC: tlv320aic26: Change Capture Mute to Capture Switch to match alsa
    documentation.

 .../devicetree/bindings/sound/tlv320aic26.txt      | 65 ++++++++++++++++++++++
 sound/soc/codecs/Kconfig                           |  2 +-
 sound/soc/codecs/tlv320aic26.c                     | 55 ++++++++++++++++--
 3 files changed, 115 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic26.txt

-- 
1.9.1
