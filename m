From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 20/22] soundwire: cadence_master: fix boolean comparisons
Date: Wed,  1 May 2019 10:57:43 -0500
Message-ID: <20190501155745.21806-21-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

No need for explicit test against true

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 04632a97721e..50181752c2a4 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1033,7 +1033,7 @@ static struct sdw_cdns_pdi *cdns_find_pdi(struct sdw_cdns *cdns,
 	int i;
 
 	for (i = 0; i < num; i++) {
-		if (pdi[i].assigned == true)
+		if (pdi[i].assigned)
 			continue;
 		pdi[i].assigned = true;
 		return &pdi[i];
@@ -1084,7 +1084,7 @@ static int cdns_get_num_pdi(struct sdw_cdns *cdns,
 	int i, pdis = 0;
 
 	for (i = 0; i < num; i++) {
-		if (pdi[i].assigned == true)
+		if (pdi[i].assigned)
 			continue;
 
 		if (pdi[i].ch_count < ch_count)
-- 
2.17.1
