From: sathyanarayana.nujella@intel.com
Subject: [PATCH] ASoC: Intel: update bxt_da7219_max98357a to
	support quad ch dmic capture
Date: Tue,  6 Dec 2016 07:08:36 -0800
Message-ID: <20161206150836.32526-1-sathyanarayana.nujella@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5574C26705F
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2016 16:08:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, harshapriya.n@intel.com, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

This patch updates FE channel constraints & BE fixup to support
quad channel DMIC capture.
DMIC pin's BE fixup is configured based on channel input, i.e.
either stereo or quad.

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index bff80b4..3a8c24a 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -30,6 +30,7 @@
 #define BXT_DIALOG_CODEC_DAI	"da7219-hifi"
 #define BXT_MAXIM_CODEC_DAI	"HiFi"
 #define DUAL_CHANNEL		2
+#define QUAD_CHANNEL		4
 
 static struct snd_soc_jack broxton_headset;
 
@@ -182,6 +183,16 @@ static struct snd_pcm_hw_constraint_list constraints_channels = {
 	.mask = 0,
 };
 
+static unsigned int channels_quad[] = {
+	QUAD_CHANNEL,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_channels_quad = {
+	.count = ARRAY_SIZE(channels_quad),
+	.list = channels_quad,
+	.mask = 0,
+};
+
 static int bxt_fe_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -258,7 +269,10 @@ static int broxton_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 {
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
-	channels->min = channels->max = DUAL_CHANNEL;
+	if (params_channels(params) == 2)
+		channels->min = channels->max = 2;
+	else
+		channels->min = channels->max = 4;
 
 	return 0;
 }
@@ -267,9 +281,9 @@ static int broxton_dmic_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	runtime->hw.channels_max = DUAL_CHANNEL;
+	runtime->hw.channels_min = runtime->hw.channels_max = QUAD_CHANNEL;
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-			&constraints_channels);
+			&constraints_channels_quad);
 
 	return snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
-- 
2.8.4
