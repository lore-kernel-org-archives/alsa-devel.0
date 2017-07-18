From: Michael Stecklein <m-stecklein@ti.com>
Subject: [PATCH v3 0/2] Add support for TI TAS6424 digital amplifier
Date: Tue, 18 Jul 2017 14:20:02 -0500
Message-ID: <1500405604-23511-1-git-send-email-m-stecklein@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, Michael Stecklein <m-stecklein@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello all,

This two-patch series adds the dt bindings, driver, and other related
changes for the TAS6424 digital amplifier. I am upstreaming this driver
on behalf of Andreas.

Regards,
Michael Stecklein <m-stecklein@ti.com>

Changes since v2:
 - fixed binding as per Rob Herring's comments on v2

Changes since v1:
 - rebased on 4.13-rc1

Original v1 patches:
 - https://patchwork.kernel.org/patch/9795235/
 - https://patchwork.kernel.org/patch/9795237/

Andreas Dannenberg (1):
  ASoC: add support for TAS6424 digital amplifier

Michael Stecklein (1):
  dt-bindings: sound: add bindings for TAS6424

 .../devicetree/bindings/sound/ti,tas6424.txt       |  28 +
 sound/soc/codecs/Kconfig                           |   8 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tas6424.c                         | 755 +++++++++++++++++++++
 sound/soc/codecs/tas6424.h                         | 127 ++++
 5 files changed, 920 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas6424.txt
 create mode 100644 sound/soc/codecs/tas6424.c
 create mode 100644 sound/soc/codecs/tas6424.h

-- 
2.7.4
