From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 12/15] soundwire: cadence_master: check the number of bidir PDIs
Date: Wed, 22 May 2019 14:47:28 -0500
Message-ID: <20190522194732.25704-13-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

There is an assumption that the first two PDIs are reserved for Bulk,
so we need to make sure the number of bidir PDIs is indeed larger than
two. If the configuration provided is incorrect, this could lead to
allocating a huge amount of memory.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index a505d74ab461..6a5fa70a8c69 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -717,6 +717,8 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 	stream = &cdns->pcm;
 
 	/* First two PDIs are reserved for bulk transfers */
+	if (stream->num_bd < CDNS_PCM_PDI_OFFSET)
+		return -EINVAL;
 	stream->num_bd -= CDNS_PCM_PDI_OFFSET;
 	offset = CDNS_PCM_PDI_OFFSET;
 
-- 
2.20.1
