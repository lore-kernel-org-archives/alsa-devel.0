From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/2] soundwire: fix Kconfig select/depend issues
Date: Fri, 19 Apr 2019 14:46:47 -0500
Message-ID: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

0-day/Kbuild starts complaining about missed module dependencies and
compilation issues. Since codecs and soc drivers need to be compilable
independently, let's fix this using the following model:

SOF_INTEL_XYZ --- select ---->  SOUNDWIRE_INTEL ---> select ----
                                                               |
				                               v
                                                        SOUNDWIRE_BUS
   							       ^
                                                               |
CODEC_ABC ------- select -----> REGMAP_SOUNDWIRE ---> select ---

The SOUNDWIRE option remains a top-level boolean selector without
impact on compilation, as recommended by Linus [1] and done for all
Intel ASoC stuff.

[1] https://lkml.org/lkml/2017/11/15/554

Changes since v1:
Removed useless depend in REGMAP_SOUNDWIRE (select will ignore dependencies)
Reordered patches to avoid circular dependencies with git bisect

Pierre-Louis Bossart (2):
  soundwire: fix SOUNDWIRE_BUS option
  regmap: soundwire: fix Kconfig select/depend issue

 drivers/base/regmap/Kconfig | 2 +-
 drivers/soundwire/Kconfig   | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.17.1
