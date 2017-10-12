From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 4/9] ASoC: Intel: bytcht_da7213: cosmetic
	fixes
Date: Thu, 12 Oct 2017 18:38:00 -0500
Message-ID: <20171012233805.30055-5-pierre-louis.bossart@linux.intel.com>
References: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 29031266EEB
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 01:38:18 +0200 (CEST)
In-Reply-To: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Reorder variable names, change tests
No functional change

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_da7213.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index 18873e23f404..24070bc06040 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -231,12 +231,12 @@ static char codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
 
 static int bytcht_da7213_probe(struct platform_device *pdev)
 {
-	int ret_val = 0;
-	int i;
 	struct snd_soc_card *card;
 	struct sst_acpi_mach *mach;
 	const char *i2c_name = NULL;
 	int dai_index = 0;
+	int ret_val = 0;
+	int i;
 
 	mach = (&pdev->dev)->platform_data;
 	card = &bytcht_da7213_card;
@@ -253,7 +253,7 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 
 	/* fixup codec name based on HID */
 	i2c_name = sst_acpi_find_name_from_hid(mach->id);
-	if (i2c_name != NULL) {
+	if (i2c_name) {
 		snprintf(codec_name, sizeof(codec_name),
 			"%s%s", "i2c-", i2c_name);
 		dailink[dai_index].codec_name = codec_name;
-- 
2.11.0
