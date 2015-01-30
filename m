From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 0/3] ASoC: atmel_ssc_dai: fix and refactor
Date: Fri, 30 Jan 2015 17:38:41 +0800
Message-ID: <1422610724-7222-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: nicolas.ferre@atmel.com, Songjun.Wu@atmel.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch set do following things:
  - Fix the DSP mode A setting.
  - Refactor the startup and shutdown function.
  - Only clean PDC when use PDC.


Bo Shen (3):
  ASoC: atmel_ssc_dai: fix the setting for DSP mode
  ASoC: atmel_ssc_dai: refactor the startup and shutdown
  ASoC: atmel_ssc_dai: only clean PDC when using PDC

 sound/soc/atmel/atmel_ssc_dai.c | 54 +++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

-- 
2.3.0.rc0
