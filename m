From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/6] soundwire: inits and PM additions for 5.4
Date: Tue, 13 Aug 2019 16:32:20 -0500
Message-ID: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This is an update on the RFC, to be applied after the '[PATCH v2 0/3]
soundwire: debugfs support for 5.4' and '[PATCH 00/17] soundwire:
fixes for 5.4' series.

Total that makes 28 patches submitted for review, broken in 3 sets.

Changes since RFC (Feedback from GregKH, Vinod, Cezary, Guennadi):
Squashed init sequence fixes in one patch, which remains
readable. Tested all return values and called update_config() as
needed.
Fixed hw-reset debugfs (removed -unsafe and noisy dev_info traces)
Simplified enable_interrupt() with goto
Fixed style, removed typos and FIXMES in pm_runtime code
Clarified commit messages

Pierre-Louis Bossart (6):
  soundwire: fix startup sequence for Intel/Cadence
  soundwire: cadence_master: add hw_reset capability in debugfs
  soundwire: intel: add helper for initialization
  soundwire: intel: Add basic power management support
  soundwire: cadence_master: make clock stop exit configurable on init
  soundwire: intel: add pm_runtime support

 drivers/soundwire/cadence_master.c | 135 ++++++++++++++------
 drivers/soundwire/cadence_master.h |   5 +-
 drivers/soundwire/intel.c          | 194 +++++++++++++++++++++++++++--
 3 files changed, 289 insertions(+), 45 deletions(-)

-- 
2.20.1
