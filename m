From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 0/2] ASoC/regmap: rt5640: Fix resume
Date: Tue, 26 Aug 2014 17:03:11 +0300
Message-ID: <1409061793-10495-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Realtek RT5642 audio codec fails to resume because regmap/regcache tries
to sync consecutive registers using block writes but RT5642 doesn't support
autoincrementing I2C writes according to debugging and oscilloscope
measurments.

I'm not sure is there regression after 75a5f89f635c ("regmap: cache: Write
consecutive registers in a single block write") or was RT564x resume ever
working in mainline so I didn't mark stable yet.

Both patches are independent from each other and can be applied into their
own subsystems separately.

Jarkko Nikula (2):
  regmap: cache: Fix regcache_sync_block for non-autoincrementing
    devices
  ASoC: rt5640: Do not allow regmap to use bulk read-write operations

 drivers/base/regmap/regcache.c | 14 +++++++++++++-
 sound/soc/codecs/rt5640.c      |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.1.0
