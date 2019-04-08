From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 2/4] soundwire: bus: remove useless initializations
Date: Mon,  8 Apr 2019 15:04:59 -0500
Message-ID: <20190408200501.9610-3-pierre-louis.bossart@linux.intel.com>
References: <20190408200501.9610-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408200501.9610-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

No need for explicit initialization of page and ssp fields, they are
already zeroed with a memset.

Detected with cppcheck:

[drivers/soundwire/bus.c:309]: (style) Variable 'msg->page' is
reassigned a value before the old one has been used.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 691a31df9732..bb697fd68580 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -271,8 +271,6 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 	msg->dev_num = dev_num;
 	msg->flags = flags;
 	msg->buf = buf;
-	msg->ssp_sync = false;
-	msg->page = false;
 
 	if (addr < SDW_REG_NO_PAGE) { /* no paging area */
 		return 0;
-- 
2.17.1
