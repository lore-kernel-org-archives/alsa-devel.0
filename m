From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 0/3] ASoC: da7213: Add DT support for codec
Date: Wed, 7 Oct 2015 14:27:04 +0100
Message-ID: <cover.1444223905.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch set adds DT support to the codec driver, and supporting bindings
documentation.

Patch set is based against v4.3-rc4

Changes in v2:
 - Split mclk data support changes into separate patch
 - Use of_match_ptr() for match table assignment
 - Only call clk_prepare_enable/disable() if mclk data provided (not NULL).
 - Add error checking for clk_prepare_enable() usage.

Adam Thomson (3):
  ASoC: da7213: Add DT support to codec driver
  ASoC: da7213: Add support to handle mclk data provided to driver
  ASoC: da7213: Add bindings documentation for codec driver

 Documentation/devicetree/bindings/sound/da7213.txt |  41 +++++
 include/sound/da7213.h                             |   3 -
 sound/soc/codecs/da7213.c                          | 190 +++++++++++++++++++--
 sound/soc/codecs/da7213.h                          |   8 +-
 4 files changed, 221 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/da7213.txt

--
1.9.3
