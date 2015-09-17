From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/3] ASoC: Add support for DA7219 audio codec
Date: Thu, 17 Sep 2015 17:01:08 +0100
Message-ID: <cover.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Jason Coughlan <jason.coughlan@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch set adds support for the DA7219 audio codec with built-in
advanced accessory detection functionality. Patch set includes codec driver,
associated DT bindings documentation and MAINTAINERS file updates to cover new
bindings.

Adam Thomson (3):
  ASoC: codecs: Add da7219 codec driver
  ASoC: da7219: Add bindings documentation for DA7219 audio codec
  MAINTAINERS: da7219: Add entry to cover DA7219 bindings document

 Documentation/devicetree/bindings/sound/da7219.txt |  106 ++
 MAINTAINERS                                        |    1 +
 include/sound/da7219-aad.h                         |   99 ++
 include/sound/da7219.h                             |   76 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/da7219-aad.c                      |  800 +++++++++
 sound/soc/codecs/da7219-aad.h                      |  209 +++
 sound/soc/codecs/da7219.c                          | 1877 ++++++++++++++++++++
 sound/soc/codecs/da7219.h                          |  807 +++++++++
 10 files changed, 3981 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/da7219.txt
 create mode 100644 include/sound/da7219-aad.h
 create mode 100644 include/sound/da7219.h
 create mode 100644 sound/soc/codecs/da7219-aad.c
 create mode 100644 sound/soc/codecs/da7219-aad.h
 create mode 100644 sound/soc/codecs/da7219.c
 create mode 100644 sound/soc/codecs/da7219.h

--
1.9.3
