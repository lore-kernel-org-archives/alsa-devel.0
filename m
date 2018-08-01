From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH] ASoC: Intel: bxt: Use refcap device for mono
	recording
Date: Wed,  1 Aug 2018 10:03:59 -0700
Message-ID: <1533143039-5428-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id CA6D12677AA
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 19:05:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, pierre-louis.bossart@linux.intel.com
Cc: harshapriya.n@intel.com, naveen.m@intel.com, alsa-devel@alsa-project.org, jenny.tc@intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

The refcap capture device supports mono recording only, this patch
adds the channel constraints, also change stream_name to "Wake on Voice".

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index be6e4b4..097a089 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -319,6 +319,15 @@ static const unsigned int rates_16000[] = {
 	16000,
 };
 
+static const unsigned int ch_mono[] = {
+	1,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_refcap = {
+	.count = ARRAY_SIZE(ch_mono),
+	.list  = ch_mono,
+};
+
 static const struct snd_pcm_hw_constraint_list constraints_16000 = {
 	.count = ARRAY_SIZE(rates_16000),
 	.list  = rates_16000,
@@ -326,6 +335,11 @@ static const struct snd_pcm_hw_constraint_list constraints_16000 = {
 
 static int broxton_refcap_startup(struct snd_pcm_substream *substream)
 {
+	substream->runtime->hw.channels_max = 1;
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_refcap);
+
 	return snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE,
 			&constraints_16000);
@@ -372,7 +386,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 	[BXT_DPCM_AUDIO_REF_CP] =
 	{
 		.name = "Bxt Audio Reference cap",
-		.stream_name = "Refcap",
+		.stream_name = "Wake on Voice",
 		.cpu_dai_name = "Reference Pin",
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
-- 
2.7.4
