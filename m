From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 08/22] soundwire: bus: remove spurious newline
Date: Wed,  1 May 2019 10:57:31 -0500
Message-ID: <20190501155745.21806-9-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

tools complain here and the location of the newline does not improve
readability.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 863bf418e342..bb697fd68580 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -772,7 +772,6 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 		impl_int_mask = SDW_DPN_INT_IMPDEF1 |
 			SDW_DPN_INT_IMPDEF2 | SDW_DPN_INT_IMPDEF3;
 
-
 		if (status & impl_int_mask) {
 			clear |= impl_int_mask;
 			*slave_status = clear;
-- 
2.17.1
