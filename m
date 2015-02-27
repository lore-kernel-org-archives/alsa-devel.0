From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Add suspend_pre and resume_post
	for Broadwell snd_soc_card
Date: Fri, 27 Feb 2015 12:54:29 +0800
Message-ID: <1425012869-11429-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 85CC32606DE
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 05:52:05 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

For broadwell machine, we need do some machine related setting before
suspend and after resume, e.g. disable/enable jack detection, here
adding snd_soc_card suspend_pre and resume_post for this task.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/broadwell.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/intel/broadwell.c b/sound/soc/intel/broadwell.c
index fba2ef5..af5d730 100644
--- a/sound/soc/intel/broadwell.c
+++ b/sound/soc/intel/broadwell.c
@@ -225,6 +225,32 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 	},
 };
 
+static int broadwell_suspend(struct snd_soc_card *card){
+	struct snd_soc_codec *codec;
+
+	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
+		if (!strcmp(codec->component.name, "i2c-INT343A:00")) {
+			dev_dbg(codec->dev, "disabling jack detect before going to suspend.\n");
+			rt286_mic_detect(codec, NULL);
+			break;
+		}
+	}
+	return 0;
+}
+
+static int broadwell_resume(struct snd_soc_card *card){
+	struct snd_soc_codec *codec;
+
+	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
+		if (!strcmp(codec->component.name, "i2c-INT343A:00")) {
+			dev_dbg(codec->dev, "enabling jack detect for resume.\n");
+			rt286_mic_detect(codec, &broadwell_headset);
+			break;
+		}
+	}
+	return 0;
+}
+
 /* broadwell audio machine driver for WPT + RT286S */
 static struct snd_soc_card broadwell_rt286 = {
 	.name = "broadwell-rt286",
@@ -238,6 +264,8 @@ static struct snd_soc_card broadwell_rt286 = {
 	.dapm_routes = broadwell_rt286_map,
 	.num_dapm_routes = ARRAY_SIZE(broadwell_rt286_map),
 	.fully_routed = true,
+	.suspend_pre = broadwell_suspend,
+	.resume_post = broadwell_resume,
 };
 
 static int broadwell_audio_probe(struct platform_device *pdev)
-- 
1.9.1
