From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: byt-rt5640: Enable DMIC
	interface for default DAPM route
Date: Wed,  1 Oct 2014 15:08:15 +0300
Message-ID: <1412165295-24229-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1412165295-24229-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AC68260486
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 14:08:33 +0200 (CEST)
In-Reply-To: <1412165295-24229-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

It turned out DMIC interface wasn't enabled/disabled runtime for active
DMIC route in the rt5640 codec driver anymore after commit
71d97a794301 ("ASoC: rt5640: Use the platform data for DMIC settings").

Since DMIC interface must be enabled explicitly either by passing platform
data to rt5640 codec driver or by calling new rt5640_dmic_enable() this
patch adds a DMI quirk flag that is used to conditionally enable DMIC
interface during sound card init time.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
Goes on top of ("ASoC: Intel: byt-rt5640: Add quirk for Asus T100")
---
 sound/soc/intel/byt-rt5640.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index c323a101214e..8392c160d9e2 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -59,7 +59,11 @@ enum {
 	BYT_RT5640_IN1_MAP,
 };
 
-static unsigned long byt_rt5640_custom_map = BYT_RT5640_DMIC1_MAP;
+#define BYT_RT5640_MAP(quirk)	((quirk) & 0xff)
+#define BYT_RT5640_DMIC_EN	BIT(16)
+
+static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_DMIC_EN;
 
 static const struct snd_kcontrol_new byt_rt5640_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
@@ -94,7 +98,7 @@ static int byt_rt5640_hw_params(struct snd_pcm_substream *substream,
 
 static int byt_rt5640_quirk_cb(const struct dmi_system_id *id)
 {
-	byt_rt5640_custom_map = (unsigned long)id->driver_data;
+	byt_rt5640_quirk = (unsigned long)id->driver_data;
 	return 1;
 }
 
@@ -129,7 +133,7 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	}
 
 	dmi_check_system(byt_rt5640_quirk_table);
-	switch (byt_rt5640_custom_map) {
+	switch (BYT_RT5640_MAP(byt_rt5640_quirk)) {
 	case BYT_RT5640_IN1_MAP:
 		custom_map = byt_rt5640_intmic_in1_map;
 		num_routes = ARRAY_SIZE(byt_rt5640_intmic_in1_map);
@@ -143,6 +147,12 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
+	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN) {
+		ret = rt5640_dmic_enable(codec, 0, 0);
+		if (ret)
+			return ret;
+	}
+
 	snd_soc_dapm_ignore_suspend(dapm, "HPOL");
 	snd_soc_dapm_ignore_suspend(dapm, "HPOR");
 
-- 
2.1.0
