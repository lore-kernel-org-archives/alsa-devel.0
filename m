From: Michael Stecklein <m-stecklein@ti.com>
Subject: [PATCH 0/2] Add support for TI TAS6424 digital amplifier
Date: Fri, 16 Jun 2017 10:33:38 -0500
Message-ID: <1497627220-7196-1-git-send-email-m-stecklein@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "Andrew F . Davis" <afd@ti.com>, Michael Stecklein <m-stecklein@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello all,

This two-patch series adds the dt bindings, driver, and other related
changes for the TAS6424 digital amplifier. I am upstreaming this driver
on behalf of Andreas.

Regards,
Michael Stecklein <m-stecklein@ti.com>

Andreas Dannenberg (1):
  ASoC: add support for TAS6424 digital amplifier

Michael Stecklein (1):
  dt-bindings: sound: add bindings for TAS6424

 .../devicetree/bindings/sound/ti,tas6424.txt       |  31 +
 sound/soc/codecs/Kconfig                           |   8 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tas6424.c                         | 755 +++++++++++++++++++++
 sound/soc/codecs/tas6424.h                         | 127 ++++
 5 files changed, 923 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas6424.txt
 create mode 100644 sound/soc/codecs/tas6424.c
 create mode 100644 sound/soc/codecs/tas6424.h

-- 
2.7.4
