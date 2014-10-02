From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Intel: byt-rt5640: Add quirk for
	Dell Venue 8 Pro tablet
Date: Thu,  2 Oct 2014 13:29:08 +0300
Message-ID: <1412245749-17983-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 12760261554
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 12:29:23 +0200 (CEST)
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
Cc: Jan-Michael Brummer <jan.brummer@tabos.org>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

It was found with help of Jan-Michael Brummer <jan.brummer@tabos.org> that
Dell Venue 8 Pro tablet has a digital microphone connected to DMIC2
interface of the RT564x.

This patch adds a DAPM route to DMIC2 and a quirk using it for that tablet.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reported-by: Jan-Michael Brummer <jan.brummer@tabos.org>
---
Hi Jan. Could you give a second test to this patch? I noticed I had a few
lines missing from the version I sent you yesterday. If this still works
please reply with your Tested-by:.
Mark: I don't have this hw but Jan helped me to debug the right
configuration and sent the needed machine information for the DMI quirk.
---
 sound/soc/intel/byt-rt5640.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index 8392c160d9e2..a9619b4201f9 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -49,6 +49,10 @@ static const struct snd_soc_dapm_route byt_rt5640_intmic_dmic1_map[] = {
 	{"DMIC1", NULL, "Internal Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5640_intmic_dmic2_map[] = {
+	{"DMIC2", NULL, "Internal Mic"},
+};
+
 static const struct snd_soc_dapm_route byt_rt5640_intmic_in1_map[] = {
 	{"Internal Mic", NULL, "MICBIAS1"},
 	{"IN1P", NULL, "Internal Mic"},
@@ -56,6 +60,7 @@ static const struct snd_soc_dapm_route byt_rt5640_intmic_in1_map[] = {
 
 enum {
 	BYT_RT5640_DMIC1_MAP,
+	BYT_RT5640_DMIC2_MAP,
 	BYT_RT5640_IN1_MAP,
 };
 
@@ -111,6 +116,15 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		},
 		.driver_data = (unsigned long *)BYT_RT5640_IN1_MAP,
 	},
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "DellInc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5830"),
+		},
+		.driver_data = (unsigned long *)(BYT_RT5640_DMIC2_MAP |
+						 BYT_RT5640_DMIC_EN),
+	},
 	{}
 };
 
@@ -138,6 +152,10 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5640_intmic_in1_map;
 		num_routes = ARRAY_SIZE(byt_rt5640_intmic_in1_map);
 		break;
+	case BYT_RT5640_DMIC2_MAP:
+		custom_map = byt_rt5640_intmic_dmic2_map;
+		num_routes = ARRAY_SIZE(byt_rt5640_intmic_dmic2_map);
+		break;
 	default:
 		custom_map = byt_rt5640_intmic_dmic1_map;
 		num_routes = ARRAY_SIZE(byt_rt5640_intmic_dmic1_map);
-- 
2.1.0
