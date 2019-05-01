From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 05/22] soundwire: bus: fix typos in comments
Date: Wed,  1 May 2019 10:57:28 -0500
Message-ID: <20190501155745.21806-6-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

spelling mistakes

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 74e04caa811b..efdcefc62e1a 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -49,7 +49,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 	}
 
 	/*
-	 * Device numbers in SoundWire are 0 thru 15. Enumeration device
+	 * Device numbers in SoundWire are 0 through 15. Enumeration device
 	 * number (0), Broadcast device number (15), Group numbers (12 and
 	 * 13) and Master device number (14) are not used for assignment so
 	 * mask these and other higher bits.
@@ -282,7 +282,7 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 	if (addr < SDW_REG_OPTIONAL_PAGE) { /* 32k but no page */
 		if (slave && !slave->prop.paging_support)
 			return 0;
-		/* no need for else as that will fall thru to paging */
+		/* no need for else as that will fall-through to paging */
 	}
 
 	/* paging mandatory */
-- 
2.17.1
