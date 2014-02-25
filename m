From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Intel: byt-rt5640: Update internal
	mic and speaker kcontrol names
Date: Tue, 25 Feb 2014 15:17:27 +0200
Message-ID: <1393334248-29033-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 97436261AF6
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 14:17:44 +0100 (CET)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use more sensible kcontrol names than "Int Mic" and "Ext Spk". Speakers
especially are usually integrated devices in sales models.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-rt5640.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index 038547b48b2d..672fedbfa680 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -29,27 +29,27 @@
 static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_MIC("Int Mic", NULL),
-	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+	SND_SOC_DAPM_MIC("Internal Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
 };
 
 static const struct snd_soc_dapm_route byt_rt5640_audio_map[] = {
 	{"IN2P", NULL, "Headset Mic"},
 	{"IN2N", NULL, "Headset Mic"},
-	{"DMIC1", NULL, "Int Mic"},
+	{"DMIC1", NULL, "Internal Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
-	{"Ext Spk", NULL, "SPOLP"},
-	{"Ext Spk", NULL, "SPOLN"},
-	{"Ext Spk", NULL, "SPORP"},
-	{"Ext Spk", NULL, "SPORN"},
+	{"Speaker", NULL, "SPOLP"},
+	{"Speaker", NULL, "SPOLN"},
+	{"Speaker", NULL, "SPORP"},
+	{"Speaker", NULL, "SPORN"},
 };
 
 static const struct snd_kcontrol_new byt_rt5640_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
-	SOC_DAPM_PIN_SWITCH("Int Mic"),
-	SOC_DAPM_PIN_SWITCH("Ext Spk"),
+	SOC_DAPM_PIN_SWITCH("Internal Mic"),
+	SOC_DAPM_PIN_SWITCH("Speaker"),
 };
 
 static int byt_rt5640_hw_params(struct snd_pcm_substream *substream,
@@ -113,8 +113,8 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 
 	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
 	snd_soc_dapm_enable_pin(dapm, "Headphone");
-	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
-	snd_soc_dapm_enable_pin(dapm, "Int Mic");
+	snd_soc_dapm_enable_pin(dapm, "Speaker");
+	snd_soc_dapm_enable_pin(dapm, "Internal Mic");
 
 	snd_soc_dapm_sync(dapm);
 	return ret;
-- 
1.8.5.3
