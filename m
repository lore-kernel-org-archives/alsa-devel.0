From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 0/2] wm5110: fixes to ANC clock control
Date: Tue, 26 Apr 2016 17:06:18 +0100
Message-ID: <1461686780-22885-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The register for ANC clock control has a combination of volatile
and non-readback bits and these two patches fix the way we write
to this register.

Both patches must be taken together to ensure correct operation.

Richard Fitzgerald (2):
  mfd: wm5110: ARIZONA_CLOCK_CONTROL should be volatile
  ASoC: arizona: No need to update_bits when writing AEC clock control

 drivers/mfd/wm5110-tables.c | 1 +
 sound/soc/codecs/arizona.c  | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1
