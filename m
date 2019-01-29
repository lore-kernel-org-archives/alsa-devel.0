From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: cht_bsw_rt5672: remove useless
	test
Date: Tue, 29 Jan 2019 09:42:20 -0600
Message-ID: <20190129154220.3142-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E0AC267454
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 16:42:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

For some reason we test if the machine is passed as a parameter before
fixing up the codec name. This is unnecessary, generates false
positives in static analysis tools and done only in this machine
driver, remove and adjust indentation.

Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index f1c1f9dd5353..3d5a2b3a06f0 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -411,18 +411,15 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	strcpy(drv->codec_name, RT5672_I2C_DEFAULT);
 
 	/* fixup codec name based on HID */
-	if (mach) {
-		i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
-		if (i2c_name) {
-			snprintf(drv->codec_name, sizeof(drv->codec_name),
-				 "i2c-%s", i2c_name);
-			for (i = 0; i < ARRAY_SIZE(cht_dailink); i++) {
-				if (!strcmp(cht_dailink[i].codec_name,
-					    RT5672_I2C_DEFAULT)) {
-					cht_dailink[i].codec_name =
-						drv->codec_name;
-					break;
-				}
+	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
+	if (i2c_name) {
+		snprintf(drv->codec_name, sizeof(drv->codec_name),
+			 "i2c-%s", i2c_name);
+		for (i = 0; i < ARRAY_SIZE(cht_dailink); i++) {
+			if (!strcmp(cht_dailink[i].codec_name,
+				RT5672_I2C_DEFAULT)) {
+				cht_dailink[i].codec_name = drv->codec_name;
+				break;
 			}
 		}
 	}
-- 
2.17.1
