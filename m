From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/2] ASoC: Add support for DA7217 and DA7218 audio codecs
Date: Thu, 5 Nov 2015 10:43:12 +0000
Message-ID: <cover.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch set adds DT and ASoC codec driver support for DA7217 and DA7218.

Changes are based against v4.3 kernel version.

Adam Thomson (2):
  ASoC: da7218: Add bindings documentation for DA7218 audio codec
  ASoC: codecs: Add da7218 codec driver

 Documentation/devicetree/bindings/sound/da7218.txt |  116 +
 include/sound/da7218.h                             |  136 +
 sound/soc/codecs/da7218.c                          | 3349 ++++++++++++++++++++
 sound/soc/codecs/da7218.h                          | 1405 ++++++++
 4 files changed, 5006 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/da7218.txt
 create mode 100644 include/sound/da7218.h
 create mode 100644 sound/soc/codecs/da7218.c
 create mode 100644 sound/soc/codecs/da7218.h

--
1.9.3
