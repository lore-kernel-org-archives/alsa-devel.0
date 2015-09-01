From: Songjun Wu <songjun.wu@atmel.com>
Subject: [PATCH 0/2] ASoC: atmel-classd: add the Audio Class D Amplifier
Date: Tue, 1 Sep 2015 13:41:39 +0800
Message-ID: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org
Cc: Songjun Wu <songjun.wu@atmel.com>
List-Id: alsa-devel@alsa-project.org

The Audio Class D Amplifier driver includes two parts.
1) Driver code to implement the Audio Class D Amplifier function. 
2) Device tree binding document, it describes how to add the Audio
Class D Amplifier in device tree.

Songjun Wu (2):
  ASoC: atmel-classd: add the Audio Class D Amplifier code
  ASoC: atmel-classd: DT binding for Class D audio amplifier driver

 .../devicetree/bindings/sound/atmel-classd.txt     |   73 ++
 sound/soc/atmel/Kconfig                            |    9 +
 sound/soc/atmel/Makefile                           |    2 +
 sound/soc/atmel/atmel-classd.c                     |  801 ++++++++++++++++++++
 sound/soc/atmel/atmel-classd.h                     |  120 +++
 5 files changed, 1005 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-classd.txt
 create mode 100644 sound/soc/atmel/atmel-classd.c
 create mode 100644 sound/soc/atmel/atmel-classd.h

-- 
1.7.9.5
