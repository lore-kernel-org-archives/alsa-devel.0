From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH 0/3] ASoc: TAS6424: Add support for mute, standby, and faster power on
Date: Fri, 20 Apr 2018 12:04:41 +0200
Message-ID: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: dannenberg@ti.com, afd@ti.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jean-Jacques Hiblot <jjhiblot@ti.com>
List-Id: alsa-devel@alsa-project.org

mute and standby pins are available on the codec. If they are connected, they
should be managed by the driver, instead of relying on gpio hogs or on the
initial state of the GPIOs.

This series also includes a patch to improve the start-up time of the channels
by disabling built-in DC diagnostics. Those diagnosdtics basically serve to
detect :
- wires shorted together
- wire shorted to ground or vbat
- wire disconnected
This is not useful for all platforms and the addition to the startup time is
quite noticeable (230ms).


Jean-Jacques Hiblot (3):
  ASoC: tas6424: Allow disabling auto diagnostics for faster power-on
  ASoC: tas6424: Add support for the standby pin
  ASoC: tas6424: Add support for the mute pin

 .../devicetree/bindings/sound/ti,tas6424.txt       |  4 ++
 sound/soc/codecs/tas6424.c                         | 74 +++++++++++++++++++++-
 sound/soc/codecs/tas6424.h                         |  3 +
 3 files changed, 79 insertions(+), 2 deletions(-)

-- 
2.7.4
