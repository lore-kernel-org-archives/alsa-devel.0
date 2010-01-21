From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Support turning off bias when the CODEC
	is idle
Date: Thu, 21 Jan 2010 12:05:26 +0000
Message-ID: <1264075526-28039-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 07B3324398
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 13:05:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently ASoC always maintains the bias of the CODEC while the system
is active.  With older mobile CODECs this is required since the outputs
are referenced to a non-zero voltage and enabling or disabling this
voltage without audible pops or clicks in the output takes too long to
do when starting or stopping audio.

As a result of features such as ground referenced outputs and class D
speaker drivers current generation devices are able to power on and off
much more quickly without these system level issues so provide a new
flag idle_bias_off in snd_soc_codec which will cause the core to turn
off the CODEC bias.  The distinction between STANDBY and OFF is still
maintained.  This is partly for consistency but also allows for
potential future extensions such as per-machine overrides or deferring
the bias removal.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-dapm.c |   25 ++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 08909cc..a8768ea 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -405,6 +405,8 @@ struct snd_soc_codec {
 	short reg_cache_size;
 	short reg_cache_step;
 
+	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
+
 	/* dapm */
 	u32 pop_time;
 	struct list_head dapm_widgets;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d8e9374..6c33510 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1012,13 +1012,28 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 			sys_power = 0;
 			break;
 		case SND_SOC_DAPM_STREAM_NOP:
-			sys_power = codec->bias_level != SND_SOC_BIAS_STANDBY;
+			switch (codec->bias_level) {
+				case SND_SOC_BIAS_STANDBY:
+				case SND_SOC_BIAS_OFF:
+					sys_power = 0;
+					break;
+				default:
+					sys_power = 1;
+					break;
+			}
 			break;
 		default:
 			break;
 		}
 	}
 
+	if (sys_power && codec->bias_level == SND_SOC_BIAS_OFF) {
+		ret = snd_soc_dapm_set_bias_level(socdev,
+						  SND_SOC_BIAS_STANDBY);
+		if (ret != 0)
+			pr_err("Failed to turn on bias: %d\n", ret);
+	}
+
 	/* If we're changing to all on or all off then prepare */
 	if ((sys_power && codec->bias_level == SND_SOC_BIAS_STANDBY) ||
 	    (!sys_power && codec->bias_level == SND_SOC_BIAS_ON)) {
@@ -1042,6 +1057,14 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 			pr_err("Failed to apply standby bias: %d\n", ret);
 	}
 
+	/* If we're in standby and can support bias off then do that */
+	if (codec->bias_level == SND_SOC_BIAS_STANDBY &&
+	    codec->idle_bias_off) {
+		ret = snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_OFF);
+		if (ret != 0)
+			pr_err("Failed to turn off bias: %d\n", ret);
+	}
+
 	/* If we just powered up then move to active bias */
 	if (codec->bias_level == SND_SOC_BIAS_PREPARE && sys_power) {
 		ret = snd_soc_dapm_set_bias_level(socdev,
-- 
1.6.6
