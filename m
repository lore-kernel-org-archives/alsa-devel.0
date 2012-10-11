From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 0/3] Convert to use snd_soc_register_card()
Date: Thu, 11 Oct 2012 10:38:14 +0800
Message-ID: <1349923097-14115-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, nicolas.ferre@atmel.com, jm.lin@atmel.com, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Convert to use snd_soc_register_card(), and enable it

Change the id for the gpio i2c to let it work

Bo Shen (3):
  ASoC: sam9g20-wm8731: convert to use snd_soc_register_card()
  ASoC: sam9g20: using platform device for audio part
  i2c: change the id to let the i2c-gpio work

 arch/arm/mach-at91/at91sam9260_devices.c |   11 ++++++-
 arch/arm/mach-at91/board-sam9g20ek.c     |   17 ++++++++++
 sound/soc/atmel/sam9g20_wm8731.c         |   51 +++++++++++++-----------------
 3 files changed, 49 insertions(+), 30 deletions(-)

-- 
1.7.9.5

