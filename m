From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] soundwire: fix Kconfig select/depend issues
Date: Thu, 11 Apr 2019 14:28:12 -0500
Message-ID: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

0-day/Kbuild starts complaining about missed module dependencies and
compilation issues. Since codecs and soc drivers need to be compilable
independently, let's fix this using the following model:

SOUNDWIRE_INTEL ---- select -----------
                                      |
				      v
REGMAP_SOUNDWIRE --- select ---> SOUNDWIRE_BUS


Pierre-Louis Bossart (2):
  regmap: soundwire: fix Kconfig select/depend issue
  soundwire: fix SOUNDWIRE_BUS option

 drivers/base/regmap/Kconfig | 3 ++-
 drivers/soundwire/Kconfig   | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1
