From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 11/17] ASoC: Intel: bytcr_rt5640: add IN3 map
Date: Fri, 12 Aug 2016 16:27:54 -0500
Message-ID: <1471037280-17433-12-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EC2C266A07
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:48 +0200 (CEST)
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

Some platforms have the analog mic connected to IN3,
add route accordingly

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index c4a3c57..9b9d380 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -39,6 +39,7 @@ enum {
 	BYT_RT5640_DMIC1_MAP,
 	BYT_RT5640_DMIC2_MAP,
 	BYT_RT5640_IN1_MAP,
+	BYT_RT5640_IN3_MAP,
 };
 
 #define BYT_RT5640_MAP(quirk)	((quirk) & 0xff)
@@ -79,6 +80,11 @@ static const struct snd_soc_dapm_route byt_rt5640_intmic_in1_map[] = {
 	{"IN1P", NULL, "Internal Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5640_intmic_in3_map[] = {
+	{"Internal Mic", NULL, "MICBIAS1"},
+	{"IN3P", NULL, "Internal Mic"},
+};
+
 static const struct snd_soc_dapm_route byt_rt5640_ssp2_aif1_map[] = {
 	{"ssp2 Tx", NULL, "codec_out0"},
 	{"ssp2 Tx", NULL, "codec_out1"},
@@ -243,6 +249,10 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5640_intmic_in1_map;
 		num_routes = ARRAY_SIZE(byt_rt5640_intmic_in1_map);
 		break;
+	case BYT_RT5640_IN3_MAP:
+		custom_map = byt_rt5640_intmic_in3_map;
+		num_routes = ARRAY_SIZE(byt_rt5640_intmic_in3_map);
+		break;
 	case BYT_RT5640_DMIC2_MAP:
 		custom_map = byt_rt5640_intmic_dmic2_map;
 		num_routes = ARRAY_SIZE(byt_rt5640_intmic_dmic2_map);
-- 
2.5.0
