From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/6] ASoC: Intel: bytcr_rt5640: use HID
	translation util
Date: Thu,  3 Mar 2016 21:36:38 -0600
Message-ID: <1457062599-10032-7-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1457062599-10032-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FBF3265472
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 04:36:50 +0100 (CET)
In-Reply-To: <1457062599-10032-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Remove hard-coded generation of codec name, use translation routine
to avoid issues with codec name not matching what the ACPI subsystem
registered

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index a06cd1f..032a2e7 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -340,15 +340,31 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
 	struct sst_acpi_mach *mach;
+	const char *i2c_name = NULL;
+	int i;
+	int dai_index;
 
 	/* register the soc card */
 	byt_rt5640_card.dev = &pdev->dev;
 	mach = byt_rt5640_card.dev->platform_data;
 
+	/* fix index of codec dai */
+	dai_index = MERR_DPCM_COMPR + 1;
+	for (i = 0; i < ARRAY_SIZE(byt_rt5640_dais); i++) {
+		if (!strcmp(byt_rt5640_dais[i].codec_name, "i2c-10EC5640:00")) {
+			dai_index = i;
+			break;
+		}
+	}
+
 	/* fixup codec name based on HID */
-	snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
-		 "%s%s%s", "i2c-", mach->id, ":00");
-	byt_rt5640_dais[MERR_DPCM_COMPR+1].codec_name = byt_rt5640_codec_name;
+	i2c_name = sst_acpi_find_name_from_hid(mach->id);
+	if (i2c_name != NULL) {
+		snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
+			"%s%s", "i2c-", i2c_name);
+
+		byt_rt5640_dais[dai_index].codec_name = byt_rt5640_codec_name;
+	}
 
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5640_quirk_table);
-- 
1.9.1
