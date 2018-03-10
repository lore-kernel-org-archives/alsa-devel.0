From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [RESEND PATCH 0/2] ASoC: Add support for max9759 Amplifier Driver
Date: Sat, 10 Mar 2018 12:05:14 +0100
Message-ID: <1520679916-13517-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The MAX9759 is a gpio controlled speaker amplifier, this patchset
add the DT Bindings and the corresponding ASoC component driver.

Changes with resend :
 - Add rob ack on bindings

Neil Armstrong (2):
  ASoC: Add DT bindings documentation for max9759 amplifier
  ASoC: max9759: Add Amplifier Driver

 .../devicetree/bindings/sound/maxim,max9759.txt    |  18 ++
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/max9759.c                         | 207 +++++++++++++++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max9759.txt
 create mode 100644 sound/soc/codecs/max9759.c

-- 
2.7.4
