From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 15/15] soundwire: intel_init: add checks on link numbers
Date: Wed, 22 May 2019 14:47:31 -0500
Message-ID: <20190522194732.25704-16-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Add mask to correctly read the SoundWire SHIM LCAP register. Only bits
2..0 are meaningful, the rest is about link synchronization and stream
channel mapping. Without this mask, the hardware information would
always be larger than whatever the BIOS would report.

Also trap the case with zero links.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 771a53a5c033..70637a0383d2 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -81,6 +81,7 @@ static struct sdw_intel_ctx
 
 	/* Check SNDWLCAP.LCOUNT */
 	caps = ioread32(res->mmio_base + SDW_SHIM_BASE + SDW_SHIM_LCAP);
+	caps &= GENMASK(2, 0);
 
 	/* Check HW supported vs property value and use min of two */
 	count = min_t(u8, caps, count);
@@ -90,6 +91,9 @@ static struct sdw_intel_ctx
 		dev_err(&adev->dev, "Link count %d exceeds max %d\n",
 			count, SDW_MAX_LINKS);
 		return NULL;
+	} else if (!count) {
+		dev_warn(&adev->dev, "No SoundWire links detected\n");
+		return NULL;
 	}
 
 	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
-- 
2.20.1
