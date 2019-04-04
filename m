From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/3] soundwire: stream: remove useless initialization of local variable
Date: Thu,  4 Apr 2019 13:22:04 -0500
Message-ID: <20190404182204.31262-4-pierre-louis.bossart@linux.intel.com>
References: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

no need to reset return value.

Detected with cppcheck:
[drivers/soundwire/stream.c:332]: (style) Variable 'ret' is assigned a
value that is never used.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index e3d2bc5cba80..ab64c2c4c33f 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -329,7 +329,7 @@ static int sdw_enable_disable_master_ports(struct sdw_master_runtime *m_rt,
 	struct sdw_transport_params *t_params = &p_rt->transport_params;
 	struct sdw_bus *bus = m_rt->bus;
 	struct sdw_enable_ch enable_ch;
-	int ret = 0;
+	int ret;
 
 	enable_ch.port_num = p_rt->num;
 	enable_ch.ch_mask = p_rt->ch_mask;
-- 
2.17.1
