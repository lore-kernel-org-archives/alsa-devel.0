From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 03/17] ASoC: Intel: bytcr_rt5640: enable
	differential mic quirk
Date: Fri, 12 Aug 2016 16:27:46 -0500
Message-ID: <1471037280-17433-4-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 85B81265FCF
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:46 +0200 (CEST)
In-Reply-To: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

Some Baytrail-CR devices rely on analog mics connected with
differential pairs and not the single-ended default
Add quirk and enable it for T00TAF

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 421a53c..085e57f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -41,6 +41,7 @@ enum {
 #define BYT_RT5640_MAP(quirk)	((quirk) & 0xff)
 #define BYT_RT5640_DMIC_EN	BIT(16)
 #define BYT_RT5640_MONO_SPEAKER BIT(17)
+#define BYT_RT5640_DIFF_MIC     BIT(18) /* defaut is single-ended */
 
 static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
 					BYT_RT5640_DMIC_EN;
@@ -148,7 +149,8 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
 		},
 		.driver_data = (unsigned long *)(BYT_RT5640_IN1_MAP |
-						 BYT_RT5640_MONO_SPEAKER
+						 BYT_RT5640_MONO_SPEAKER |
+						 BYT_RT5640_DIFF_MIC
 						 ),
 	},
 	{
@@ -223,6 +225,11 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
+	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC) {
+		snd_soc_update_bits(codec,  RT5640_IN1_IN2, RT5640_IN_DF1,
+				    RT5640_IN_DF1);
+	}
+
 	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN) {
 		ret = rt5640_dmic_enable(codec, 0, 0);
 		if (ret)
-- 
2.5.0
